// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BAPartition.h instead.

#import <CoreData/CoreData.h>
#import "BAPropGroup.h"


@class BAPartition, BAPartitionID;

@interface NSManagedObjectContext (BAPartitionConveniences)

- (BAPartition *)findBAPartitionWithID:(BAPartitionID *)objectID;
- (BAPartition *)insertBAPartition;

- (NSUInteger)countOfPartitionObjectsWithPredicate:(NSPredicate *)predicate;
- (NSUInteger)countOfPartitionObjectsWithValue:(id)value forKey:(NSString *)key;
- (NSUInteger)countOfPartitionObjects;

@end


@class BAPartition;
@class BAStage;
@class BATuple;

@interface BAPartitionID : NSManagedObjectID {}
@end


@interface _BAPartition : BAPropGroup {}

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BAPartitionID*)objectID;

// Attributes
@property (nonatomic, retain) NSNumber *dimension;
@property double dimensionValue;
- (double)dimensionValue;
- (void)setDimensionValue:(double)value_;
//- (BOOL)validateDimension:(id *)value_ error:(NSError **)error_;

@property (nonatomic, retain) NSNumber *index;
@property int16_t indexValue;
- (int16_t)indexValue;
- (void)setIndexValue:(int16_t)value_;
//- (BOOL)validateIndex:(id *)value_ error:(NSError **)error_;


// Relationships
@property (nonatomic, retain) BATuple *location;
//- (BOOL)validateLocation:(id *)value_ error:(NSError **)error_;

@property (nonatomic, retain) BAStage *stage;
//- (BOOL)validateStage:(id *)value_ error:(NSError **)error_;


// Fetched Properties
@property (nonatomic, readonly) NSArray *children;

// Fetch Requests

@end


@interface _BAPartition (CoreDataGeneratedAccessors)

@end


@interface _BAPartition (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber *)primitiveDimension;
- (void)setPrimitiveDimension:(NSNumber *)value;

- (double)primitiveDimensionValue;
- (void)setPrimitiveDimensionValue:(double)value_;

- (NSNumber *)primitiveIndex;
- (void)setPrimitiveIndex:(NSNumber *)value;

- (int16_t)primitiveIndexValue;
- (void)setPrimitiveIndexValue:(int16_t)value_;

- (BATuple *)primitiveLocation;
- (void)setPrimitiveLocation:(BATuple *)value;
- (BAStage *)primitiveStage;
- (void)setPrimitiveStage:(BAStage *)value;

@end
