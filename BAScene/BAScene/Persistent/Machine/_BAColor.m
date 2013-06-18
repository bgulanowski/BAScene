// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// This template requires Bored Astronaut Core Data Additions (BAAdditions)
// Make changes to BAColor.m instead.

#import "_BAColor.h"


@implementation NSManagedObjectContext (BAColorConveniences)

- (BAColor *)findBAColorWithID:(BAColorID *)objectID {
    return (BAColor *)[self objectWithID:objectID];
}

- (BAColor *)insertBAColor {
	return [NSEntityDescription insertNewObjectForEntityForName:@"Color" inManagedObjectContext:self];
}

- (NSUInteger)countOfColorObjectsWithPredicate:(NSPredicate *)predicate {
    
    __strong static NSFetchRequest *fetch;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fetch = [NSFetchRequest fetchRequestWithEntityName:@"Color"];
    });
    
    fetch.predicate = predicate;
    
    NSError *error = nil;
    NSUInteger result = [self countForFetchRequest:fetch error:&error];
    
    if(result == NSNotFound) {
        NSLog(@"Count of Color objects failed; error: %@", error);
        return 0;
    }
    
    return result;
}

- (NSUInteger)countOfColorObjectsWithValue:(id)value forKey:(NSString *)key {
    return [self countOfColorObjectsWithPredicate:[NSPredicate predicateWithFormat:@"%K = %@", key, value]];
}

- (NSUInteger)countOfColorObjects {
    return [self countOfColorObjectsWithPredicate:nil];
}

@end

@implementation BAColorID
@end

@implementation _BAColor

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Color" inManagedObjectContext:moc_];
}

+ (NSString *)entityName {
	return @"Color";
}

+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Color" inManagedObjectContext:moc_];
}

- (BAColorID *)objectID {
	return (BAColorID *)[super objectID];
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
	if ([key isEqualToString:@"gValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"g"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"rValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"r"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}


@dynamic a;

- (float)aValue {
	NSNumber *result = [self a];
	return [result floatValue];
}

- (void)setAValue:(float)value_ {
	[self setA:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveAValue {
	NSNumber *result = [self primitiveA];
	return [result floatValue];
}

- (void)setPrimitiveAValue:(float)value_ {
	[self setPrimitiveA:[NSNumber numberWithFloat:value_]];
}

@dynamic b;

- (float)bValue {
	NSNumber *result = [self b];
	return [result floatValue];
}

- (void)setBValue:(float)value_ {
	[self setB:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveBValue {
	NSNumber *result = [self primitiveB];
	return [result floatValue];
}

- (void)setPrimitiveBValue:(float)value_ {
	[self setPrimitiveB:[NSNumber numberWithFloat:value_]];
}

@dynamic g;

- (float)gValue {
	NSNumber *result = [self g];
	return [result floatValue];
}

- (void)setGValue:(float)value_ {
	[self setG:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveGValue {
	NSNumber *result = [self primitiveG];
	return [result floatValue];
}

- (void)setPrimitiveGValue:(float)value_ {
	[self setPrimitiveG:[NSNumber numberWithFloat:value_]];
}

@dynamic r;

- (float)rValue {
	NSNumber *result = [self r];
	return [result floatValue];
}

- (void)setRValue:(float)value_ {
	[self setR:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveRValue {
	NSNumber *result = [self primitiveR];
	return [result floatValue];
}

- (void)setPrimitiveRValue:(float)value_ {
	[self setPrimitiveR:[NSNumber numberWithFloat:value_]];
}


@dynamic points;

- (NSMutableSet *)pointsSet {
	[self willAccessValueForKey:@"points"];
  
	NSMutableSet *result = (NSMutableSet *)[self mutableSetValueForKey:@"points"];
  
	[self didAccessValueForKey:@"points"];
	return result;
}

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
