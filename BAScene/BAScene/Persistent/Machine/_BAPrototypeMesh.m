// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BAPrototypeMesh.m instead.

#import "_BAPrototypeMesh.h"

@implementation BAPrototypeMeshID
@end

@implementation _BAPrototypeMesh

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PrototypeMesh" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"PrototypeMesh";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PrototypeMesh" inManagedObjectContext:moc_];
}

- (BAPrototypeMeshID*)objectID {
	return (BAPrototypeMeshID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"reversePolygonsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"reversePolygons"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic reversePolygons;



- (BOOL)reversePolygonsValue {
	NSNumber *result = [self reversePolygons];
	return [result boolValue];
}

- (void)setReversePolygonsValue:(BOOL)value_ {
	[self setReversePolygons:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveReversePolygonsValue {
	NSNumber *result = [self primitiveReversePolygons];
	return [result boolValue];
}

- (void)setPrimitiveReversePolygonsValue:(BOOL)value_ {
	[self setPrimitiveReversePolygons:[NSNumber numberWithBool:value_]];
}





@dynamic color;

	

@dynamic mesh;

	

@dynamic prototype;

	

@dynamic resources;

	
- (NSMutableSet*)resourcesSet {
	[self willAccessValueForKey:@"resources"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"resources"];
	[self didAccessValueForKey:@"resources"];
	return result;
}
	

@dynamic transform;

	





@end
