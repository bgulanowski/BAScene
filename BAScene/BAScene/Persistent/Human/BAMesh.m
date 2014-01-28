//
//  BAMesh.h
//  BAScene
//
//  Created by Brent Gulanowski on 30/05/09.
//  Copyright (c) 2009-2014 Bored Astronaut. All rights reserved.
//

#import <BAScene/BAMesh.h>

#import <BAScene/BATuple.h>
#import <BAScene/BAPoint.h>
#import <BAScene/BAProp.h>
#import <BAScene/BAPrototype.h>
#import <BAScene/BAPrototypeMesh.h>
#import <BAScene/BAPolygon.h>
#import <BAScene/BASceneTypes.h>
#import <BAScene/BATexture.h>
#import <BAScene/BATransform.h>
#import <BAScene/BASceneConstants.h>
#import <BAScene/BASceneResource.h>

#import <BAScene/BASceneUtilities.h>

#if TARGET_OS_IPHONE
#import <OpenGLES/ES1/gl.h>
#else
#import <OpenGL/gl.h>
#endif

BOOL drawNormals = NO;

static const int VertexResourceType = 0;
static const int IndexResourceType = 1;
static const int NormalResourceType = 2;
static const int TextureResourceType = 3;


static NSPredicate *vertexResourcePredicate;
static NSArray *pointSort;

@implementation BAMesh

@synthesize texture;
@dynamic bounds, minX, maxX, minY, maxY, minZ, maxZ, width, height, depth, orderedPoints;

#pragma mark NSObject
+ (void)initialize {
	if([self class] == [BAMesh class]) {
		vertexResourcePredicate = [[NSPredicate predicateWithFormat:@"type=%d", VertexResourceType] retain];
		pointSort = [[NSArray arrayWithObjects:
					  [NSSortDescriptor sortDescriptorWithKey:@"vertex.x" ascending:YES],
					  [NSSortDescriptor sortDescriptorWithKey:@"vertex.y" ascending:YES],
					  [NSSortDescriptor sortDescriptorWithKey:@"vertex.z" ascending:YES],
					  nil] retain];
	}
}

- (void)dealloc {
	self.texture = nil;
	// OpenGL context seems to already be gone by this time
//	if(displayList)
//		glDeleteLists(displayList, 1);
	[super dealloc];
}


#pragma mark NSManagedObject

- (void)awakeFromFetch {
	
	count = (GLsizei)[self.polygons count]*3;
	
	if(self.resources)
		[self prepareVertexBuffer];
	
	minX = NAN;
	maxX = NAN;
	minY = NAN;
	maxY = NAN;
	minZ = NAN;
	maxZ = NAN;
}


#pragma mark NSMutableCopying
- (id)mutableCopyWithZone:(NSZone *)zone {
	
	BAMesh *mesh = [[self managedObjectContext] meshWithName:nil];
	NSMutableSet *newPolygons = [NSMutableSet setWithCapacity:[self.polygons count]];
	
	for(BAPolygon *polygon in self.polygons)
		[newPolygons addObject:[[polygon mutableCopyWithZone:zone] autorelease]];
	
	mesh.polygons = newPolygons;
	mesh.hasNormals = self.hasNormals;
	mesh.hasTexture = self.hasTexture;
	mesh.level = self.level;
	mesh.sharedNormals = self.sharedNormals;
	mesh.type = self.type;
	
	return [mesh retain];
}


#pragma mark Factories
+ (BAMesh *)meshWithName:(NSString *)aName create:(BOOL*)create {
    BAAssertActiveContext();
    if(create && *create)
        return [BAActiveContext meshWithName:aName];
    else
        return [BAActiveContext findMeshWithName:aName];
}

+ (BAMesh *)meshWithName:(NSString *)aName vertices:(BAPointf *)vertices count:(NSUInteger)vcount texCoords:(BAPointf *)texCoords count:(NSUInteger)tcCount vIndices:(NSUInteger *)indices tcIndices:(NSUInteger *)tcIndices count:(NSUInteger)icount polySize:(NSUInteger)psize {
	BAAssertActiveContext();
    return [BAActiveContext meshWithName:aName
                                vertices:vertices count:vcount
                               texCoords:texCoords count:tcCount
                                vIndices:indices tcIndices:tcIndices count:icount
                                polySize:psize];
}

+ (BAMesh *)meshWithName:(NSString *)aName vertices:(BAPointf *)vertices count:(NSUInteger)vcount indices:(NSUInteger *)indices count:(NSUInteger)icount polySize:(NSUInteger)psize {
    BAAssertActiveContext();
    return [BAActiveContext meshWithName:aName vertices:vertices count:vcount indices:indices count:icount polySize:psize];
}

+ (BAMesh *)meshWithName:(NSString *)aName {
    BAAssertActiveContext();
    return [BAActiveContext meshWithName:aName];
}

+ (BAMesh *)meshWithURL:(NSURL *)url {
    BAAssertActiveContext();
    return [BAActiveContext meshWithURL:url];
}

+ (BAMesh *)meshWithPolygons:(NSSet *)polygonsSet {
	BAAssertActiveContext();
    return [BAActiveContext meshWithName:nil polygons:polygonsSet];
}

+ (BAMesh *)meshWithTriangles:(BATriangle *)tris count:(NSUInteger)count {
	BAAssertActiveContext();
    return [BAActiveContext meshWithName:nil triangles:tris count:count];
}

+ (BAMesh *)meshWithQuads:(BAQuad *)quads count:(NSUInteger)count {
	BAAssertActiveContext();
    return [BAActiveContext meshWithName:nil quads:quads count:count];
}


#pragma mark New
+ (BAMesh *)findMeshWithName:(NSString *)aName {
    BAAssertActiveContext();
	return [BAActiveContext findMeshWithName:aName];
}


static NSFetchRequest *fetch;
static NSExpressionDescription *min;
static NSExpressionDescription *max;

- (void)findExtentsForAxis:(NSString *)axisName min:(double*)pmin max:(double*)pmax {
	
	static dispatch_once_t d_once;
	
	dispatch_once(&d_once, ^() {
		min = [[[NSExpressionDescription alloc] init] autorelease];
		[min setName:@"min"];
		[min setExpressionResultType:NSDoubleAttributeType];

		max = [[[NSExpressionDescription alloc] init] autorelease];
		[max setName:@"max"];
		[max setExpressionResultType:NSDoubleAttributeType];
		
		fetch = [[[NSFetchRequest alloc] init] autorelease];
		[fetch setEntity:[BATuple entityInManagedObjectContext:self.managedObjectContext]];
		[fetch setResultType:NSDictionaryResultType];
		[fetch setPropertiesToFetch:[NSArray arrayWithObjects:min, max, nil]];
		[fetch setSortDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:axisName ascending:YES]]];
	});

	
	NSExpression *keyExpression = [NSExpression expressionForKeyPath:axisName];

	[max setExpression:[NSExpression expressionForFunction:@"max:" arguments:[NSArray arrayWithObject:keyExpression]]];
	[min setExpression:[NSExpression expressionForFunction:@"min:" arguments:[NSArray arrayWithObject:keyExpression]]];
	
	[fetch setPredicate:[NSPredicate predicateWithFormat:@"ANY vPoints IN %@",
						 [self valueForKeyPath:@"polygons.@distinctUnionOfSets.points"]]];
	
	NSError *error = nil;
	NSDictionary *results = [[[self managedObjectContext] executeFetchRequest:fetch error:&error] lastObject];
	
	if(error) {
		NSLog(@"Error fetching points for mesh: %@", error);
		return;
	}
	
	*pmin = [[results objectForKey:@"min"] doubleValue];
	*pmax = [[results objectForKey:@"max"] doubleValue];	
}

- (void)findExtentsForX {
	[self findExtentsForAxis:@"x" min:&minX max:&maxX];
}

- (void)findExtentsForY {
	[self findExtentsForAxis:@"y" min:&minY max:&maxY];
}

- (void)findExtentsForZ {
	[self findExtentsForAxis:@"z" min:&minZ max:&maxZ];
}

#define BAMeshExtent(_axis_, _ivar_) do {\
if(NAN == _ivar_)\
[self findExtentsFor##_axis_];\
return _ivar_;\
} while(0)

- (double)minX {
	BAMeshExtent(X, minX);
}

- (double)maxX {
	BAMeshExtent(X, maxX);
}

- (double)minY {
	BAMeshExtent(Y, minY);
}

- (double)maxY {
	BAMeshExtent(Y, maxX);
}

- (double)minZ {
	BAMeshExtent(Z, minZ);
}

- (double)maxZ {
	BAMeshExtent(Z, maxZ);
}

- (double)width {
	if(NAN == minX)
		[self findExtentsForX];
	return maxX - minX;
}

- (double)height {
	if(NAN == minY)
		[self findExtentsForY];
	return maxY - minY;
}

- (double)depth {
	if(NAN == minZ)
		[self findExtentsForZ];
	return maxZ - minZ;	
}

- (NSArray *)orderedPoints {
	return [BAPoint fetchConnected:[self managedObjectContext] sortDescriptors:pointSort MESH:self];
}

- (void)setTexture:(BATexture *)tex coordinates:(BAPointf *)coords offset:(CGSize *)offset {
	self.texture = tex;
	if(!tex)
		return;
	
}

- (void)prepareVertexBuffer {
	
	if(0 != vertexBuffer)
		return;
		
	BASceneResource *vertexResource = [[self.resources filteredSetUsingPredicate:vertexResourcePredicate] anyObject];
	
	if(!vertexResource)
		return;
	
	// create vertex buffer objects
	glGenBuffers(1, &vertexBuffer);
    if(!vertexBuffer)
        return;
    
	glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
	glBufferData(GL_ARRAY_BUFFER, [vertexResource.data length], [vertexResource.data bytes], GL_STATIC_DRAW);
    
    if(!count)
        count = (GLsizei)[vertexResource.data length]/(sizeof(GLfloat)*(3+(self.hasNormalsValue?3:0)));
	
	vertexResource.data = nil;
}

- (void) prepareNormalBuffer {
	
	if(0 != normalBuffer)
		return;
	
	static NSPredicate *predicate = nil;
	
	if(!predicate)
		predicate = [[NSPredicate predicateWithFormat:@"type=%d", NormalResourceType] retain];
	
	BASceneResource *vertexResource = [[self.resources filteredSetUsingPredicate:predicate] anyObject];
	
	// create vertex buffer objects
	glGenBuffers(1, &normalBuffer);
	glBindBuffer(GL_ARRAY_BUFFER, normalBuffer);
	glBufferData(GL_ARRAY_BUFFER, [vertexResource.data length], [vertexResource.data bytes], GL_STATIC_DRAW);
	
	vertexResource.data = nil;
}

- (BOOL)saveToURL:(NSURL *)url error:(NSError **)perror {
	return NO;
}

- (BOOL)containsPointX:(double)x y:(double)y z:(double)z {
	if(NAN == minX) [self findExtentsForX];
	if(NAN == minY) [self findExtentsForY];
	if(NAN == minZ) [self findExtentsForZ];
	return x >= minX && x < maxX && y >= minY && y < maxY && z >= minZ && z < maxZ;
}

static inline NSUInteger copyVertexData(BAPoint *point, GLfloat *buffer) {
	
	NSUInteger i=0;
	BATuple *vertex = [point vertex], *normal = [point normal], *texCoord = [point texCoord];
	
	buffer[i++] = vertex.xValue;
	buffer[i++] = vertex.yValue;
	buffer[i++] = vertex.zValue;
	if(normal) {
        buffer[i++] = normal.xValue;
        buffer[i++] = normal.yValue;
        buffer[i++] = normal.zValue;
	}
	if(texCoord) {
		buffer[i++] = texCoord.xValue;
		buffer[i++] = texCoord.yValue;
	}
	
	return i;
}

static inline NSUInteger copyNormalData(BATuple *vertex, BATuple *normal, GLfloat *buffer) {
		
	buffer[0] = vertex.xValue;
	buffer[1] = vertex.yValue;
	buffer[2] = vertex.zValue;
	buffer[3] = vertex.xValue + 0.25f * normal.xValue;
	buffer[4] = vertex.yValue + 0.25f * normal.yValue;
	buffer[5] = vertex.zValue + 0.25f * normal.zValue;
	
	return 6;
}

- (void)compile {
	
	if(!self.dirtyValue)
		return;
	
	// TODO: if we already have an outdated buffer, remember to release it
	
	GLfloat *rawVertices = NULL;
	GLfloat *rawNormals = NULL;
	NSUInteger i_v = 0, i_n = 0;
	GLsizei pointsPerPolygon = 3;
	
#if ! TARGET_OS_IPHONE
	if(GL_QUADS == self.typeValue)
		pointsPerPolygon = 4;
	else if(GL_POLYGON == self.typeValue)
		pointsPerPolygon = 3 * ((GLsizei)[[[self.polygons anyObject] points] count] - 2);
#endif
	
	count = (GLsizei)[self.polygons count] * pointsPerPolygon;

	NSUInteger elementsPerVertex = (3+((int)self.hasNormalsValue*3)+((int)self.hasTextureValue*2));
	size_t rawVertsSize = sizeof(GLfloat)*count*elementsPerVertex, rawNormalsSize = 0;
	
//	NSLog(@"%p will compile %lu points into raw vertex array of size %lu", self, (unsigned long)count, (unsigned long)rawVertsSize);
	
	// Make an interleaved array of vertices, normals, texture coordinates and/or colour values
	rawVertices = malloc(rawVertsSize);
    
    BOOL doDrawNormals = drawNormals;
	
	if(doDrawNormals) {
		rawNormalsSize = sizeof(GLfloat)*count*2*3;
		rawNormals = malloc(rawVertsSize);
	}
		

	// TODO: add support for GL_TRIANGLE_STRIP and GL_TRIANGLE_FAN.
#if ! TARGET_OS_IPHONE
	if(GL_POLYGON == self.typeValue) {
		
		// Convert polygons into triangles; requires re-using the same points repeatedly
		for(BAPolygon *poly in self.polygons) {

			NSEnumerator *iter = [[poly orderedPoints] objectEnumerator];
			BAPoint *points[3];
			
			points[0] = [iter nextObject];
			points[1] = [iter nextObject];
			
			while((points[2] = [iter nextObject])) {
				for(NSUInteger j = 0; j<3; ++j) {
					i_v += copyVertexData(points[j], &rawVertices[i_v]);
					if(doDrawNormals)
						i_n += copyNormalData([points[j] vertex], [points[j] normal], &rawNormals[i_n]);
				}
				points[1] = points[2];
			}
		}
	}
	else {
#endif
		for(BAPolygon *poly in self.polygons)
			for(BAPoint *point in [poly orderedPoints])
				i_v += copyVertexData(point, &rawVertices[i_v]);
			/*
			for(BATuple *vertex in [[poly orderedIndices] valueForKey:@"point"]) {
				i_v += copyVertexData(vertex, &rawVertices[i_v], self.hasNormalsValue, self.hasTextureValue, YES, poly);
				if(drawNormals)
					i_n += copyNormalData(vertex, &rawNormals[i_n], poly);
			}*/
#if ! TARGET_OS_IPHONE
	}
#endif
    
	NSAssert(i_v == (count*elementsPerVertex), @"WTF");
	
	NSData *vertexData = [NSData dataWithBytesNoCopy:rawVertices length:rawVertsSize freeWhenDone:YES];
	BASceneResource *vertexResource = [self.managedObjectContext resourceWithType:VertexResourceType data:vertexData];
	
	[self addResourcesObject:vertexResource];
    [self prepareVertexBuffer];
	
	if(doDrawNormals) {

		NSAssert(i_n==count*2*3, @"fail");
		
		vertexData = [NSData dataWithBytesNoCopy:rawNormals length:rawNormalsSize freeWhenDone:YES];
		vertexResource = [self.managedObjectContext resourceWithType:NormalResourceType data:vertexData];
		
		[self addResourcesObject:vertexResource];
		[self prepareNormalBuffer];
	}
	
	self.dirtyValue = NO;
}

- (BAMesh *)transformedMesh:(BATransform *)transform {
	
	NSMutableSet *newPolys = [NSMutableSet setWithCapacity:[self.polygons count]];
	NSUInteger numPoints = [[self valueForKeyPath:@"polygons.@count.@distinctUnionOfSets.points.vertex"] unsignedIntegerValue];
	NSMutableDictionary *pointMap = [NSMutableDictionary dictionaryWithCapacity:numPoints];
	
	for(BAPolygon *poly in self.polygons) {
		
		NSMutableSet *newPoints = [NSMutableSet setWithCapacity:[poly.points count]];

		// is this a good place to convert quads and general polygons into triangles?
//		if([indices count] > 3)
//			;
		
		for(BAPoint *point in poly.points) {
			
			BATuple *vertex = [point vertex];
			BATupleID *tupleID = [vertex objectID];
			BATuple *newPoint = [pointMap objectForKey:tupleID];
			
			if(!newPoint) {
				newPoint = [self.managedObjectContext tupleWithPoint:[vertex pointf]];
				[newPoint applyTransform:transform];
				[pointMap setObject:newPoint forKey:tupleID];
			}
			
			[newPoints addObject:[[self managedObjectContext] pointWithVertex:newPoint index:[point indexValue]]];
		}
		
		[newPolys addObject:[self.managedObjectContext polygonWithPoints:newPoints]];
	}
	
	return [[self managedObjectContext] meshWithName:[self.name stringByAppendingString:@" copy"] polygons:newPolys];
}

- (BAMesh *)applyMatrixTransform:(BAMatrix4x4f)transform {
	for(BATuple *p in [self.polygons valueForKeyPath:@"@distinctUnionOfSets.points.vertex"])
		[p applyMatrixTransform:transform];
	return self;
}

- (BAMesh *)applyTransform:(BATransform *)transform {
	return [self applyMatrixTransform:[transform transform]];
}


#pragma mark BAVisible
- (void)paintForCamera:(BACamera *)camera {
	
	if([self.resources count] > 0) {
		
#if 0
//		[camera ]
		
#else
		GLuint stride = (3+((GLuint)self.hasNormalsValue*3)+((GLuint)self.hasTextureValue*2)) * sizeof(GLfloat);
		
		glEnableClientState(GL_VERTEX_ARRAY);
		if(self.hasNormalsValue)
			glEnableClientState(GL_NORMAL_ARRAY);
		if(self.hasTextureValue)
			glEnableClientState(GL_TEXTURE_COORD_ARRAY);
		glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
		glVertexPointer(3, GL_FLOAT, stride, NULL);

		if(self.hasNormalsValue)
			glNormalPointer(GL_FLOAT, stride, (void*)(sizeof(GLfloat)*3));
		if(self.hasTextureValue)
			glTexCoordPointer(2, GL_FLOAT, stride, (void*)(sizeof(GLfloat)*(self.hasNormalsValue ? 6 : 3)));
	
#if TARGET_OS_IPHONE
		glDrawArrays(GL_TRIANGLES, 0, count);
#else
		glDrawArrays((GL_POLYGON == self.typeValue ? GL_TRIANGLES : self.typeValue), 0, count);
#endif
		if(self.hasTextureValue)
			glDisableClientState(GL_TEXTURE_COORD_ARRAY);
		if(self.hasNormalsValue)
			glDisableClientState(GL_NORMAL_ARRAY);

		if(drawNormals) {
			glBindBuffer(GL_ARRAY_BUFFER, normalBuffer);
			glVertexPointer(3, GL_FLOAT, 0, NULL);
			glDrawArrays(GL_LINES, 0, count*2);
            glBindBuffer(GL_ARRAY_BUFFER, 0);
		}
        
		glDisableClientState( GL_VERTEX_ARRAY );

        glBindBuffer(GL_ARRAY_BUFFER, 0);
#endif
	}
	else {
#if ! TARGET_OS_IPHONE
		if(!displayList) {
			displayList = glGenLists(1);
			glNewList(displayList, GL_COMPILE);
			if(self.texture) {
				glEnable(self.texture.type);
			}
			[self.texture configureParameters];
			for(BAPolygon *poly in self.polygons)
				[poly paintForCamera:camera];
			if(self.texture) {
				glDisable(self.texture.type);
			}
			glEndList();
		}
		glCallList(displayList);
#endif
	}
}

- (void)setColor:(BAColor *)aColor {
	for(BAPolygon *poly in self.polygons)
		[poly setColor:aColor];
}

- (BARegionf)bounds {
    return BAMakeRegionf([self minX], [self minY], [self minZ], [self width], [self height], [self depth]);
}

@end


@implementation BAMesh (BAMeshFactory)

#if ! TARGET_OS_IPHONE
+ (BAMesh *)boxWithWidth:(double)w depth:(double)d height:(double)h {
	BAAssertActiveContext();
    return [BAActiveContext boxMeshWithWidth:w depth:d height:h];
}
#endif

// unit Platonic solids
+ (BAMesh *)tetrahedron {
    BAAssertActiveContext();
    return [BAActiveContext tetrahedronMesh];
}

#if ! TARGET_OS_IPHONE
+ (BAMesh *)cube {
	BAAssertActiveContext();
    return [BAActiveContext cubeMesh];
}
#endif

+ (BAMesh *)octahedron {
	BAAssertActiveContext();
    return [BAActiveContext octahedronMesh];
}

#if ! TARGET_OS_IPHONE
+ (BAMesh *)dodecahedron {
	BAAssertActiveContext();
    return [BAActiveContext dodecahedronMesh];
}
#endif

+ (BAMesh *)icosahedron {
    BAAssertActiveContext();
    return [BAActiveContext icosahedronMesh];
}

@end


@implementation NSManagedObjectContext (BAMeshCreating)

- (BAMesh *)findMeshWithName:(NSString *)aName {
    return [self objectForEntityNamed:[BAMesh entityName] matchingValue:aName forKey:@"name"];
}

- (BAMesh *)meshWithName:(NSString *)aName {
    
    BAMesh *mesh = [aName length] ? [self findMeshWithName:aName] : nil;
    
    if(!mesh) {
        mesh = [self insertBAMesh];
		mesh.typeValue = GL_TRIANGLES;
        mesh.name = aName;
    }

	return mesh;
}

- (BAMesh *)meshWithName:(NSString *)aName polygons:(NSSet *)polygonsSet {
	
	BAMesh *mesh = [self meshWithName:aName];
    
	mesh.polygons = polygonsSet;
	
#if TARGET_OS_IPHONE
    mesh.typeValue = GL_TRIANGLES;
    
#else
	switch ([[(BAPolygon *)[polygonsSet anyObject] points] count]) {
		case 3:
			mesh.typeValue = GL_TRIANGLES;
			break;
		case 4:
			mesh.typeValue = GL_QUADS;
			break;
		default:
			mesh.typeValue = GL_POLYGON;
			break;
	}
#endif
	
	return mesh;
}

- (BAMesh *)meshWithName:(NSString *)aName
                vertices:(BAPointf *)vertices count:(NSUInteger)vcount
               texCoords:(BAPointf *)texCoords count:(NSUInteger)tcCount
                vIndices:(NSUInteger *)indices tcIndices:(NSUInteger *)tcIndices count:(NSUInteger)icount
                polySize:(NSUInteger)psize {
	
	BAMesh *mesh = [self meshWithName:aName];
	
		// FIXME: need to make this automatic
    [mesh setPolygons:[self polygonsWithSize:psize
                                    vertices:vertices ? [self tuplesWithPointArray:vertices count:vcount] : nil
                                   texCoords:texCoords ? [self tuplesWithPointArray:texCoords count:tcCount] : nil
                                     indices:indices
                                   tcIndices:tcIndices
                                       count:icount]];
    mesh.dirtyValue = YES;
    mesh.hasNormalsValue = YES;
	
	return mesh;
}

- (BAMesh *)meshWithName:(NSString *)aName
                vertices:(BAPointf *)vertices count:(NSUInteger)vcount
                 indices:(NSUInteger *)indices count:(NSUInteger)icount
                polySize:(NSUInteger)psize {
	return [self meshWithName:aName vertices:vertices count:vcount texCoords:nil count:0 vIndices:indices tcIndices:NULL count:icount polySize:psize];
}

- (BAMesh *)meshWithURL:(NSURL *)url {
	return nil;
}

- (BAMesh *)meshWithName:(NSString *)aName triangles:(BATriangle *)tris count:(NSUInteger)count {
	
	BAMesh *mesh = [self meshWithName:aName];
	NSMutableSet *polygons = [NSMutableSet setWithCapacity:count];
	
	for(NSUInteger i=0; i<count; ++i)
		[polygons addObject:[self polygonWithTriangle:tris[i]]];
	
	mesh.polygons = polygons;
    
	return mesh;
}

- (BAMesh *)meshWithName:(NSString *)aName quads:(BAQuad *)quads count:(NSUInteger)count {
	
	BAMesh *mesh = [self meshWithName:aName];
	NSMutableSet *polygons = [NSMutableSet setWithCapacity:count];
	
	for(NSUInteger i=0; i<count; ++i)
		[polygons addObject:[self polygonWithQuad:quads[i]]];
	
	mesh.polygons = polygons;
	
	return mesh;
}

#if ! TARGET_OS_IPHONE
- (BAMesh *)boxMeshWithWidth:(double)w depth:(double)d height:(double)h {
	
	double x2 = w*0.5f, y2 = h*0.5f, z2 = d*0.5f, x1 = -x2, y1 = -y2, z1 = -z2;
	BAPointf points[] = {
		{ x1, y1, z1 },
		{ x1, y1, z2 },
		{ x1, y2, z1 },
		{ x1, y2, z2 },
		{ x2, y1, z1 },
		{ x2, y1, z2 },
		{ x2, y2, z1 },
		{ x2, y2, z2 }
	};
	NSUInteger indices[] = { 0,1,3,2, 0,2,6,4, 0,4,5,1, 1,5,7,3, 2,3,7,6, 4,6,7,5 };
	BAMesh *box = [self meshWithName:@"Box" vertices:points count:8 indices:indices count:6 polySize:4];
	
	box.typeValue = GL_QUADS;
	
	return box;
}
#endif

// unit Platonic solids
- (BAMesh *)tetrahedronMesh {
    
	BAMesh *tetrahedron = [self findMeshWithName:@"BAMesh:tetrahedron"];
	
	if(!tetrahedron) {
		
		BAPointf points[] = {p000, p101, p011, p110};
		NSUInteger indices[] = {0,1,2, 0,2,3, 0,3,1, 1,3,2};
        
		tetrahedron = [self meshWithName:@"BAMesh:tetrahedron" vertices:points count:4 indices:indices count:4 polySize:3];
	}
	
	return tetrahedron;
}

#if ! TARGET_OS_IPHONE
- (BAMesh *)cubeMesh {
	
	BAMesh *cube = [self findMeshWithName:@"BAMesh:cube"];
	
	if(!cube) {
		
		BAPointf points[] = { p000, p001, p010, p011, p100, p101, p110, p111 };
		NSUInteger indices[] = { 0,1,3,2, 0,2,6,4, 0,4,5,1, 1,5,7,3, 2,3,7,6, 4,6,7,5 };
		
		cube = [self meshWithName:@"BAMesh:cube" vertices:points count:8 indices:indices count:6 polySize:4];
		cube.typeValue = GL_QUADS;
	}
	
	return cube;
}
#endif

- (BAMesh *)octahedronMesh {
	
	BAMesh *octahedron = [self findMeshWithName:@"BAMesh:octahedron"];
	
	if(!octahedron) {
		
		BAPointf points[] = { p0hh, ph0h, phh0, p1hh, ph1h, phh1 };
		NSUInteger indices[] = { 0,1,5, 0,2,1, 0,4,2, 0,5,4, 1,2,3, 1,3,5, 3,2,4, 3,4,5 };
		
		octahedron = [self meshWithName:@"BAMesh:octahedron" vertices:points count:6 indices:indices count:8 polySize:3];
	}
	
	return octahedron;
}

#if ! TARGET_OS_IPHONE
- (BAMesh *)dodecahedronMesh {
	
	BAMesh *dodecahedron = [self findMeshWithName:@"BAMesh:dodecahedron"];
	
	if(!dodecahedron) {
		
		BAPointf points[] = { dv01, dv02, dv03, dv04, dv05, dv06, dv07, dv08, dv09, dv10, dv11, dv12, dv13, dv14, dv15, dv16, dv17, dv18, dv19, dv20 };
		NSUInteger indices[] = {
			0,8,9,1,12, 0,12,13,2,16, 0,16,18,4,8, 3,11,10,2,13, 3,13,12,1,17, 3,17,19,7,11,
			5,9,8,4,14, 5,14,15,7,19, 5,19,17,1,9, 6,10,11,7,15, 6,15,14,4,18, 6,18,16,2,10
		};
		
		dodecahedron = [self meshWithName:@"BAMesh:dodecahedron" vertices:points count:20 indices:indices count:12 polySize:5];
		dodecahedron.typeValue = GL_POLYGON;
	}
	
	return dodecahedron;
}
#endif

- (BAMesh *)icosahedronMesh {
    
	BAMesh *icosahedron = [self findMeshWithName:@"BAMesh:icosahedron"];
	
	if(!icosahedron) {
		
		BAPointf points[] = { iv01, iv02, iv03, iv04, iv05, iv06, iv07, iv08, iv09, iv10, iv11, iv12 };
		NSUInteger indices[] = {
			0,2,9, 0,4,8, 0,6,4, 0,8,2, 0,9,6, 2,5,7, 2,7,9, 2,8,5,
			1,3,10, 1,4,6, 1,6,11, 1,10,4, 1,11,3, 3,5,10, 3,7,5, 3,11,7,
			4,10,8, 6,9,11, 5,8,10, 7,11,9
		};
		
		icosahedron = [self meshWithName:@"BAMesh:icosahedron" vertices:points count:12 indices:indices count:20 polySize:3];
	}
	
	return icosahedron;
}


// other interesting shapes
#if 0
- (BAMesh *)rhombicDodecahedronMesh {
	return nil;
}
#endif

@end