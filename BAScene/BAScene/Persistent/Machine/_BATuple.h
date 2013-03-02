// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BATuple.h instead.

#import <CoreData/CoreData.h>


@class BAPoint;
@class BAPartition;
@class BAPoint;
@class BAPoint;



@class BAPolygon;


@interface BATupleID : NSManagedObjectID {}
@end

@interface _BATuple : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BATupleID*)objectID;




@property (nonatomic, retain) NSNumber *x;


@property double xValue;
- (double)xValue;
- (void)setXValue:(double)value_;

//- (BOOL)validateX:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *y;


@property double yValue;
- (double)yValue;
- (void)setYValue:(double)value_;

//- (BOOL)validateY:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *z;


@property double zValue;
- (double)zValue;
- (void)setZValue:(double)value_;

//- (BOOL)validateZ:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSSet* nPoints;

- (NSMutableSet*)nPointsSet;




@property (nonatomic, retain) NSSet* partitions;

- (NSMutableSet*)partitionsSet;




@property (nonatomic, retain) NSSet* tPoints;

- (NSMutableSet*)tPointsSet;




@property (nonatomic, retain) NSSet* vPoints;

- (NSMutableSet*)vPointsSet;




+ (NSArray*)fetchRelatedVertices:(NSManagedObjectContext*)moc_ POLYGON:(BAPolygon*)POLYGON_ ;
+ (NSArray*)fetchRelatedVertices:(NSManagedObjectContext*)moc_ POLYGON:(BAPolygon*)POLYGON_ error:(NSError**)error_;



@end

@interface _BATuple (CoreDataGeneratedAccessors)

- (void)addNPoints:(NSSet*)value_;
- (void)removeNPoints:(NSSet*)value_;
- (void)addNPointsObject:(BAPoint*)value_;
- (void)removeNPointsObject:(BAPoint*)value_;

- (void)addPartitions:(NSSet*)value_;
- (void)removePartitions:(NSSet*)value_;
- (void)addPartitionsObject:(BAPartition*)value_;
- (void)removePartitionsObject:(BAPartition*)value_;

- (void)addTPoints:(NSSet*)value_;
- (void)removeTPoints:(NSSet*)value_;
- (void)addTPointsObject:(BAPoint*)value_;
- (void)removeTPointsObject:(BAPoint*)value_;

- (void)addVPoints:(NSSet*)value_;
- (void)removeVPoints:(NSSet*)value_;
- (void)addVPointsObject:(BAPoint*)value_;
- (void)removeVPointsObject:(BAPoint*)value_;

@end

@interface _BATuple (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveX;
- (void)setPrimitiveX:(NSNumber*)value;

- (double)primitiveXValue;
- (void)setPrimitiveXValue:(double)value_;




- (NSNumber*)primitiveY;
- (void)setPrimitiveY:(NSNumber*)value;

- (double)primitiveYValue;
- (void)setPrimitiveYValue:(double)value_;




- (NSNumber*)primitiveZ;
- (void)setPrimitiveZ:(NSNumber*)value;

- (double)primitiveZValue;
- (void)setPrimitiveZValue:(double)value_;





- (NSMutableSet*)primitiveNPoints;
- (void)setPrimitiveNPoints:(NSMutableSet*)value;



- (NSMutableSet*)primitivePartitions;
- (void)setPrimitivePartitions:(NSMutableSet*)value;



- (NSMutableSet*)primitiveTPoints;
- (void)setPrimitiveTPoints:(NSMutableSet*)value;



- (NSMutableSet*)primitiveVPoints;
- (void)setPrimitiveVPoints:(NSMutableSet*)value;


@end
