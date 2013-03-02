#import "BAPrototypeMesh.h"

#import "BAColor.h"
#import "BAMesh.h"
#import "BAPolygon.h"
#import "BATransform.h"
#import "BASceneUtilities.h"


@implementation BAPrototypeMesh

#pragma mark NSManagedObject
- (void)awakeFromFetch {
	[super awakeFromFetch];
	[self.transform rebuild];
	hasColor = (nil != self.color);
}


#pragma mark BAVisible
- (void)paintForCamera:(BACamera *)camera {
	glPushMatrix();
	[self.transform apply];
	if(hasColor && appliesColor) {
        BAColorf colorValues = self.color->values;
        glColor4f(colorValues.c.r, colorValues.c.g, colorValues.c.b, colorValues.c.a);
    }
//	self.mesh->appliesColor = appliesColor && !hasColor && !self.mesh.texture;
	[self.mesh paintForCamera:camera];
	glPopMatrix();
}

- (void)setColor:(BAColor *)aColor {
	[self setPrimitiveColor:aColor];
	hasColor = (nil != aColor);
}


#pragma mark Factory
+ (BAPrototypeMesh *)prototypeMesh {
	
	BAPrototypeMesh *pm = (BAPrototypeMesh *)[self insertObject];
	
	pm.transform = [BATransform transform];
	
	return pm;
}


#pragma mark - New
- (BAMesh *)transformedMesh {
	return [self.mesh transformedMesh:self.transform];
}

- (NSSet *)transformedPolygons {
	
	NSMutableSet *results = [NSMutableSet setWithCapacity:[self.mesh.polygons count]];
	
	
	for(BAPolygon *poly in self.mesh.polygons)
		[results addObject:[poly transformedPolygon:self.transform]];
	
	return results;
}

- (BARegionf)transformedBounds {

    BAMatrix4x4f m = [self.transform transform];
    BARegionf r = [self.mesh bounds];
    
    return BATransformRegionf(r, m);
}

@end
