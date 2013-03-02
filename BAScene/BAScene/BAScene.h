//
//  BAScene.h
//  BAScene
//
//  Created by Brent Gulanowski on 11/10/08.
//  Copyright 2008 Bored Astronaut. All rights reserved.
//


#import <BAFoundation/BACoreDataManager.h>

#import <BAScene/BASceneUtilities.h>
#import <BAScene/BASceneConstants.h>

#import <BAScene/BACamera.h>
#import <BAScene/BAColor.h>
#import <BAScene/BAPolygon.h>

#import <BAScene/BAPoint.h>
#import <BAScene/BATuple.h>
#import <BAScene/BAMesh.h>
#import <BAScene/BAPartition.h>
#import <BAScene/BAPrototype.h>
#import <BAScene/BAProp.h>
#import <BAScene/BAGroup.h>
#import <BAScene/BAStage.h>
#import <BAScene/BAScenePref.h>
#import <BAScene/BATransform.h>


@interface BAScene : BACoreDataManager {
    NSTimeInterval _lastUpdate;
    dispatch_queue_t updateQueue;
    dispatch_once_t  updateToken;
    dispatch_source_t timer;
}

@property (nonatomic, readonly) NSTimeInterval lastUpdate;
@property (nonatomic, assign) dispatch_queue_t updateQueue;

// updateBlock should return YES to stop updates
- (void)startUpdates:(BOOL (^)(BAScene *scene, NSTimeInterval interval))updateBlock;
- (void)pauseUpdates;
- (void)resumeUpdates;
- (void)cancelUpdates;

+ (NSManagedObjectModel *)sceneModel;

@end
