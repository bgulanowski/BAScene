//
//  BAPolygon.h
//  BAScene
//
//  Created by Brent Gulanowski on 11/10/08.
//  Copyright 2008 Bored Astronaut. All rights reserved.
//

#import "BAPolygon.h"

#import "BAColor.h"
#import "BAMesh.h"
#import "BATuple.h"
#import "BAPoint.h"

#import "NSArray+BAAdditions.h"


@interface BAPolygon ()

- (void)makeNormals;

@end


@implementation BAPolygon

@dynamic orderedPoints;
@dynamic orderedVertices;


NSArray *pointSort;
NSArray *vertexSort;

#pragma mark NSObject
+ (void)initialize {
	if([self class] == [BAPolygon class]) {
		pointSort = [[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES]] retain];
		vertexSort = [[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"point.index" ascending:YES]] retain];
	}
}


#pragma mark NSMutableCopying
- (id)mutableCopyWithZone:(NSZone *)zone {
	
	NSMutableSet *newPoints = [NSMutableSet setWithCapacity:[self.points count]];
	BAPolygon *polygon = [[self managedObjectContext] insertBAPolygon];

	for(BAPoint *point in self.points)
		[newPoints addObject:[[point mutableCopyWithZone:zone] autorelease]];
	
	polygon.points = newPoints;
	polygon.a = self.a;
	polygon.b = self.b;
	polygon.c = self.c;
	
	return [polygon retain];
}


#pragma mark - Factories (DEPRECATED)
+ (BAPolygon *)polygon {
    BAAssertActiveContext();
    return [BAActiveContext insertBAPolygon];
}

+ (BAPolygon *)polygonWithPoints:(NSSet *)points {
	BAAssertActiveContext();
    return [BAActiveContext polygonWithPoints:points];
}

+ (NSSet *)polygonsWithSize:(NSUInteger)size vertices:(NSArray *)vertices texCoords:(NSArray *)texCoords indices:(NSUInteger *)indices tcIndices:(NSUInteger *)tcIndices count:(NSUInteger)count {
	BAAssertActiveContext();
    return [BAActiveContext polygonsWithSize:size vertices:vertices texCoords:texCoords indices:indices tcIndices:tcIndices count:count];
}

+ (NSSet *)polygonsWithSize:(NSUInteger)size vertices:(NSArray *)vertices indices:(NSUInteger *)indices count:(NSUInteger)count {
    BAAssertActiveContext();
    return [BAActiveContext polygonsWithSize:size vertices:vertices indices:indices count:count];
}

+ (BAPolygon *)polygonWithTriangle:(BATriangle)tri {
	BAAssertActiveContext();
    return [BAActiveContext polygonWithTriangle:tri];
}

+ (BAPolygon *)polygonWithQuad:(BAQuad)quad {
	BAAssertActiveContext();
    return [BAActiveContext polygonWithQuad:quad];
}

- (void)addPointWithX:(double)x y:(double)y z:(double)z index:(UInt16)index {
	
	BATuple *point = [self.managedObjectContext tupleWithX:x y:y z:z];
	BAPoint *pointIndex = [self.managedObjectContext pointWithVertex:point index:index];
	
	pointIndex.polygon = self;
}


- (NSArray *)orderedPoints {
    return [self.points sortedArrayUsingDescriptors:pointSort];
}

- (NSArray *)orderedVertices {
    return [self.orderedPoints valueForKey:@"vertex"];
}


#if ! TARGET_OS_IPHONE
#pragma mark BAVisible
- (void)paintForCamera:(BACamera *)camera {
	
	BOOL doColor = self.mesh->appliesColor;
	BOOL doTex = self.mesh.hasTextureValue;
	BAPointf texCoord, vertex, normal;
	
	glBegin( GL_POLYGON );
	
	for(BAPoint *point in [self orderedPoints])	{
		
		if(doColor)
			glColor3fv(point.color->values.i);

		if(doTex && [point texCoord]) {
			texCoord = [[point texCoord] pointf];
			glTexCoord2d(texCoord.x, texCoord.y);
		}
		
		if([point normal]) {
			normal = [[point normal] pointf];
			glNormal3d(normal.x, normal.y, normal.z);
		}
		
		vertex = [[point vertex] pointf];
		glVertex3d(vertex.x, vertex.y, vertex.z);
	}
	
	glEnd();

	if(drawNormals) {
		glBegin(GL_LINES);
		for(BAPoint *point in [self orderedPoints])	{
			BAPointf vertex = [[point vertex] pointf];
			BAPointf normal = [[point normal] pointf];
			glVertex3d(vertex.x, vertex.y, vertex.z);
			glVertex3d(vertex.x + 0.25f * normal.x, vertex.y + 0.25f * normal.y, vertex.z + 0.25f * normal.z);
		}
		glEnd();
	}
}
#endif

- (void)setColor:(BAColor *)aColor {
	[self.points makeObjectsPerformSelector:@selector(setColor:) withObject:aColor];
}


#pragma mark Private
- (void)makeNormals {
	
	NSArray *points = [self orderedPoints];
	BAPoint *p0 = [points objectAtIndex:0], *p1 = [points objectAtIndex:1], *p2 = [points objectAtIndex:2];
	BAVector3 normal = BANormalizeVector3(BACrossProductVectors3(BASubtractVectors3([[p0 vertex] pointf], [[p2 vertex] pointf]),
																 BASubtractVectors3([[p1 vertex] pointf], [[p0 vertex] pointf])));
	BATuple *tuple = [self.managedObjectContext tupleWithPoint:normal];
	
	[tuple addNPoints:[NSSet setWithArray:points]];
}


#pragma mark Transforms
- (id)applyTransform:(BATransform *)transform {
	for(BAPoint *point in self.points) {
		
		// If the tuple (vertex) has only one related point, replace it; otherwise, add a new one
		BATuple *vertex = [point vertex];

		if([vertex.vPoints count] == 1)
			[vertex applyTransform:transform];
		else
			[point setVertex:[vertex transformedTuple:transform]];
	}
	
	return self;
}

- (BAPolygon *)transformedPolygon:(BATransform *)transform {
	return [(BAPolygon *)[[self mutableCopy] autorelease] applyTransform:transform];
}

@end


@implementation NSManagedObjectContext (BAPolygonCreating)

- (BAPolygon *)polygonWithPoints:(NSSet *)points {
	
	BAPolygon *poly = [self insertBAPolygon];
	
	[poly setPoints:points];
	[poly makeNormals];
	
	return poly;
}

- (NSSet *)polygonsWithSize:(NSUInteger)size vertices:(NSArray *)vertices texCoords:(NSArray *)texCoords indices:(NSUInteger *)indices tcIndices:(NSUInteger *)tcIndices count:(NSUInteger)count {
	
	NSMutableSet *result = [NSMutableSet set];
	
	for(NSUInteger i=0;i<count;++i)
		[result addObject:[self polygonWithPoints:[self pointsWithWithVertices:[vertices objectsWithIndexArray:indices + i*size count:size]
                                                                     texCoords:[texCoords objectsWithIndexArray:tcIndices + i*size count:size]
                                                                         count:size]]];
	
	return result;
}

- (NSSet *)polygonsWithSize:(NSUInteger)size vertices:(NSArray *)vertices indices:(NSUInteger *)indices count:(NSUInteger)count {
	return [self polygonsWithSize:size vertices:vertices texCoords:nil indices:indices tcIndices:NULL count:count];
}

- (BAPolygon *)polygonWithTriangle:(BATriangle)tri {
	
	BAPolygon *poly = [self insertBAPolygon];
	
	[poly addPointWithX:tri.a.x y:tri.a.y z:tri.a.z index:0];
	[poly addPointWithX:tri.b.x y:tri.b.y z:tri.b.z index:1];
	[poly addPointWithX:tri.c.x y:tri.c.y z:tri.c.z index:2];
	
	[poly makeNormals];
    
	return poly;
}

- (BAPolygon *)polygonWithQuad:(BAQuad)quad {
	
	BAPolygon *poly = [self insertBAPolygon];
	
	[poly addPointWithX:quad.a.x y:quad.a.y z:quad.a.z index:0];
	[poly addPointWithX:quad.b.x y:quad.b.y z:quad.b.z index:1];
	[poly addPointWithX:quad.c.x y:quad.c.y z:quad.c.z index:2];
	[poly addPointWithX:quad.d.x y:quad.d.y z:quad.d.z index:3];
	
	[poly makeNormals];
    
	return poly;
}


@end