//
//  BAStage.h
//  BAScene
//
//  Created by Brent Gulanowski on 01/06/09.
//  Copyright 2009 Bored Astronaut. All rights reserved.
//

#import <BAScene/_BAStage.h>

#import <BAScene/BACamera.h>


@class BAProp, BAGroup;

@interface BAStage : _BAStage<BACameraDrawDelegate, BAPropContainer> {}

- (void)addProp:(BAProp *)aProp;
- (void)removeProp:(BAProp *)aProp;
- (void)addGroup:(BAGroup *)aGroup;
- (void)removeGroup:(BAGroup *)aGroup;

- (void)update:(NSTimeInterval)interval;

@end


@interface BAStage (BAStageDeprecated)
+ (BAStage *)stage DEPRECATED_ATTRIBUTE;
@end


@interface NSManagedObjectContext (BAStageCreating)
- (BAStage *)stage; // returns unique instance
@end
