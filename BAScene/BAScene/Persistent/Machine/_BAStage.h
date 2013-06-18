// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BAStage.h instead.

#import <CoreData/CoreData.h>


@class BAStage, BAStageID;

@interface NSManagedObjectContext (BAStageConveniences)

- (BAStage *)findBAStageWithID:(BAStageID *)objectID;
- (BAStage *)insertBAStage;

- (NSUInteger)countOfStageObjectsWithPredicate:(NSPredicate *)predicate;
- (NSUInteger)countOfStageObjectsWithValue:(id)value forKey:(NSString *)key;
- (NSUInteger)countOfStageObjects;

@end


@class BAPartition;

@interface BAStageID : NSManagedObjectID {}
@end


@interface _BAStage : NSManagedObject {}

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BAStageID*)objectID;

// Attributes

// Relationships
@property (nonatomic, retain) BAPartition *partitionRoot;
//- (BOOL)validatePartitionRoot:(id *)value_ error:(NSError **)error_;


// Fetched Properties

// Fetch Requests

@end


@interface _BAStage (CoreDataGeneratedAccessors)

@end


@interface _BAStage (CoreDataGeneratedPrimitiveAccessors)

- (BAPartition *)primitivePartitionRoot;
- (void)setPrimitivePartitionRoot:(BAPartition *)value;

@end
