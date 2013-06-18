// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// This template requires Bored Astronaut Core Data Additions (BAAdditions)
// Make changes to BAScenePref.m instead.

#import "_BAScenePref.h"


@implementation NSManagedObjectContext (BAScenePrefConveniences)

- (BAScenePref *)findBAScenePrefWithID:(BAScenePrefID *)objectID {
    return (BAScenePref *)[self objectWithID:objectID];
}

- (BAScenePref *)insertBAScenePref {
	return [NSEntityDescription insertNewObjectForEntityForName:@"Pref" inManagedObjectContext:self];
}

- (NSUInteger)countOfPrefObjectsWithPredicate:(NSPredicate *)predicate {
    
    __strong static NSFetchRequest *fetch;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fetch = [NSFetchRequest fetchRequestWithEntityName:@"Pref"];
    });
    
    fetch.predicate = predicate;
    
    NSError *error = nil;
    NSUInteger result = [self countForFetchRequest:fetch error:&error];
    
    if(result == NSNotFound) {
        NSLog(@"Count of Pref objects failed; error: %@", error);
        return 0;
    }
    
    return result;
}

- (NSUInteger)countOfPrefObjectsWithValue:(id)value forKey:(NSString *)key {
    return [self countOfPrefObjectsWithPredicate:[NSPredicate predicateWithFormat:@"%K = %@", key, value]];
}

- (NSUInteger)countOfPrefObjects {
    return [self countOfPrefObjectsWithPredicate:nil];
}

@end

@implementation BAScenePrefID
@end

@implementation _BAScenePref

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Pref" inManagedObjectContext:moc_];
}

+ (NSString *)entityName {
	return @"Pref";
}

+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Pref" inManagedObjectContext:moc_];
}

- (BAScenePrefID *)objectID {
	return (BAScenePrefID *)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}


@dynamic prefKey;

@dynamic prefValue;



@end
