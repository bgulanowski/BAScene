//
//  BAScene.m
//  BAScene
//
//  Created by Brent Gulanowski on 11/10/08.
//  Copyright (c) 2008-2014 Bored Astronaut. All rights reserved.
//

#import <BAScene/BAScene.h>

#import <BAScene/BACamera.h>


@implementation BAScene

@synthesize stage=_stage;
@synthesize activeCameras=_activeCameras;
@synthesize lastUpdate=_lastUpdate;
@synthesize updateQueue;

#pragma mark - Accessors

- (NSSet *)activeCameras {
	
	__block NSSet *cameras;
	
	if(updateQueue)
		dispatch_sync(updateQueue, ^{ cameras = [_activeCameras copy]; });
	else
		cameras = [_activeCameras copy];

	return [cameras autorelease];
}

- (void)setUpdateQueue:(dispatch_queue_t)newQueue {
    if(updateQueue)
        dispatch_release(updateQueue);
    updateQueue = newQueue;
    if(updateQueue)
        dispatch_retain(updateQueue);
}

- (void)addActiveCamerasObject:(BACamera *)camera {
    dispatch_async(updateQueue ?: dispatch_get_main_queue(), ^{
        [_activeCameras addObject:camera];
    });
}

- (void)removeActiveCamerasObject:(BACamera *)camera {
    dispatch_async(updateQueue ?: dispatch_get_main_queue(), ^{
        [_activeCameras removeObject:camera];
    });
}

- (void)removeActiveCameras:(NSSet *)objects {
    dispatch_async(updateQueue ?: dispatch_get_main_queue(), ^{
        [_activeCameras minusSet:objects];
    });
}

- (void)addActiveCameras:(NSSet *)objects {
    dispatch_async(updateQueue ?: dispatch_get_main_queue(), ^{
        [_activeCameras unionSet:objects];
    });
}

- (BAStage *)stage {
	if (!_stage) {
		@synchronized(self) {
			if(!_stage)
				_stage = self.context.stage;
		}
	}
	return _stage;
}

#pragma mark - NSObject

- (void)dealloc {
    self.updateQueue = NULL;
    [super dealloc];
}

- (id)init {
	self = [super init];
	if(self) {
        self.model = [[self class] sceneModel];
		self.stage = [self.context stage];
        _activeCameras = [[NSMutableSet alloc] init];
	}
	return self;
}

- (void)startUpdates:(BOOL (^)(BAScene *scene, NSTimeInterval interval))updateBlock {
    
    if(!updateQueue)
		self.updateQueue = dispatch_queue_create("BAScene_update", DISPATCH_QUEUE_SERIAL);

    dispatch_once(&updateToken, ^{

        _lastUpdate = [NSDate timeIntervalSinceReferenceDate];
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, updateQueue);
        
        int64_t delta = NSEC_PER_SEC/100;
        
        dispatch_source_set_event_handler(timer, ^{
            
            NSTimeInterval lastUpdate = _lastUpdate;
            NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
            
            _lastUpdate = now;
            
            if(updateBlock(self, now - lastUpdate))
                dispatch_async(dispatch_get_main_queue(), ^{ [self cancelUpdates]; });
        });
        dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, 0), delta, NSEC_PER_USEC/10000);

        [self resumeUpdates];
    });
}

- (void)startUpdates {
    [self startUpdates:^BOOL(BAScene *scene, NSTimeInterval interval) {
        for (BACamera *camera in _activeCameras)
            [camera update:interval];
        [self.stage update:interval];
        return [scene update:interval];
    }];
}

- (void)pauseUpdates {
    if(timer)
        dispatch_suspend(timer);
}

- (void)resumeUpdates {
    if(timer)
        dispatch_resume(timer);
}

- (void)cancelUpdates {
    if(timer) {
        dispatch_source_cancel(timer);
        timer = NULL;
        updateToken = 0;
    }
}

- (BOOL)update:(NSTimeInterval)interval { return NO; }


#pragma mark - BACoreDataManager
+ (NSString *)defaultStoreExtension { return @"bascene"; }


#pragma mark - BAScene

+ (NSManagedObjectModel *)sceneModel {
    static NSManagedObjectModel *sceneModel;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path = [[NSBundle bundleForClass:[BAScene class]] pathForResource:@"BAScene" ofType:@"mom"];
        sceneModel = path ? [[NSManagedObjectModel alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path]] : nil;
    });
	return sceneModel;
}

@end
