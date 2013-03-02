// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BAStage.h instead.

#import <CoreData/CoreData.h>


@class BAPartition;


@interface BAStageID : NSManagedObjectID {}
@end

@interface _BAStage : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BAStageID*)objectID;





@property (nonatomic, retain) BAPartition* partitionRoot;

//- (BOOL)validatePartitionRoot:(id*)value_ error:(NSError**)error_;




@end

@interface _BAStage (CoreDataGeneratedAccessors)

@end

@interface _BAStage (CoreDataGeneratedPrimitiveAccessors)



- (BAPartition*)primitivePartitionRoot;
- (void)setPrimitivePartitionRoot:(BAPartition*)value;


@end
