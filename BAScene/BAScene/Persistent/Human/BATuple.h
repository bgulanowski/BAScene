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

- (void)takeValuesFromPoint:(BAPointf)point;
- (void)takeValuesFromPoint4f:(BAPoint4f)point;
- (BAPointf)pointf;
- (BAPoint4f)point4f;

- (void)applyMatrixTransform:(BAMatrix4x4f)matrix;

- (id)applyTransform:(BATransform *)transform;
- (BATuple *)transformedTuple:(BATransform *)transform;

@end


@interface BATuple (BATupleDeprecated)

+ (BATuple *)tupleWithPoint:(BAPointf)point DEPRECATED_ATTRIBUTE;
+ (BATuple *)tupleWithPoint4f:(BAPoint4f)point DEPRECATED_ATTRIBUTE;
+ (BATuple *)tupleWithX:(double)x y:(double)y z:(double)z DEPRECATED_ATTRIBUTE;
+ (NSArray *)tuplesWithPointArray:(BAPointf *)points count:(NSUInteger)count DEPRECATED_ATTRIBUTE;

@end


@interface NSManagedObjectContext (BATupleCreating)

- (BATuple *)tupleWithPoint:(BAPointf)point;
- (BATuple *)tupleWithPoint4f:(BAPoint4f)point;
- (BATuple *)tupleWithX:(double)x y:(double)y z:(double)z;
- (NSArray *)tuplesWithPointArray:(BAPointf *)points count:(NSUInteger)count;

@end