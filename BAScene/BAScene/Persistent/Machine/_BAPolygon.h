// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BAPolygon.h instead.

#import <CoreData/CoreData.h>


@class BAMesh;
@class BAPoint;





@interface BAPolygonID : NSManagedObjectID {}
@end

@interface _BAPolygon : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BAPolygonID*)objectID;




@property (nonatomic, retain) NSNumber *a;


@property double aValue;
- (double)aValue;
- (void)setAValue:(double)value_;

//- (BOOL)validateA:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *b;


@property double bValue;
- (double)bValue;
- (void)setBValue:(double)value_;

//- (BOOL)validateB:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *c;


@property double cValue;
- (double)cValue;
- (void)setCValue:(double)value_;

//- (BOOL)validateC:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) BAMesh* mesh;

//- (BOOL)validateMesh:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSSet* points;

- (NSMutableSet*)pointsSet;




@end

@interface _BAPolygon (CoreDataGeneratedAccessors)

- (void)addPoints:(NSSet*)value_;
- (void)removePoints:(NSSet*)value_;
- (void)addPointsObject:(BAPoint*)value_;
- (void)removePointsObject:(BAPoint*)value_;

@end

@interface _BAPolygon (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveA;
- (void)setPrimitiveA:(NSNumber*)value;

- (double)primitiveAValue;
- (void)setPrimitiveAValue:(double)value_;




- (NSNumber*)primitiveB;
- (void)setPrimitiveB:(NSNumber*)value;

- (double)primitiveBValue;
- (void)setPrimitiveBValue:(double)value_;




- (NSNumber*)primitiveC;
- (void)setPrimitiveC:(NSNumber*)value;

- (double)primitiveCValue;
- (void)setPrimitiveCValue:(double)value_;





- (BAMesh*)primitiveMesh;
- (void)setPrimitiveMesh:(BAMesh*)value;



- (NSMutableSet*)primitivePoints;
- (void)setPrimitivePoints:(NSMutableSet*)value;


@end
