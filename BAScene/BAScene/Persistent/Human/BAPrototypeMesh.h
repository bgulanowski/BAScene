#import <BAScene/_BAPrototypeMesh.h>

#import <BAScene/BACamera.h>

@interface BAPrototypeMesh : _BAPrototypeMesh<BAVisible> {
	BOOL hasColor;
@public
	BOOL appliesColor;
}

- (BAMesh *)transformedMesh;
- (NSSet *)transformedPolygons;
- (BARegionf)transformedBounds;

@end


@interface BAPrototypeMesh (BAPrototypeMeshDeprecated)
+ (BAPrototypeMesh *)prototypeMesh DEPRECATED_ATTRIBUTE;
@end


@interface NSManagedObjectContext (BAPrototypeMeshCreating)
- (BAPrototypeMesh *)prototypeMesh;
@end
