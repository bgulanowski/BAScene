//
//  BAMesh.h
//  BAScene
//
//  Created by Brent Gulanowski on 30/05/09.
//  Copyright 2009 Bored Astronaut. All rights reserved.
//

#import <BAScene/_BAMesh.h>

#import <BAScene/BACamera.h>


typedef enum {
	kBAMeshTypeNormal,
	kBAMeshTypeMerged,
	kBAMeshTypeCompiled,
	kBAMeshTypeVolume,
	kBAMeshTypeTerrain
} BAMeshType;


extern BOOL drawNormals;

@class BATransform, BATexture;

@interface BAMesh : _BAMesh<BAVisible, NSMutableCopying> {
	
	BATexture *texture;
	
	GLuint vertexBuffer; // interleaved, based on the compiled data loaded from the vertex buffer resource
	GLuint normalBuffer;
	GLuint displayList;
	NSUInteger count;
	
	double minX;
	double maxX;
	double minY;
	double maxY;
	double minZ;
	double maxZ;
@public	
	BOOL appliesColor;
}

@property (retain, readwrite) BATexture *texture;

@property (nonatomic, readonly) BARegionf bounds;

@property (nonatomic, readonly) double minX;
@property (nonatomic, readonly) double maxX;
@property (nonatomic, readonly) double minY;
@property (nonatomic, readonly) double maxY;
@property (nonatomic, readonly) double minZ;
@property (nonatomic, readonly) double maxZ;
@property (nonatomic, readonly) double width;
@property (nonatomic, readonly) double height;
@property (nonatomic, readonly) double depth;

@property (readonly) NSArray *orderedPoints;

- (BOOL)saveToURL:(NSURL *)url error:(NSError **)perror;

- (BOOL)containsPointX:(double)x y:(double)y z:(double)z;

// there must be a texture coordinate for each point in the mesh
- (void)setTexture:(BATexture *)tex coordinates:(BAPointf *)coords offset:(CGSize *)offset;
- (void)prepareVertexBuffer;
- (void)compile; // convert points into a form more suitable for rendering

- (BAMesh *)transformedMesh:(BATransform *)transform;
- (BAMesh *)applyMatrixTransform:(BAMatrix4x4f)transform;
- (BAMesh *)applyTransform:(BATransform *)transform;

@end


@interface BAMesh (BAMeshDeprecated)

+ (BAMesh *)findMeshWithName:(NSString *)aName DEPRECATED_ATTRIBUTE;
+ (BAMesh *)meshWithName:(NSString *)aName create:(BOOL*)create DEPRECATED_ATTRIBUTE;
+ (BAMesh *)meshWithName:(NSString *)aName DEPRECATED_ATTRIBUTE;
+ (BAMesh *)meshWithPolygons:(NSSet *)polygons DEPRECATED_ATTRIBUTE; // BAPolygon instances
+ (BAMesh *)meshWithName:(NSString *)aName vertices:(BAPointf *)vertices count:(NSUInteger)vcount texCoords:(BAPointf *)texCoords count:(NSUInteger)tcCount vIndices:(NSUInteger *)indices tcIndices:(NSUInteger *)tcIndices count:(NSUInteger)icount polySize:(NSUInteger)psize DEPRECATED_ATTRIBUTE;
+ (BAMesh *)meshWithName:(NSString *)aName vertices:(BAPointf *)vertices count:(NSUInteger)vcount indices:(NSUInteger *)indices count:(NSUInteger)icount polySize:(NSUInteger)psize DEPRECATED_ATTRIBUTE;
+ (BAMesh *)meshWithTriangles:(BATriangle *)tris count:(NSUInteger)count DEPRECATED_ATTRIBUTE;
+ (BAMesh *)meshWithQuads:(BAQuad *)quads count:(NSUInteger)count DEPRECATED_ATTRIBUTE;

+ (BAMesh *)meshWithURL:(NSURL *)url DEPRECATED_ATTRIBUTE;

// unit Platonic solids
+ (BAMesh *)tetrahedron;
+ (BAMesh *)octahedron;
+ (BAMesh *)icosahedron;

#if ! TARGET_OS_IPHONE
+ (BAMesh *)boxWithWidth:(double)w depth:(double)d height:(double)h;
+ (BAMesh *)cube;
+ (BAMesh *)dodecahedron;
#endif

@end


@interface NSManagedObjectContext (BAMeshCreating)

- (BAMesh *)findMeshWithName:(NSString *)aName;

- (BAMesh *)meshWithName:(NSString *)aName;

- (BAMesh *)meshWithName:(NSString *)aName polygons:(NSSet *)polygons; // BAPolygon instances

- (BAMesh *)meshWithName:(NSString *)aName
                vertices:(BAPointf *)vertices count:(NSUInteger)vcount
               texCoords:(BAPointf *)texCoords count:(NSUInteger)tcCount
                vIndices:(NSUInteger *)indices tcIndices:(NSUInteger *)tcIndices count:(NSUInteger)icount
                polySize:(NSUInteger)psize;

- (BAMesh *)meshWithName:(NSString *)aName
                vertices:(BAPointf *)vertices count:(NSUInteger)vcount
                 indices:(NSUInteger *)indices count:(NSUInteger)icount
                polySize:(NSUInteger)psize;

- (BAMesh *)meshWithName:(NSString *)aName triangles:(BATriangle *)tris count:(NSUInteger)count;
- (BAMesh *)meshWithName:(NSString *)aName quads:(BAQuad *)quads count:(NSUInteger)count;

- (BAMesh *)meshWithURL:(NSURL *)url;

// unit Platonic solids
- (BAMesh *)tetrahedronMesh;
- (BAMesh *)octahedronMesh;
- (BAMesh *)icosahedronMesh;

#if ! TARGET_OS_IPHONE
- (BAMesh *)boxMeshWithWidth:(double)w depth:(double)d height:(double)h;
- (BAMesh *)cubeMesh;
- (BAMesh *)dodecahedronMesh;
#endif

#if 0
// other interesting shapes
- (BAMesh *)rhombicDodecahedron;
#endif

@end
