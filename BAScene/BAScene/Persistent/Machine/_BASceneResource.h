// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BAResource.h instead.

#import <CoreData/CoreData.h>


@class BAMesh;
@class BAPrototypeMesh;




@interface BASceneResourceID : NSManagedObjectID {}
@end

@interface _BASceneResource : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BASceneResourceID*)objectID;




@property (nonatomic, retain) NSNumber *type;


@property short typeValue;
- (short)typeValue;
- (void)setTypeValue:(short)value_;

//- (BOOL)validateType:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *uniqueID;


//- (BOOL)validateUniqueID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) BAMesh* mesh;

//- (BOOL)validateMesh:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) BAPrototypeMesh* prototypeMesh;

//- (BOOL)validatePrototypeMesh:(id*)value_ error:(NSError**)error_;




+ (id)fetchOneTexture:(NSManagedObjectContext*)moc_ MESH:(BAMesh*)MESH_ ;
+ (id)fetchOneTexture:(NSManagedObjectContext*)moc_ MESH:(BAMesh*)MESH_ error:(NSError**)error_;



@end

@interface _BASceneResource (CoreDataGeneratedAccessors)

@end

@interface _BASceneResource (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveType;
- (void)setPrimitiveType:(NSNumber*)value;

- (short)primitiveTypeValue;
- (void)setPrimitiveTypeValue:(short)value_;




- (NSString*)primitiveUniqueID;
- (void)setPrimitiveUniqueID:(NSString*)value;





- (BAMesh*)primitiveMesh;
- (void)setPrimitiveMesh:(BAMesh*)value;



- (BAPrototypeMesh*)primitivePrototypeMesh;
- (void)setPrimitivePrototypeMesh:(BAPrototypeMesh*)value;


@end
