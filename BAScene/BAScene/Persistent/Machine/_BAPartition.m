// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// This template requires Bored Astronaut Core Data Additions (BAAdditions)
// Make changes to BAPartition.m instead.

#import "_BAPartition.h"


@implementation NSManagedObjectContext (BAPartitionConveniences)

- (BAPartition *)findBAPartitionWithID:(BAPartitionID *)objectID {
    return (BAPartition *)[self objectWithID:objectID];
}

- (BAPartition *)insertBAPartition {
	return [NSEntityDescription insertNewObjectForEntityForName:@"Partition" inManagedObjectContext:self];
}

- (NSUInteger)countOfPartitionObjectsWithPredicate:(NSPredicate *)predicate {
    
    __strong static NSFetchRequest *fetch;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fetch = [NSFetchRequest fetchRequestWithEntityName:@"Partition"];
    });
    
    fetch.predicate = predicate;
    
    NSError *error = nil;
    NSUInteger result = [self countForFetchRequest:fetch error:&error];
    
    if(result == NSNotFound) {
        NSLog(@"Count of Partition objects failed; error: %@", error);
        return 0;
    }
    
    return result;
}

- (NSUInteger)countOfPartitionObjectsWithValue:(id)value forKey:(NSString *)key {
    return [self countOfPartitionObjectsWithPredicate:[NSPredicate predicateWithFormat:@"%K = %@", key, value]];
}

- (NSUInteger)countOfPartitionObjects {
    return [self countOfPartitionObjectsWithPredicate:nil];
}

@end

@implementation BAPartitionID
@end

@implementation _BAPartition

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Partition" inManagedObjectContext:moc_];
}

+ (NSString *)entityName {
	return @"Partition";
}

+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Partition" inManagedObjectContext:moc_];
}

- (BAPartitionID *)objectID {
	return (BAPartitionID *)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"dimensionValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"dimension"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"indexValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"index"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}


@dynamic dimension;

- (double)dimensionValue {
	NSNumber *result = [self dimension];
	return [result doubleValue];
}

- (void)setDimensionValue:(double)value_ {
	[self setDimension:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveDimensionValue {
	NSNumber *result = [self primitiveDimension];
	return [result doubleValue];
}

- (void)setPrimitiveDimensionValue:(double)value_ {
	[self setPrimitiveDimension:[NSNumber numberWithDouble:value_]];
}

@dynamic index;

- (int16_t)indexValue {
	NSNumber *result = [self index];
	return [result shortValue];
}

- (void)setIndexValue:(int16_t)value_ {
	[self setIndex:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveIndexValue {
	NSNumber *result = [self primitiveIndex];
	return [result shortValue];
}

- (void)setPrimitiveIndexValue:(int16_t)value_ {
	[self setPrimitiveIndex:[NSNumber numberWithShort:value_]];
}


@dynamic location;

@dynamic stage;

@dynamic children;


@end
