// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BAScenePref.h instead.

#import <CoreData/CoreData.h>






@interface BAScenePrefID : NSManagedObjectID {}
@end

@interface _BAScenePref : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BAScenePrefID*)objectID;




@property (nonatomic, retain) NSString *prefKey;


//- (BOOL)validatePrefKey:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *prefValue;


//- (BOOL)validatePrefValue:(id*)value_ error:(NSError**)error_;





@end

@interface _BAScenePref (CoreDataGeneratedAccessors)

@end

@interface _BAScenePref (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitivePrefKey;
- (void)setPrimitivePrefKey:(NSString*)value;




- (NSString*)primitivePrefValue;
- (void)setPrimitivePrefValue:(NSString*)value;




@end
