#import <BAScene/BAPrototypeMesh.h>

#import <BAScene/BAColor.h>
#import <BAScene/BAMesh.h>
#import <BAScene/BAPolygon.h>
#import <BAScene/BATransform.h>
#import <BAScene/BASceneUtilities.h>

#if TARGET_OS_IPHONE
#import <OpenGLES/ES1/gl.h>
#else
#import <OpenGL/gl.h>
#endif

@implementation BAPrototypeMesh

#pragma mark NSManagedObject
- (void)awakeFromFetch {
	[super awakeFromFetch];
	[self.transform rebuild];
	hasColor = (nil != self.color);
}


#pragma mark BAVisible
- (void)paintForCamera:(BACamera *)camera {
	[self.transform applyWithCamera:camera];

	if(hasColor && appliesColor) {
        BAColorf colorValues = self.color->values;
        glColor4f(colorValues.c.r, colorValues.c.g, colorValues.c.b, colorValues.c.a);
    }

	self.mesh->appliesColor = appliesColor && !hasColor && !self.mesh.texture;
	[self.mesh paintForCamera:camera];
	[camera revertViewTransform];
}

- (void)setColor:(BAColor *)aColor {
	[self setPrimitiveColor:aColor];
	hasColor = (nil != aColor);
}


#pragma mark Factory
+ (BAPrototypeMesh *)prototypeMesh {
	BAAssertActiveContext();
    return [BAActiveContext prototypeMesh];
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


@implementation NSManagedObjectContext (BAPrototypeMeshCreating)

- (BAPrototypeMesh *)prototypeMesh {
    BAPrototypeMesh *pm = [self insertBAPrototypeMesh];
	pm.transform = [self insertBATransform];
	return pm;
}

@end
