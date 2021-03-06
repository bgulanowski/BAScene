// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// This template requires Bored Astronaut Core Data Additions (BAAdditions)
// Make changes to BATuple.m instead.

#import "_BATuple.h"


@implementation NSManagedObjectContext (BATupleConveniences)

- (BATuple *)findBATupleWithID:(BATupleID *)objectID {
    return (BATuple *)[self objectWithID:objectID];
}

- (BATuple *)insertBATuple {
	return [NSEntityDescription insertNewObjectForEntityForName:@"Tuple" inManagedObjectContext:self];
}

- (NSUInteger)countOfTupleObjectsWithPredicate:(NSPredicate *)predicate {
    
    __strong static NSFetchRequest *fetch;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fetch = [NSFetchRequest fetchRequestWithEntityName:@"Tuple"];
    });
    
    fetch.predicate = predicate;
    
    NSError *error = nil;
    NSUInteger result = [self countForFetchRequest:fetch error:&error];
    
    if(result == NSNotFound) {
        NSLog(@"Count of Tuple objects failed; error: %@", error);
        return 0;
    }
    
    return result;
}

- (NSUInteger)countOfTupleObjectsWithValue:(id)value forKey:(NSString *)key {
    return [self countOfTupleObjectsWithPredicate:[NSPredicate predicateWithFormat:@"%K = %@", key, value]];
}

- (NSUInteger)countOfTupleObjects {
    return [self countOfTupleObjectsWithPredicate:nil];
}

@end

@implementation BATupleID
@end

@implementation _BATuple

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Tuple" inManagedObjectContext:moc_];
}

+ (NSString *)entityName {
	return @"Tuple";
}

+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Tuple" inManagedObjectContext:moc_];
}

- (BATupleID *)objectID {
	return (BATupleID *)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"xValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"x"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"yValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"y"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"zValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"z"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}


@dynamic x;

- (double)xValue {
	NSNumber *result = [self x];
	return [result doubleValue];
}

- (void)setXValue:(double)value_ {
	[self setX:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveXValue {
	NSNumber *result = [self primitiveX];
	return [result doubleValue];
}

- (void)setPrimitiveXValue:(double)value_ {
	[self setPrimitiveX:[NSNumber numberWithDouble:value_]];
}

@dynamic y;

- (double)yValue {
	NSNumber *result = [self y];
	return [result doubleValue];
}

- (void)setYValue:(double)value_ {
	[self setY:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveYValue {
	NSNumber *result = [self primitiveY];
	return [result doubleValue];
}

- (void)setPrimitiveYValue:(double)value_ {
	[self setPrimitiveY:[NSNumber numberWithDouble:value_]];
}

@dynamic z;

- (double)zValue {
	NSNumber *result = [self z];
	return [result doubleValue];
}

- (void)setZValue:(double)value_ {
	[self setZ:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveZValue {
	NSNumber *result = [self primitiveZ];
	return [result doubleValue];
}

- (void)setPrimitiveZValue:(double)value_ {
	[self setPrimitiveZ:[NSNumber numberWithDouble:value_]];
}


@dynamic nPoints;

- (NSMutableSet *)nPointsSet {
	[self willAccessValueForKey:@"nPoints"];
  
	NSMutableSet *result = (NSMutableSet *)[self mutableSetValueForKey:@"nPoints"];
  
	[self didAccessValueForKey:@"nPoints"];
	return result;
}

@dynamic partitions;

- (NSMutableSet *)partitionsSet {
	[self willAccessValueForKey:@"partitions"];
  
	NSMutableSet *result = (NSMutableSet *)[self mutableSetValueForKey:@"partitions"];
  
	[self didAccessValueForKey:@"partitions"];
	return result;
}

@dynamic tPoints;

- (NSMutableSet *)tPointsSet {
	[self willAccessValueForKey:@"tPoints"];
  
	NSMutableSet *result = (NSMutableSet *)[self mutableSetValueForKey:@"tPoints"];
  
	[self didAccessValueForKey:@"tPoints"];
	return result;
}

@dynamic vPoints;

- (NSMutableSet *)vPointsSet {
	[self willAccessValueForKey:@"vPoints"];
  
	NSMutableSet *result = (NSMutableSet *)[self mutableSetValueForKey:@"vPoints"];
  
	[self didAccessValueForKey:@"vPoints"];
	return result;
}


+ (NSArray *)fetchRelatedVertices:(NSManagedObjectContext *)moc_ sortDescriptors:(NSArray *)sortDescriptors POLYGON:(BAPolygon *)POLYGON_ {
	NSError *error = nil;
	NSArray *result = [self fetchRelatedVertices:moc_ sortDescriptors:sortDescriptors POLYGON:POLYGON_ error:&error];
	if (error)
		NSLog(@"error: %@", error);

	return result;
}

+ (NSArray *)fetchRelatedVertices:(NSManagedObjectContext *)moc_ sortDescriptors:(NSArray *)sortDescriptors POLYGON:(BAPolygon *)POLYGON_ error:(NSError **)error_ {
	NSParameterAssert(moc_);
	NSError *error = nil;
	
	NSManagedObjectModel *model = [[moc_ persistentStoreCoordinator] managedObjectModel];
	
	NSDictionary *substitutionVariables = [NSDictionary dictionaryWithObjectsAndKeys:
														
														POLYGON_, @"POLYGON",
														
														nil];
										
	NSFetchRequest *fetchRequest = [model fetchRequestFromTemplateWithName:@"relatedVertices"
													 substitutionVariables:substitutionVariables];
	NSAssert(fetchRequest, @"Can't find fetch request named \"relatedVertices\".");

    [fetchRequest setSortDescriptors:sortDescriptors];

	NSArray *result = [moc_ executeFetchRequest:fetchRequest error:&error];
	if (error_) *error_ = error;
	return result;
}

@end
