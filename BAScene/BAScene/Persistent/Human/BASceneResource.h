//
//  BASceneResource.h
//  BAScene
//
//  Created by Brent Gulanowski on 31/12/10.
//  Copyright 2008-2011 Bored Astronaut. All rights reserved.
//

#import "_BASceneResource.h"

@interface BASceneResource : _BASceneResource {
	NSData *data;
	BOOL loadFailed;
}

@property (nonatomic, retain) NSData *data;

@end


@interface BASceneResource (BAResourceDeprecated)

+ (BASceneResource *)resourceWithType:(int)aType data:(NSData *)sourceData DEPRECATED_ATTRIBUTE;
+ (BASceneResource *)resourceWithType:(int)aType uniqueID:(NSData *)uuid DEPRECATED_ATTRIBUTE;

@end


@interface NSManagedObjectContext (BAResourceCreating)

- (BASceneResource *)resourceWithType:(int)aType data:(NSData *)sourceData; // always creates a new resource
- (BASceneResource *)resourceWithType:(int)aType uniqueID:(NSData *)uuid; // always searches for existing resource

@end