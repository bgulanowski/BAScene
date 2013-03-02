//
//  BAProp.h
//  BAScene
//
//  Created by Brent Gulanowski on 30/05/09.
//  Copyright 2009 Bored Astronaut. All rights reserved.
//

#import <BAScene/_BAProp.h>

#import <BAScene/BACamera.h>


@interface BAProp : _BAProp<BAVisible> {
    BARegionf _bounds;
	id userInfo;
    BOOL boundsLoaded;
    BOOL boundsDirty;
	BOOL hasColor;
}

@property (retain) id userInfo;
@property (nonatomic, readonly) BARegionf bounds;

- (void)update;

+ (void)setLastInterval:(NSTimeInterval)interval;

+ (BAProp *)propWithName:(NSString *)aName create:(BOOL*)create;
+ (BAProp *)propWithName:(NSString *)aName;
// This calls the above and will clobber existing prototype/xform if a prop already exists by that name
+ (BAProp *)propWithName:(NSString *)aName prototype:(BAPrototype *)proto transform:(BATransform *)xform;
+ (BAProp *)propWithName:(NSString *)aName prototype:(BAPrototype *)proto; // calls the above with new default transform
+ (BAProp *)propWithName:(NSString *)aName byMergingProps:(NSSet *)props;

+ (BAProp *)findPropWithName:(NSString *)aName;

- (GLfloat)distanceForCameraLocation:(BAPointf)cloc;
- (GLfloat)zDistanceForCameraLocation:(BAPointf)cloc;

- (NSSet *)transformedMeshes;
- (NSSet *)transformedPolygons;

- (void)recalculateBounds;
- (void)loadBounds;

@end
