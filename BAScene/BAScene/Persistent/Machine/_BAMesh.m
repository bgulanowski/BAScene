// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BAMesh.m instead.

#import "_BAMesh.h"

@implementation BAMeshID
@end

@implementation _BAMesh

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Mesh" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Mesh";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Mesh" inManagedObjectContext:moc_];
}

- (BAMeshID*)objectID {
	return (BAMeshID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"dirtyValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"dirty"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"hasNormalsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hasNormals"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"hasTextureValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hasTexture"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"levelValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"level"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"sharedNormalsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"sharedNormals"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"typeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"type"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic dirty;



- (BOOL)dirtyValue {
	NSNumber *result = [self dirty];
	return [result boolValue];
}

- (void)setDirtyValue:(BOOL)value_ {
	[self setDirty:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveDirtyValue {
	NSNumber *result = [self primitiveDirty];
	return [result boolValue];
}

- (void)setPrimitiveDirtyValue:(BOOL)value_ {
	[self setPrimitiveDirty:[NSNumber numberWithBool:value_]];
}





@dynamic hasNormals;



- (BOOL)hasNormalsValue {
	NSNumber *result = [self hasNormals];
	return [result boolValue];
}

- (void)setHasNormalsValue:(BOOL)value_ {
	[self setHasNormals:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveHasNormalsValue {
	NSNumber *result = [self primitiveHasNormals];
	return [result boolValue];
}

- (void)setPrimitiveHasNormalsValue:(BOOL)value_ {
	[self setPrimitiveHasNormals:[NSNumber numberWithBool:value_]];
}





@dynamic hasTexture;



- (BOOL)hasTextureValue {
	NSNumber *result = [self hasTexture];
	return [result boolValue];
}

- (void)setHasTextureValue:(BOOL)value_ {
	[self setHasTexture:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveHasTextureValue {
	NSNumber *result = [self primitiveHasTexture];
	return [result boolValue];
}

- (void)setPrimitiveHasTextureValue:(BOOL)value_ {
	[self setPrimitiveHasTexture:[NSNumber numberWithBool:value_]];
}





@dynamic level;



- (short)levelValue {
	NSNumber *result = [self level];
	return [result shortValue];
}

- (void)setLevelValue:(short)value_ {
	[self setLevel:[NSNumber numberWithShort:value_]];
}

- (short)primitiveLevelValue {
	NSNumber *result = [self primitiveLevel];
	return [result shortValue];
}

- (void)setPrimitiveLevelValue:(short)value_ {
	[self setPrimitiveLevel:[NSNumber numberWithShort:value_]];
}





@dynamic name;






@dynamic sharedNormals;



- (BOOL)sharedNormalsValue {
	NSNumber *result = [self sharedNormals];
	return [result boolValue];
}

- (void)setSharedNormalsValue:(BOOL)value_ {
	[self setSharedNormals:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveSharedNormalsValue {
	NSNumber *result = [self primitiveSharedNormals];
	return [result boolValue];
}

- (void)setPrimitiveSharedNormalsValue:(BOOL)value_ {
	[self setPrimitiveSharedNormals:[NSNumber numberWithBool:value_]];
}





@dynamic type;



- (short)typeValue {
	NSNumber *result = [self type];
	return [result shortValue];
}

- (void)setTypeValue:(short)value_ {
	[self setType:[NSNumber numberWithShort:value_]];
}

- (short)primitiveTypeValue {
	NSNumber *result = [self primitiveType];
	return [result shortValue];
}

- (void)setPrimitiveTypeValue:(short)value_ {
	[self setPrimitiveType:[NSNumber numberWithShort:value_]];
}





@dynamic polygons;

	
- (NSMutableSet*)polygonsSet {
	[self willAccessValueForKey:@"polygons"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"polygons"];
	[self didAccessValueForKey:@"polygons"];
	return result;
}
	

@dynamic prototypeMeshes;

	
- (NSMutableSet*)prototypeMeshesSet {
	[self willAccessValueForKey:@"prototypeMeshes"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"prototypeMeshes"];
	[self didAccessValueForKey:@"prototypeMeshes"];
	return result;
}
	

@dynamic resources;

	
- (NSMutableSet*)resourcesSet {
	[self willAccessValueForKey:@"resources"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"resources"];
	[self didAccessValueForKey:@"resources"];
	return result;
}
	





@end
