// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// This template requires Bored Astronaut Core Data Additions (BAAdditions)
// Make changes to BAPrototype.m instead.

#import "_BAPrototype.h"


@implementation NSManagedObjectContext (BAPrototypeConveniences)

- (BAPrototype *)findBAPrototypeWithID:(BAPrototypeID *)objectID {
    return (BAPrototype *)[self objectWithID:objectID];
}

- (BAPrototype *)insertBAPrototype {
	return [NSEntityDescription insertNewObjectForEntityForName:@"Prototype" inManagedObjectContext:self];
}

- (NSUInteger)countOfPrototypeObjectsWithPredicate:(NSPredicate *)predicate {
    
    __strong static NSFetchRequest *fetch;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fetch = [NSFetchRequest fetchRequestWithEntityName:@"Prototype"];
    });
    
    fetch.predicate = predicate;
    
    NSError *error = nil;
    NSUInteger result = [self countForFetchRequest:fetch error:&error];
    
    if(result == NSNotFound) {
        NSLog(@"Count of Prototype objects failed; error: %@", error);
        return 0;
    }
    
    return result;
}

- (NSUInteger)countOfPrototypeObjectsWithValue:(id)value forKey:(NSString *)key {
    return [self countOfPrototypeObjectsWithPredicate:[NSPredicate predicateWithFormat:@"%K = %@", key, value]];
}

- (NSUInteger)countOfPrototypeObjects {
    return [self countOfPrototypeObjectsWithPredicate:nil];
}

@end

@implementation BAPrototypeID
@end

@implementation _BAPrototype

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Prototype" inManagedObjectContext:moc_];
}

+ (NSString *)entityName {
	return @"Prototype";
}

+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Prototype" inManagedObjectContext:moc_];
}

- (BAPrototypeID *)objectID {
	return (BAPrototypeID *)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}


@dynamic name;


@dynamic props;

- (NSMutableSet *)propsSet {
	[self willAccessValueForKey:@"props"];
  
	NSMutableSet *result = (NSMutableSet *)[self mutableSetValueForKey:@"props"];
  
	[self didAccessValueForKey:@"props"];
	return result;
}

@dynamic prototypeMeshes;

- (NSMutableSet *)prototypeMeshesSet {
	[self willAccessValueForKey:@"prototypeMeshes"];
  
	NSMutableSet *result = (NSMutableSet *)[self mutableSetValueForKey:@"prototypeMeshes"];
  
	[self didAccessValueForKey:@"prototypeMeshes"];
	return result;
}


@end
