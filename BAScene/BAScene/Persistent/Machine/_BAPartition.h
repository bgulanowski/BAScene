// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BAPartition.h instead.

#import <CoreData/CoreData.h>
#import "BAGroup.h"

@class BATuple;
@class BAStage;




@interface BAPartitionID : NSManagedObjectID {}
@end

@interface _BAPartition : BAGroup {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BAPartitionID*)objectID;




@property (nonatomic, retain) NSNumber *dimension;


@property double dimensionValue;
- (double)dimensionValue;
- (void)setDimensionValue:(double)value_;

//- (BOOL)validateDimension:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *index;


@property short indexValue;
- (short)indexValue;
- (void)setIndexValue:(short)value_;

//- (BOOL)validateIndex:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) BATuple* location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) BAStage* stage;

//- (BOOL)validateStage:(id*)value_ error:(NSError**)error_;




@end

@interface _BAPartition (CoreDataGeneratedAccessors)

@end

@interface _BAPartition (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveDimension;
- (void)setPrimitiveDimension:(NSNumber*)value;

- (double)primitiveDimensionValue;
- (void)setPrimitiveDimensionValue:(double)value_;




- (NSNumber*)primitiveIndex;
- (void)setPrimitiveIndex:(NSNumber*)value;

- (short)primitiveIndexValue;
- (void)setPrimitiveIndexValue:(short)value_;





- (BATuple*)primitiveLocation;
- (void)setPrimitiveLocation:(BATuple*)value;



- (BAStage*)primitiveStage;
- (void)setPrimitiveStage:(BAStage*)value;


@end
