// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// This template requires Bored Astronaut Core Data Additions (BAAdditions)
// Make changes to BATransform.m instead.

#import "_BATransform.h"


@implementation NSManagedObjectContext (BATransformConveniences)

- (BATransform *)findBATransformWithID:(BATransformID *)objectID {
    return (BATransform *)[self objectWithID:objectID];
}

- (BATransform *)insertBATransform {
	return [NSEntityDescription insertNewObjectForEntityForName:@"Transform" inManagedObjectContext:self];
}

- (NSUInteger)countOfTransformObjectsWithPredicate:(NSPredicate *)predicate {
    
    __strong static NSFetchRequest *fetch;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fetch = [NSFetchRequest fetchRequestWithEntityName:@"Transform"];
    });
    
    fetch.predicate = predicate;
    
    NSError *error = nil;
    NSUInteger result = [self countForFetchRequest:fetch error:&error];
    
    if(result == NSNotFound) {
        NSLog(@"Count of Transform objects failed; error: %@", error);
        return 0;
    }
    
    return result;
}

- (NSUInteger)countOfTransformObjectsWithValue:(id)value forKey:(NSString *)key {
    return [self countOfTransformObjectsWithPredicate:[NSPredicate predicateWithFormat:@"%K = %@", key, value]];
}

- (NSUInteger)countOfTransformObjects {
    return [self countOfTransformObjectsWithPredicate:nil];
}

@end

@implementation BATransformID
@end

@implementation _BATransform

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Transform" inManagedObjectContext:moc_];
}

+ (NSString *)entityName {
	return @"Transform";
}

+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Transform" inManagedObjectContext:moc_];
}

- (BATransformID *)objectID {
	return (BATransformID *)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"lxValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"lx"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"lyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"ly"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"lzValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"lz"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"rxValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rx"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"ryValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"ry"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"rzValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rz"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"sxValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"sx"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"syValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"sy"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"szValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"sz"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}


@dynamic lx;

- (double)lxValue {
	NSNumber *result = [self lx];
	return [result doubleValue];
}

- (void)setLxValue:(double)value_ {
	[self setLx:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveLxValue {
	NSNumber *result = [self primitiveLx];
	return [result doubleValue];
}

- (void)setPrimitiveLxValue:(double)value_ {
	[self setPrimitiveLx:[NSNumber numberWithDouble:value_]];
}

@dynamic ly;

- (double)lyValue {
	NSNumber *result = [self ly];
	return [result doubleValue];
}

- (void)setLyValue:(double)value_ {
	[self setLy:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveLyValue {
	NSNumber *result = [self primitiveLy];
	return [result doubleValue];
}

- (void)setPrimitiveLyValue:(double)value_ {
	[self setPrimitiveLy:[NSNumber numberWithDouble:value_]];
}

@dynamic lz;

- (double)lzValue {
	NSNumber *result = [self lz];
	return [result doubleValue];
}

- (void)setLzValue:(double)value_ {
	[self setLz:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveLzValue {
	NSNumber *result = [self primitiveLz];
	return [result doubleValue];
}

- (void)setPrimitiveLzValue:(double)value_ {
	[self setPrimitiveLz:[NSNumber numberWithDouble:value_]];
}

@dynamic rx;

- (double)rxValue {
	NSNumber *result = [self rx];
	return [result doubleValue];
}

- (void)setRxValue:(double)value_ {
	[self setRx:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveRxValue {
	NSNumber *result = [self primitiveRx];
	return [result doubleValue];
}

- (void)setPrimitiveRxValue:(double)value_ {
	[self setPrimitiveRx:[NSNumber numberWithDouble:value_]];
}

@dynamic ry;

- (double)ryValue {
	NSNumber *result = [self ry];
	return [result doubleValue];
}

- (void)setRyValue:(double)value_ {
	[self setRy:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveRyValue {
	NSNumber *result = [self primitiveRy];
	return [result doubleValue];
}

- (void)setPrimitiveRyValue:(double)value_ {
	[self setPrimitiveRy:[NSNumber numberWithDouble:value_]];
}

@dynamic rz;

- (double)rzValue {
	NSNumber *result = [self rz];
	return [result doubleValue];
}

- (void)setRzValue:(double)value_ {
	[self setRz:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveRzValue {
	NSNumber *result = [self primitiveRz];
	return [result doubleValue];
}

- (void)setPrimitiveRzValue:(double)value_ {
	[self setPrimitiveRz:[NSNumber numberWithDouble:value_]];
}

@dynamic sx;

- (double)sxValue {
	NSNumber *result = [self sx];
	return [result doubleValue];
}

- (void)setSxValue:(double)value_ {
	[self setSx:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveSxValue {
	NSNumber *result = [self primitiveSx];
	return [result doubleValue];
}

- (void)setPrimitiveSxValue:(double)value_ {
	[self setPrimitiveSx:[NSNumber numberWithDouble:value_]];
}

@dynamic sy;

- (double)syValue {
	NSNumber *result = [self sy];
	return [result doubleValue];
}

- (void)setSyValue:(double)value_ {
	[self setSy:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveSyValue {
	NSNumber *result = [self primitiveSy];
	return [result doubleValue];
}

- (void)setPrimitiveSyValue:(double)value_ {
	[self setPrimitiveSy:[NSNumber numberWithDouble:value_]];
}

@dynamic sz;

- (double)szValue {
	NSNumber *result = [self sz];
	return [result doubleValue];
}

- (void)setSzValue:(double)value_ {
	[self setSz:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveSzValue {
	NSNumber *result = [self primitiveSz];
	return [result doubleValue];
}

- (void)setPrimitiveSzValue:(double)value_ {
	[self setPrimitiveSz:[NSNumber numberWithDouble:value_]];
}


@dynamic prop;

@dynamic protypeMesh;


@end
