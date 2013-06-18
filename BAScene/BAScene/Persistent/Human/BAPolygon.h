//
//  BAPolygon.h
//  BAScene
//
//  Created by Brent Gulanowski on 11/10/08.
//  Copyright 2008 Bored Astronaut. All rights reserved.
//

#import <BAScene/_BAPolygon.h>

#import <BAScene/BACamera.h>


@class BATransform;

@interface BAPolygon : _BAPolygon
#if TARGET_OS_IPHONE
<NSMutableCopying>
#else
<BAVisible, NSMutableCopying>
#endif
{
}

@property (readonly) NSArray *orderedPoints;
@property (readonly) NSArray *orderedVertices;

- (void)addPointWithX:(double)x y:(double)y z:(double)z index:(UInt16)index;

- (BAPolygon *)applyTransform:(BATransform *)transform; // returns self
- (BAPolygon *)transformedPolygon:(BATransform *)transform; // returns a new polygon

- (void)setColor:(BAColor *)aColor;

@end


@interface BAPolygon (BAPolygonDeprecated)

+ (BAPolygon *)polygon DEPRECATED_ATTRIBUTE;
+ (BAPolygon *)polygonWithPoints:(NSSet *)indices DEPRECATED_ATTRIBUTE;
+ (NSSet *)polygonsWithSize:(NSUInteger)size vertices:(NSArray *)vertices texCoords:(NSArray *)texCoords indices:(NSUInteger *)indices tcIndices:(NSUInteger *)tcIndices count:(NSUInteger)count DEPRECATED_ATTRIBUTE;
+ (NSSet *)polygonsWithSize:(NSUInteger)size vertices:(NSArray *)vertices indices:(NSUInteger *)indices count:(NSUInteger)count DEPRECATED_ATTRIBUTE;
+ (BAPolygon *)polygonWithTriangle:(BATriangle)tri DEPRECATED_ATTRIBUTE;
+ (BAPolygon *)polygonWithQuad:(BAQuad)quad DEPRECATED_ATTRIBUTE;

@end


@interface NSManagedObjectContext (BAPolygonCreating)

- (BAPolygon *)polygonWithPoints:(NSSet *)indices;
- (NSSet *)polygonsWithSize:(NSUInteger)size vertices:(NSArray *)vertices texCoords:(NSArray *)texCoords indices:(NSUInteger *)indices tcIndices:(NSUInteger *)tcIndices count:(NSUInteger)count;
- (NSSet *)polygonsWithSize:(NSUInteger)size vertices:(NSArray *)vertices indices:(NSUInteger *)indices count:(NSUInteger)count;
- (BAPolygon *)polygonWithTriangle:(BATriangle)tri;
- (BAPolygon *)polygonWithQuad:(BAQuad)quad;

@end
