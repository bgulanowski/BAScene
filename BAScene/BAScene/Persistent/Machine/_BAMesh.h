// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BAMesh.h instead.

#import <CoreData/CoreData.h>


@class BAMesh, BAMeshID;

@interface NSManagedObjectContext (BAMeshConveniences)

- (BAMesh *)findBAMeshWithID:(BAMeshID *)objectID;
- (BAMesh *)insertBAMesh;

- (NSUInteger)countOfMeshObjectsWithPredicate:(NSPredicate *)predicate;
- (NSUInteger)countOfMeshObjectsWithValue:(id)value forKey:(NSString *)key;
- (NSUInteger)countOfMeshObjects;

@end


@class BAPolygon;
@class BAPrototypeMesh;
@class BASceneResource;

@interface BAMeshID : NSManagedObjectID {}
@end


@interface _BAMesh : NSManagedObject {}

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BAMeshID*)objectID;

// Attributes
@property (nonatomic, retain) NSNumber *dirty;
@property BOOL dirtyValue;
- (BOOL)dirtyValue;
- (void)setDirtyValue:(BOOL)value_;
//- (BOOL)validateDirty:(id *)value_ error:(NSError **)error_;

@property (nonatomic, retain) NSNumber *hasNormals;
@property BOOL hasNormalsValue;
- (BOOL)hasNormalsValue;
- (void)setHasNormalsValue:(BOOL)value_;
//- (BOOL)validateHasNormals:(id *)value_ error:(NSError **)error_;

@property (nonatomic, retain) NSNumber *hasTexture;
@property BOOL hasTextureValue;
- (BOOL)hasTextureValue;
- (void)setHasTextureValue:(BOOL)value_;
//- (BOOL)validateHasTexture:(id *)value_ error:(NSError **)error_;

@property (nonatomic, retain) NSNumber *level;
@property int16_t levelValue;
- (int16_t)levelValue;
- (void)setLevelValue:(int16_t)value_;
//- (BOOL)validateLevel:(id *)value_ error:(NSError **)error_;

@property (nonatomic, retain) NSString *name;
//- (BOOL)validateName:(id *)value_ error:(NSError **)error_;

@property (nonatomic, retain) NSNumber *sharedNormals;
@property BOOL sharedNormalsValue;
- (BOOL)sharedNormalsValue;
- (void)setSharedNormalsValue:(BOOL)value_;
//- (BOOL)validateSharedNormals:(id *)value_ error:(NSError **)error_;

@property (nonatomic, retain) NSNumber *type;
@property int16_t typeValue;
- (int16_t)typeValue;
- (void)setTypeValue:(int16_t)value_;
//- (BOOL)validateType:(id *)value_ error:(NSError **)error_;


// Relationships
@property (nonatomic, retain) NSSet *polygons;
- (NSMutableSet*)polygonsSet;

@property (nonatomic, retain) NSSet *prototypeMeshes;
- (NSMutableSet*)prototypeMeshesSet;

@property (nonatomic, retain) NSSet *resources;
- (NSMutableSet*)resourcesSet;


// Fetched Properties

// Fetch Requests

@end


@interface _BAMesh (CoreDataGeneratedAccessors)

- (void)addPolygons:(NSSet *)value_;
- (void)removePolygons:(NSSet *)value_;
- (void)addPolygonsObject:(BAPolygon *)value_;
- (void)removePolygonsObject:(BAPolygon *)value_;

- (void)addPrototypeMeshes:(NSSet *)value_;
- (void)removePrototypeMeshes:(NSSet *)value_;
- (void)addPrototypeMeshesObject:(BAPrototypeMesh *)value_;
- (void)removePrototypeMeshesObject:(BAPrototypeMesh *)value_;

- (void)addResources:(NSSet *)value_;
- (void)removeResources:(NSSet *)value_;
- (void)addResourcesObject:(BASceneResource *)value_;
- (void)removeResourcesObject:(BASceneResource *)value_;

@end


@interface _BAMesh (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber *)primitiveDirty;
- (void)setPrimitiveDirty:(NSNumber *)value;

- (BOOL)primitiveDirtyValue;
- (void)setPrimitiveDirtyValue:(BOOL)value_;

- (NSNumber *)primitiveHasNormals;
- (void)setPrimitiveHasNormals:(NSNumber *)value;

- (BOOL)primitiveHasNormalsValue;
- (void)setPrimitiveHasNormalsValue:(BOOL)value_;

- (NSNumber *)primitiveHasTexture;
- (void)setPrimitiveHasTexture:(NSNumber *)value;

- (BOOL)primitiveHasTextureValue;
- (void)setPrimitiveHasTextureValue:(BOOL)value_;

- (NSNumber *)primitiveLevel;
- (void)setPrimitiveLevel:(NSNumber *)value;

- (int16_t)primitiveLevelValue;
- (void)setPrimitiveLevelValue:(int16_t)value_;

- (NSString *)primitiveName;
- (void)setPrimitiveName:(NSString *)value;

- (NSNumber *)primitiveSharedNormals;
- (void)setPrimitiveSharedNormals:(NSNumber *)value;

- (BOOL)primitiveSharedNormalsValue;
- (void)setPrimitiveSharedNormalsValue:(BOOL)value_;

- (NSNumber *)primitiveType;
- (void)setPrimitiveType:(NSNumber *)value;

- (int16_t)primitiveTypeValue;
- (void)setPrimitiveTypeValue:(int16_t)value_;


- (NSMutableSet *)primitivePolygons;
- (void)setPrimitivePolygons:(NSMutableSet *)value;

- (NSMutableSet *)primitivePrototypeMeshes;
- (void)setPrimitivePrototypeMeshes:(NSMutableSet *)value;

- (NSMutableSet *)primitiveResources;
- (void)setPrimitiveResources:(NSMutableSet *)value;

@end
