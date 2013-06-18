// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// This template requires Bored Astronaut Core Data Additions (BAAdditions)
// Make changes to BALight.m instead.

#import "_BALight.h"


@implementation NSManagedObjectContext (BALightConveniences)

- (BALight *)findBALightWithID:(BALightID *)objectID {
    return (BALight *)[self objectWithID:objectID];
}

- (BALight *)insertBALight {
	return [NSEntityDescription insertNewObjectForEntityForName:@"Light" inManagedObjectContext:self];
}

- (NSUInteger)countOfLightObjectsWithPredicate:(NSPredicate *)predicate {
    
    __strong static NSFetchRequest *fetch;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fetch = [NSFetchRequest fetchRequestWithEntityName:@"Light"];
    });
    
    fetch.predicate = predicate;
    
    NSError *error = nil;
    NSUInteger result = [self countForFetchRequest:fetch error:&error];
    
    if(result == NSNotFound) {
        NSLog(@"Count of Light objects failed; error: %@", error);
        return 0;
    }
    
    return result;
}

- (NSUInteger)countOfLightObjectsWithValue:(id)value forKey:(NSString *)key {
    return [self countOfLightObjectsWithPredicate:[NSPredicate predicateWithFormat:@"%K = %@", key, value]];
}

- (NSUInteger)countOfLightObjects {
    return [self countOfLightObjectsWithPredicate:nil];
}

@end

@implementation BALightID
@end

@implementation _BALight

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Light" inManagedObjectContext:moc_];
}

+ (NSString *)entityName {
	return @"Light";
}

+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Light" inManagedObjectContext:moc_];
}

- (BALightID *)objectID {
	return (BALightID *)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@end
