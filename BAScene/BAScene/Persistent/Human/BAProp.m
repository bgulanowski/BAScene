//
//  BAProp.h
//  BAScene
//
//  Created by Brent Gulanowski on 30/05/09.
//  Copyright (c) 2009-2014 Bored Astronaut. All rights reserved.
//

#import <BAScene/BAProp.h>

#import <BAScene/BAColor.h>
#import <BAScene/BAPoint.h>
#import <BAScene/BAPolygon.h>
#import <BAScene/BAPrototype.h>
#import <BAScene/BAPrototypeMesh.h>
#import <BAScene/BATransform.h>
#import <BAScene/BAMesh.h>

#import <BAScene/BASceneUtilities.h>

#if TARGET_OS_IPHONE
#import <OpenGLES/ES1/gl.h>
#else
#import <OpenGL/gl.h>
#endif

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
	[self.transform applyWithCamera:camera];

	if(hasColor) {
        BAColorf colorValues = self.color->values;
        glColor4f(colorValues.c.r, colorValues.c.g, colorValues.c.b, colorValues.c.a);
    }

	for(BAPrototypeMesh *pm in self.prototype.prototypeMeshes)
		pm->appliesColor = !hasColor;
	[self.prototype paintForCamera:camera];
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
    BAAssertActiveContext();
    if(create && *create)
        return [BAActiveContext propWithName:aName];
    else
        return [BAActiveContext findPropWithName:aName];
}

+ (BAProp *)propWithName:(NSString *)aName {
    BAAssertActiveContext();
    return [BAActiveContext propWithName:aName];
}

+ (BAProp *)propWithName:(NSString *)aName prototype:(BAPrototype *)proto transform:(BATransform *)xform {
	BAAssertActiveContext();
    return [BAActiveContext propWithName:aName prototype:proto transform:xform];
}

+ (BAProp *)propWithName:(NSString *)aName prototype:(BAPrototype *)proto {
    BAAssertActiveContext();
	return [BAActiveContext propWithName:aName prototype:proto];
}

+ (BAProp *)propWithName:(NSString *)aName byMergingProps:(NSSet *)props {
	BAAssertActiveContext();
    return [BAActiveContext propWithName:aName byMergingProps:props];
}


#pragma mark New
+ (BAProp *)findPropWithName:(NSString *)aName {
    BAAssertActiveContext();
    return [BAActiveContext findPropWithName:aName];
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
    
    // TODO: WTF?
}

@end


@implementation NSManagedObjectContext (BAPropCreating)

- (BAProp *)findPropWithName:(NSString *)aName {
	return [self objectForEntityNamed:[BAProp entityName] matchingValue:aName forKey:@"name"];
}

- (BAProp *)propWithName:(NSString *)aName {
    
    BAProp *prop = [aName length] ? [self findPropWithName:aName] : nil;

	if(!prop) {
        prop = [self insertBAProp];
        prop.transform = [self insertBATransform];
        prop.name = aName;
    }
	
	return prop;
}

- (BAProp *)propWithName:(NSString *)aName prototype:(BAPrototype *)proto transform:(BATransform *)xform {
	
	BAProp *prop = [self insertBAProp];
	
    prop.name = aName;
    prop.prototype = proto;
    prop.transform = xform;
	
	return prop;
}

- (BAProp *)propWithName:(NSString *)aName prototype:(BAPrototype *)proto {
	return [self propWithName:aName prototype:proto transform:[self insertBATransform]];
}

- (BAProp *)propWithName:(NSString *)aName byMergingProps:(NSSet *)props {
	
    NSManagedObjectContext *context = [[props anyObject] managedObjectContext];
	BAMesh *mesh = [self meshWithName:aName];
	
	for(BAProp *prop in props) {
		for(BAMesh *xMesh in [prop transformedMeshes]) {
			[mesh addPolygons:xMesh.polygons]; // sets mesh relation of all polys to the new mesh; xmesh will have no polys
			[context deleteObject:xMesh];
		}
	}
    
    if([[[[mesh.polygons anyObject] points] anyObject] normal] != nil)
        mesh.hasNormalsValue = YES;
    
	
	return [self propWithName:aName prototype:[self prototypeWithName:nil mesh:mesh]];
}

@end