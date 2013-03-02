// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BAGroup.m instead.

#import "_BAGroup.h"

@implementation BAGroupID
@end

@implementation _BAGroup

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Group" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Group";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Group" inManagedObjectContext:moc_];
}

- (BAGroupID*)objectID {
	return (BAGroupID*)[super objectID];
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

	
- (NSMutableSet*)propsSet {
	[self willAccessValueForKey:@"props"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"props"];
	[self didAccessValueForKey:@"props"];
	return result;
}
	

@dynamic subgroups;

	
- (NSMutableSet*)subgroupsSet {
	[self willAccessValueForKey:@"subgroups"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"subgroups"];
	[self didAccessValueForKey:@"subgroups"];
	return result;
}
	

@dynamic supergroup;

	





@end
