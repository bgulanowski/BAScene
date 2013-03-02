#import <BAScene/_BAPrototypeMesh.h>

#import <BAScene/BACamera.h>

@interface BAPrototypeMesh : _BAPrototypeMesh<BAVisible> {
	BOOL hasColor;
@public
	BOOL appliesColor;
}

+ (BAPrototypeMesh *)prototypeMesh;

- (BAMesh *)transformedMesh;
- (NSSet *)transformedPolygons;
- (BARegionf)transformedBounds;

@end
