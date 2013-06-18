// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// This template requires Bored Astronaut Core Data Additions (BAAdditions)
// Make changes to BAStage.m instead.

#import "_BAStage.h"


@implementation NSManagedObjectContext (BAStageConveniences)

- (BAStage *)findBAStageWithID:(BAStageID *)objectID {
    return (BAStage *)[self objectWithID:objectID];
}

- (BAStage *)insertBAStage {
	return [NSEntityDescription insertNewObjectForEntityForName:@"Stage" inManagedObjectContext:self];
}

- (NSUInteger)countOfStageObjectsWithPredicate:(NSPredicate *)predicate {
    
    __strong static NSFetchRequest *fetch;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fetch = [NSFetchRequest fetchRequestWithEntityName:@"Stage"];
    });
    
    fetch.predicate = predicate;
    
    NSError *error = nil;
    NSUInteger result = [self countForFetchRequest:fetch error:&error];
    
    if(result == NSNotFound) {
        NSLog(@"Count of Stage objects failed; error: %@", error);
        return 0;
    }
    
    return result;
}

- (NSUInteger)countOfStageObjectsWithValue:(id)value forKey:(NSString *)key {
    return [self countOfStageObjectsWithPredicate:[NSPredicate predicateWithFormat:@"%K = %@", key, value]];
}

- (NSUInteger)countOfStageObjects {
    return [self countOfStageObjectsWithPredicate:nil];
}

@end

@implementation BAStageID
@end

@implementation _BAStage

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Stage" inManagedObjectContext:moc_];
}

+ (NSString *)entityName {
	return @"Stage";
}

+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Stage" inManagedObjectContext:moc_];
}

- (BAStageID *)objectID {
	return (BAStageID *)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}



@dynamic partitionRoot;


@end
