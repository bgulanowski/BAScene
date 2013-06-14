//
//  BAPropGroup.h
//  BAScene
//
//  Created by Brent Gulanowski on 30/05/09.
//  Copyright 2009 Bored Astronaut. All rights reserved.
//

#import <BAScene/_BAPropGroup.h>

#import <BAScene/BACamera.h>


@interface BAPropGroup : _BAPropGroup<BAPropContainer> {
    BAProp *_mergedProp;
    BARegionf bounds;
    BOOL boundsLoaded;
    BOOL boundsDirty;
}

@property (nonatomic, readonly) BAProp *mergedProp;
@property (nonatomic) BARegionf bounds;

- (void)update:(NSTimeInterval)interval;
- (void)updateProps:(NSTimeInterval)interval;
- (void)compileProps;
- (void)mergeProps;
- (void)flattenPropsWithBlock:(BOOL(^)(BAProp *prop))block;
- (void)loadBounds;
- (void)recalculateBounds;

@end

@interface BAPropGroup (BAGroupDeprecated)

+ (BAPropGroup *)groupWithSuperGroup:(BAPropGroup *)aSupergroup DEPRECATED_ATTRIBUTE;
+ (BAPropGroup *)findGroupWithName:(NSString *)aName DEPRECATED_ATTRIBUTE;

@end


@interface NSManagedObjectContext (BAGroupCreating)

- (BAPropGroup *)groupWithSuperGroup:(BAPropGroup *)aSupergroup;
- (BAPropGroup *)findGroupWithName:(NSString *)aName;

@end
