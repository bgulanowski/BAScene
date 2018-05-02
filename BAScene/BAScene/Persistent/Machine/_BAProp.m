// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// This template requires Bored Astronaut Core Data Additions (BAAdditions)
// Make changes to BAProp.m instead.

#import "_BAProp.h"


@implementation NSManagedObjectContext (BAPropConveniences)

- (BAProp *)findBAPropWithID:(BAPropID *)objectID {
    return (BAProp *)[self objectWithID:objectID];
}

- (BAProp *)insertBAProp {
	return (BAProp *)[NSEntityDescription insertNewObjectForEntityForName:@"Prop" inManagedObjectContext:self];
}

- (NSUInteger)countOfPropObjectsWithPredicate:(NSPredicate *)predicate {
    
    __strong static NSFetchRequest *fetch;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fetch = [NSFetchRequest fetchRequestWithEntityName:@"Prop"];
    });
    
    fetch.predicate = predicate;
    
    NSError *error = nil;
    NSUInteger result = [self countForFetchRequest:fetch error:&error];
    
    if(result == NSNotFound) {
        NSLog(@"Count of Prop objects failed; error: %@", error);
        return 0;
    }
    
    return result;
}

- (NSUInteger)countOfPropObjectsWithValue:(id)value forKey:(NSString *)key {
    return [self countOfPropObjectsWithPredicate:[NSPredicate predicateWithFormat:@"%K = %@", key, value]];
}

- (NSUInteger)countOfPropObjects {
    return [self countOfPropObjectsWithPredicate:nil];
}

@end

@implementation BAPropID
@end

@implementation _BAProp

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Prop" inManagedObjectContext:moc_];
}

+ (NSString *)entityName {
	return @"Prop";
}

+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Prop" inManagedObjectContext:moc_];
}

- (BAPropID *)objectID {
	return (BAPropID *)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}


@dynamic boundsData;

@dynamic name;


@dynamic color;

@dynamic group;

@dynamic prototype;

@dynamic transform;


@end
