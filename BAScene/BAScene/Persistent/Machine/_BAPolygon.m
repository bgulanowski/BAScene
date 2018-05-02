// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// This template requires Bored Astronaut Core Data Additions (BAAdditions)
// Make changes to BAPolygon.m instead.

#import "_BAPolygon.h"


@implementation NSManagedObjectContext (BAPolygonConveniences)

- (BAPolygon *)findBAPolygonWithID:(BAPolygonID *)objectID {
    return (BAPolygon *)[self objectWithID:objectID];
}

- (BAPolygon *)insertBAPolygon {
	return (BAPolygon *)[NSEntityDescription insertNewObjectForEntityForName:@"Polygon" inManagedObjectContext:self];
}

- (NSUInteger)countOfPolygonObjectsWithPredicate:(NSPredicate *)predicate {
    
    __strong static NSFetchRequest *fetch;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fetch = [NSFetchRequest fetchRequestWithEntityName:@"Polygon"];
    });
    
    fetch.predicate = predicate;
    
    NSError *error = nil;
    NSUInteger result = [self countForFetchRequest:fetch error:&error];
    
    if(result == NSNotFound) {
        NSLog(@"Count of Polygon objects failed; error: %@", error);
        return 0;
    }
    
    return result;
}

- (NSUInteger)countOfPolygonObjectsWithValue:(id)value forKey:(NSString *)key {
    return [self countOfPolygonObjectsWithPredicate:[NSPredicate predicateWithFormat:@"%K = %@", key, value]];
}

- (NSUInteger)countOfPolygonObjects {
    return [self countOfPolygonObjectsWithPredicate:nil];
}

@end

@implementation BAPolygonID
@end

@implementation _BAPolygon

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Polygon" inManagedObjectContext:moc_];
}

+ (NSString *)entityName {
	return @"Polygon";
}

+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Polygon" inManagedObjectContext:moc_];
}

- (BAPolygonID *)objectID {
	return (BAPolygonID *)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"aValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"a"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"bValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"b"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"cValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"c"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}


@dynamic a;

- (double)aValue {
	NSNumber *result = [self a];
	return [result doubleValue];
}

- (void)setAValue:(double)value_ {
	[self setA:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveAValue {
	NSNumber *result = [self primitiveA];
	return [result doubleValue];
}

- (void)setPrimitiveAValue:(double)value_ {
	[self setPrimitiveA:[NSNumber numberWithDouble:value_]];
}

@dynamic b;

- (double)bValue {
	NSNumber *result = [self b];
	return [result doubleValue];
}

- (void)setBValue:(double)value_ {
	[self setB:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveBValue {
	NSNumber *result = [self primitiveB];
	return [result doubleValue];
}

- (void)setPrimitiveBValue:(double)value_ {
	[self setPrimitiveB:[NSNumber numberWithDouble:value_]];
}

@dynamic c;

- (double)cValue {
	NSNumber *result = [self c];
	return [result doubleValue];
}

- (void)setCValue:(double)value_ {
	[self setC:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveCValue {
	NSNumber *result = [self primitiveC];
	return [result doubleValue];
}

- (void)setPrimitiveCValue:(double)value_ {
	[self setPrimitiveC:[NSNumber numberWithDouble:value_]];
}


@dynamic mesh;

@dynamic points;

- (NSMutableSet *)pointsSet {
	[self willAccessValueForKey:@"points"];
  
	NSMutableSet *result = (NSMutableSet *)[self mutableSetValueForKey:@"points"];
  
	[self didAccessValueForKey:@"points"];
	return result;
}


@end
