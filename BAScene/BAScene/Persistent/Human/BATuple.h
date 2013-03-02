//
//  BAPoint.h
//  BAScene
//
//  Created by Brent Gulanowski on 5/4/09.
//  Copyright 2009 Bored Astronaut. All rights reserved.
//

#import <BAScene/_BATuple.h>

#import <BAScene/BASceneTypes.h>


typedef enum {
	kBAUndefinedTuple = 0,
	kBAVertexTuple = 1,
	kBANormalTuple = 2,
	kBATextureTuple = 3,
	kBAColorTuple = 4, // unused
} BATupleType;


@class BATransform;

@interface BATuple : _BATuple<NSMutableCopying> {}

+ (BATuple *)tupleWithPoint:(BAPointf)point;
+ (BATuple *)tupleWithPoint4f:(BAPoint4f)point;
+ (BATuple *)tupleWithX:(double)x y:(double)y z:(double)z;
+ (NSArray *)tuplesWithPointArray:(BAPointf *)points count:(NSUInteger)count;

- (void)takeValuesFromPoint:(BAPointf)point;
- (void)takeValuesFromPoint4f:(BAPoint4f)point;
- (BAPointf)pointf;
- (BAPoint4f)point4f;

- (void)applyMatrixTransform:(BAMatrix4x4f)matrix;

- (id)applyTransform:(BATransform *)transform;
- (BATuple *)transformedTuple:(BATransform *)transform;

@end
