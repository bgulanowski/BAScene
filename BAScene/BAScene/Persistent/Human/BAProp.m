//
//  BAProp.h
//  BAScene
//
//  Created by Brent Gulanowski on 30/05/09.
//  Copyright 2009 Bored Astronaut. All rights reserved.
//

#import "BAProp.h"

#import "BAColor.h"
#import "BAPoint.h"
#import "BAPolygon.h"
#import "BAPrototype.h"
#import "BAPrototypeMesh.h"
#import "BATransform.h"
#import "BAMesh.h"


static NSTimeInterval gInterval = 0;

@implementation BAProp

@synthesize userInfo, bounds=_bounds;

#pragma mark NSObject
- (void)dealloc {
	self.userInfo = nil;
	[super dealloc];
}


#pragma mark NSManagedObject
- (void)awakeFromFetch {
	[super awakeFromFetch];
	[self.transform rebuild];
}


#pragma mark BAVisible
- (void)paintForCamera:(BACamera *)camera {
	glPushMatrix();
	[self.transform apply];
	if(hasColor) {
        BAColorf colorValues = self.color->values;
        glColor4f(colorValues.c.r, colorValues.c.g, colorValues.c.b, colorValues.c.a);
    }
	for(BAPrototypeMesh *pm in self.prototype.prototypeMeshes)
		pm->appliesColor = !hasColor;
	[self.prototype paintForCamera:camera];
	glPopMatrix();
}

- (void)setColor:(BAColor *)aColor {
	[self setPrimitiveColor:aColor];
	hasColor = (nil != aColor);
}

- (GLfloat)distanceForCameraLocation:(BAPointf)cloc {
	
	BAPoint4f tloc = [self.transform location].p;
	BAPointf diff = BASubtractVectors3(*(BAPointf*)&tloc, *(BAPointf*)&cloc);
	
	return BADotProductVectors3(diff, diff);
}

- (GLfloat)zDistanceForCameraLocation:(BAPointf)cloc {
	
	BAPoint4f tloc = [self.transform location].p;
	BAPointf diff = BASubtractVectors3(*(BAPointf*)&tloc, *(BAPointf*)&cloc);
	BAPointf cross = BACrossProductVectors3(diff, *(BAPointf*)&tloc);
	
	return BADotProductVectors3(diff, diff) - BADotProductVectors3(cross, cross)/BADotProductVectors3(*(BAPointf*)&cloc, *(BAPointf*)&cloc);
}



#pragma mark Factories
+ (BAProp *)propWithName:(NSString *)aName create:(BOOL*)create {

	BAProp *prop = [BAActiveContext objectForEntityNamed:@"Prop" matchingValue:aName forKey:@"name" create:create];
	
	if(create && *create)
		prop.transform = [BATransform transform];
	
	return prop;
}

+ (BAProp *)propWithName:(NSString *)aName {
	BOOL create = YES;
	return [self propWithName:aName create:&create];
}

+ (BAProp *)propWithName:(NSString *)aName prototype:(BAPrototype *)proto transform:(BATransform *)xform {
	
	BOOL create = YES;
	BAProp *prop = [self propWithName:aName create:&create];
	
	if(create) {
		prop.prototype = proto;
		prop.transform = xform;
	}
	
	return prop;
}

+ (BAProp *)propWithName:(NSString *)aName prototype:(BAPrototype *)proto {
	return [self propWithName:aName prototype:proto transform:[BATransform transform]];
}

+ (BAProp *)propWithName:(NSString *)aName byMergingProps:(NSSet *)props {
	
    NSManagedObjectContext *context = [[props anyObject] managedObjectContext];
	BAMesh *mesh = [BAMesh meshWithName:nil];
	
	for(BAProp *prop in props) {
		for(BAMesh *xMesh in [prop transformedMeshes]) {
			[mesh addPolygons:xMesh.polygons]; // sets mesh relation of all polys to the new mesh; xmesh will have no polys
			[context deleteObject:xMesh];
		}
	}
    
    if([[[[mesh.polygons anyObject] points] anyObject] normal] != nil)
        mesh.hasNormalsValue = YES;

	
	return [self propWithName:aName prototype:[BAPrototype prototypeWithName:nil mesh:mesh]];
}


#pragma mark New
+ (BAProp *)findPropWithName:(NSString *)aName {
	return [self propWithName:aName create:NULL];
}

- (void)update {
	// TODO: animation support
	[self.transform rotateX:0 y:1 z:0];
}

- (NSSet *)transformedMeshes {
	
	NSMutableSet *results = [NSMutableSet set];
	
	for(BAPrototypeMesh *ptm in self.prototype.prototypeMeshes) {
		BAMesh *it = [ptm transformedMesh];
		[it applyTransform:self.transform];
		[results addObject:it];
	}
	
	return results;
}

- (NSSet *)transformedPolygons {
	
	NSMutableSet *results = [NSMutableSet setWithCapacity:[[self valueForKeyPath:@"prototype.prototypeMeshes.@distinctUnionOfSets.mesh.polygons"] count]];
	
	for(BAPrototypeMesh *ptm in self.prototype.prototypeMeshes)
		for(BAPolygon *poly in [ptm transformedPolygons])
			[results addObject:[poly applyTransform:self.transform]];
	
	return results;
}

+ (void)setLastInterval:(NSTimeInterval)interval {
	gInterval = interval;
}

- (void)loadBounds {
    
    NSData *data = [self boundsData];
    
    if(nil != data) {
        
        NSValue *value = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        [value getValue:&_bounds];
    }
    
    boundsLoaded = YES;
}

- (void)recalculateBounds {
    
    
}

@end
