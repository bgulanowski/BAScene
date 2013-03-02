//
//  NSManagedObjectContext+BAAdditions.h
//  Bored Astronaut Additions
//
//  Created by Brent Gulanowski on 22/02/08.
//  Copyright 2008 Bored Astronaut. All rights reserved.
//

#import <CoreData/CoreData.h>


#define BAActiveContext [NSManagedObjectContext activeContext]


@interface NSManagedObjectContext (BAAdditions)

+ (NSURL *)defaultStoreURL;

+ (NSManagedObjectContext *)newObjectContextWithModel:(NSManagedObjectModel *)model type:(NSString *)storeType storeURL:(NSURL *)url;
+ (NSManagedObjectContext *)newObjectContextWithModel:(NSManagedObjectModel *)model;
+ (NSManagedObjectContext *)newObjectContextWithModelName:(NSString *)name;
+ (NSManagedObjectContext *)newObjectContext;

// NOT retained
+ (NSManagedObjectContext *)activeContext;
+ (void)setActiveContext:(NSManagedObjectContext *)context;

- (NSManagedObjectContext *)editingContext;

- (void)makeActive;

- (NSArray *)entityNames;
- (NSEntityDescription *)entityForName:(NSString *)entityName;

- (NSUInteger)countOfEntity:(NSString *)entityName withPredicate:(NSPredicate *)predicate;
- (NSUInteger)countOfEntity:(NSString *)entityName withValue:(id)value forKey:(NSString *)key;
- (NSUInteger)countOfEntity:(NSString *)entityName;

// All queries below rely on this one
- (NSArray *)objectsForEntityNamed:(NSString *)entityName matchingPredicate:(NSPredicate *)aPredicate limit:(NSUInteger)limit;

- (NSArray *)objectsForEntityNamed:(NSString *)entity matchingPredicate:(NSPredicate *)aPredicate;
- (NSArray *)objectsForEntityNamed:(NSString *)entity matchingValue:(id)aValue forKey:(NSString *)aKey;
- (NSArray *)objectsForEntityNamed:(NSString *)entity;

- (id)objectForEntityNamed:(NSString *)entity matchingPredicate:(NSPredicate *)aPredicate;
- (id)objectForEntityNamed:(NSString *)entity matchingValue:(id)aValue forKey:(NSString *)aKey;
- (id)objectForEntityNamed:(NSString *)entity;

// Create an object with a given value for key if it does not already exist
- (id)objectForEntityNamed:(NSString *)entity matchingValue:(id)aValue forKey:(NSString *)aKey create:(BOOL*)create;

- (NSManagedObject *)objectWithIDString:(NSString *)IDString;

- (NSManagedObject *)insertDefaultObjectForEntityNamed:(NSString *)entityName;

@end
