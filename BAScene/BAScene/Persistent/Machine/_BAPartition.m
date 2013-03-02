// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BAPartition.m instead.

#import "_BAPartition.h"

@implementation BAPartitionID
@end

@implementation _BAPartition

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Partition" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Partition";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Partition" inManagedObjectContext:moc_];
}

- (BAPartitionID*)objectID {
	return (BAPartitionID*)[super objectID];
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



- (short)indexValue {
	NSNumber *result = [self index];
	return [result shortValue];
}

- (void)setIndexValue:(short)value_ {
	[self setIndex:[NSNumber numberWithShort:value_]];
}

- (short)primitiveIndexValue {
	NSNumber *result = [self primitiveIndex];
	return [result shortValue];
}

- (void)setPrimitiveIndexValue:(short)value_ {
	[self setPrimitiveIndex:[NSNumber numberWithShort:value_]];
}





@dynamic location;

	

@dynamic stage;

	





@end
