// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// This template requires Bored Astronaut Core Data Additions (BAAdditions)
// Make changes to BAPropGroup.m instead.

#import "_BAPropGroup.h"


@implementation NSManagedObjectContext (BAPropGroupConveniences)

- (BAPropGroup *)findBAPropGroupWithID:(BAPropGroupID *)objectID {
    return (BAPropGroup *)[self objectWithID:objectID];
}

- (BAPropGroup *)insertBAPropGroup {
	return (BAPropGroup *)[NSEntityDescription insertNewObjectForEntityForName:@"PropGroup" inManagedObjectContext:self];
}

- (NSUInteger)countOfPropGroupObjectsWithPredicate:(NSPredicate *)predicate {
    
    __strong static NSFetchRequest *fetch;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fetch = [NSFetchRequest fetchRequestWithEntityName:@"PropGroup"];
    });
    
    fetch.predicate = predicate;
    
    NSError *error = nil;
    NSUInteger result = [self countForFetchRequest:fetch error:&error];
    
    if(result == NSNotFound) {
        NSLog(@"Count of PropGroup objects failed; error: %@", error);
        return 0;
    }
    
    return result;
}

- (NSUInteger)countOfPropGroupObjectsWithValue:(id)value forKey:(NSString *)key {
    return [self countOfPropGroupObjectsWithPredicate:[NSPredicate predicateWithFormat:@"%K = %@", key, value]];
}

- (NSUInteger)countOfPropGroupObjects {
    return [self countOfPropGroupObjectsWithPredicate:nil];
}

@end

@implementation BAPropGroupID
@end

@implementation _BAPropGroup

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PropGroup" inManagedObjectContext:moc_];
}

+ (NSString *)entityName {
	return @"PropGroup";
}

+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PropGroup" inManagedObjectContext:moc_];
}

- (BAPropGroupID *)objectID {
	return (BAPropGroupID *)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"flattenedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"flattened"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}


@dynamic boundsData;

@dynamic flattened;

- (BOOL)flattenedValue {
	NSNumber *result = [self flattened];
	return [result boolValue];
}

- (void)setFlattenedValue:(BOOL)value_ {
	[self setFlattened:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveFlattenedValue {
	NSNumber *result = [self primitiveFlattened];
	return [result boolValue];
}

- (void)setPrimitiveFlattenedValue:(BOOL)value_ {
	[self setPrimitiveFlattened:[NSNumber numberWithBool:value_]];
}

@dynamic mergedPropName;

@dynamic name;


@dynamic props;

- (NSMutableSet *)propsSet {
	[self willAccessValueForKey:@"props"];
  
	NSMutableSet *result = (NSMutableSet *)[self mutableSetValueForKey:@"props"];
  
	[self didAccessValueForKey:@"props"];
	return result;
}

@dynamic subgroups;

- (NSMutableSet *)subgroupsSet {
	[self willAccessValueForKey:@"subgroups"];
  
	NSMutableSet *result = (NSMutableSet *)[self mutableSetValueForKey:@"subgroups"];
  
	[self didAccessValueForKey:@"subgroups"];
	return result;
}

@dynamic supergroup;


@end
