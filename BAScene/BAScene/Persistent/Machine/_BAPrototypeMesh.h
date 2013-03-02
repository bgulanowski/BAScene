// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BAPrototypeMesh.h instead.

#import <CoreData/CoreData.h>


@class BAColor;
@class BAMesh;
@class BAPrototype;
@class BAResource;
@class BATransform;



@interface BAPrototypeMeshID : NSManagedObjectID {}
@end

@interface _BAPrototypeMesh : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BAPrototypeMeshID*)objectID;




@property (nonatomic, retain) NSNumber *reversePolygons;


@property BOOL reversePolygonsValue;
- (BOOL)reversePolygonsValue;
- (void)setReversePolygonsValue:(BOOL)value_;

//- (BOOL)validateReversePolygons:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) BAColor* color;

//- (BOOL)validateColor:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) BAMesh* mesh;

//- (BOOL)validateMesh:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) BAPrototype* prototype;

//- (BOOL)validatePrototype:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* resources;

- (NSMutableSet*)resourcesSet;




@property (nonatomic, retain) BATransform* transform;

//- (BOOL)validateTransform:(id*)value_ error:(NSError**)error_;




@end

@interface _BAPrototypeMesh (CoreDataGeneratedAccessors)

- (void)addResources:(NSSet*)value_;
- (void)removeResources:(NSSet*)value_;
- (void)addResourcesObject:(BAResource*)value_;
- (void)removeResourcesObject:(BAResource*)value_;

@end

@interface _BAPrototypeMesh (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveReversePolygons;
- (void)setPrimitiveReversePolygons:(NSNumber*)value;

- (BOOL)primitiveReversePolygonsValue;
- (void)setPrimitiveReversePolygonsValue:(BOOL)value_;





- (BAColor*)primitiveColor;
- (void)setPrimitiveColor:(BAColor*)value;



- (BAMesh*)primitiveMesh;
- (void)setPrimitiveMesh:(BAMesh*)value;



- (BAPrototype*)primitivePrototype;
- (void)setPrimitivePrototype:(BAPrototype*)value;



- (NSMutableSet*)primitiveResources;
- (void)setPrimitiveResources:(NSMutableSet*)value;



- (BATransform*)primitiveTransform;
- (void)setPrimitiveTransform:(BATransform*)value;


@end
