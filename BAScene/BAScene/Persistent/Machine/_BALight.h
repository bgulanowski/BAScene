// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BALight.h instead.

#import <CoreData/CoreData.h>
#import "BAProp.h"


@class BALight, BALightID;

@interface NSManagedObjectContext (BALightConveniences)

- (BALight *)findBALightWithID:(BALightID *)objectID;
- (BALight *)insertBALight;

- (NSUInteger)countOfLightObjectsWithPredicate:(NSPredicate *)predicate;
- (NSUInteger)countOfLightObjectsWithValue:(id)value forKey:(NSString *)key;
- (NSUInteger)countOfLightObjects;

@end



@interface BALightID : NSManagedObjectID {}
@end


@interface _BALight : BAProp {}

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BALightID*)objectID;

// Attributes

// Relationships

// Fetched Properties

// Fetch Requests

@end


@interface _BALight (CoreDataGeneratedAccessors)

@end


@interface _BALight (CoreDataGeneratedPrimitiveAccessors)


@end
