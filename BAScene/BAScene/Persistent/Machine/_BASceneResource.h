// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BASceneResource.h instead.

#import <CoreData/CoreData.h>


@class BASceneResource, BASceneResourceID;

@interface NSManagedObjectContext (BASceneResourceConveniences)

- (BASceneResource *)findBASceneResourceWithID:(BASceneResourceID *)objectID;
- (BASceneResource *)insertBASceneResource;

- (NSUInteger)countOfSceneResourceObjectsWithPredicate:(NSPredicate *)predicate;
- (NSUInteger)countOfSceneResourceObjectsWithValue:(id)value forKey:(NSString *)key;
- (NSUInteger)countOfSceneResourceObjects;

@end


@class BAMesh;
@class BAPrototypeMesh;

@interface BASceneResourceID : NSManagedObjectID {}
@end


@interface _BASceneResource : NSManagedObject {}

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BASceneResourceID*)objectID;

// Attributes
@property (nonatomic, retain) NSNumber *type;
@property int16_t typeValue;
- (int16_t)typeValue;
- (void)setTypeValue:(int16_t)value_;
//- (BOOL)validateType:(id *)value_ error:(NSError **)error_;

@property (nonatomic, retain) NSString *uniqueID;
//- (BOOL)validateUniqueID:(id *)value_ error:(NSError **)error_;


// Relationships
@property (nonatomic, retain) BAMesh *mesh;
//- (BOOL)validateMesh:(id *)value_ error:(NSError **)error_;

@property (nonatomic, retain) BAPrototypeMesh *prototypeMesh;
//- (BOOL)validatePrototypeMesh:(id *)value_ error:(NSError **)error_;


// Fetched Properties

// Fetch Requests

+ (id)fetchOneTexture:(NSManagedObjectContext *)moc_ MESH:(BAMesh *)MESH_ ;
+ (id)fetchOneTexture:(NSManagedObjectContext *)moc_ MESH:(BAMesh *)MESH_ error:(NSError **)error_;

@end


@interface _BASceneResource (CoreDataGeneratedAccessors)

@end


@interface _BASceneResource (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber *)primitiveType;
- (void)setPrimitiveType:(NSNumber *)value;

- (int16_t)primitiveTypeValue;
- (void)setPrimitiveTypeValue:(int16_t)value_;

- (NSString *)primitiveUniqueID;
- (void)setPrimitiveUniqueID:(NSString *)value;

- (BAMesh *)primitiveMesh;
- (void)setPrimitiveMesh:(BAMesh *)value;
- (BAPrototypeMesh *)primitivePrototypeMesh;
- (void)setPrimitivePrototypeMesh:(BAPrototypeMesh *)value;

@end
