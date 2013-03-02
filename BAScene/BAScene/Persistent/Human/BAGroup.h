//
//  BAGroup.h
//  BAScene
//
//  Created by Brent Gulanowski on 30/05/09.
//  Copyright 2009 Bored Astronaut. All rights reserved.
//

#import <BAScene/_BAGroup.h>

#import <BAScene/BACamera.h>


@interface BAGroup : _BAGroup<BAPropContainer> {
    BAProp *_mergedProp;
    BARegionf bounds;
    BOOL boundsLoaded;
    BOOL boundsDirty;
}

@property (nonatomic, readonly) BAProp *mergedProp;
@property (nonatomic) BARegionf bounds;

+ (BAGroup *)groupWithSuperGroup:(BAGroup *)aSupergroup;
+ (BAGroup *)findGroupWithName:(NSString *)aName;

- (void)update:(NSTimeInterval)interval;
- (void)updateProps:(NSTimeInterval)interval;
- (void)compileProps;
- (void)mergeProps;
- (void)flattenPropsWithBlock:(BOOL(^)(BAProp *prop))block;
- (void)loadBounds;
- (void)recalculateBounds;

@end
