// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// This template requires Bored Astronaut Core Data Additions (BAAdditions)
// Make changes to BAMesh.m instead.

#import "_BAMesh.h"


@implementation NSManagedObjectContext (BAMeshConveniences)

- (BAMesh *)findBAMeshWithID:(BAMeshID *)objectID {
    return (BAMesh *)[self objectWithID:objectID];
}

- (BAMesh *)insertBAMesh {
	return [NSEntityDescription insertNewObjectForEntityForName:@"Mesh" inManagedObjectContext:self];
}

- (NSUInteger)countOfMeshObjectsWithPredicate:(NSPredicate *)predicate {
    
    __strong static NSFetchRequest *fetch;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fetch = [NSFetchRequest fetchRequestWithEntityName:@"Mesh"];
    });
    
    fetch.predicate = predicate;
    
    NSError *error = nil;
    NSUInteger result = [self countForFetchRequest:fetch error:&error];
    
    if(result == NSNotFound) {
        NSLog(@"Count of Mesh objects failed; error: %@", error);
        return 0;
    }
    
    return result;
}

- (NSUInteger)countOfMeshObjectsWithValue:(id)value forKey:(NSString *)key {
    return [self countOfMeshObjectsWithPredicate:[NSPredicate predicateWithFormat:@"%K = %@", key, value]];
}

- (NSUInteger)countOfMeshObjects {
    return [self countOfMeshObjectsWithPredicate:nil];
}

@end

@implementation BAMeshID
@end

@implementation _BAMesh

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Mesh" inManagedObjectContext:moc_];
}

+ (NSString *)entityName {
	return @"Mesh";
}

+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Mesh" inManagedObjectContext:moc_];
}

- (BAMeshID *)objectID {
	return (BAMeshID *)[super objectID];
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

- (int16_t)levelValue {
	NSNumber *result = [self level];
	return [result shortValue];
}

- (void)setLevelValue:(int16_t)value_ {
	[self setLevel:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveLevelValue {
	NSNumber *result = [self primitiveLevel];
	return [result shortValue];
}

- (void)setPrimitiveLevelValue:(int16_t)value_ {
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

- (int16_t)typeValue {
	NSNumber *result = [self type];
	return [result shortValue];
}

- (void)setTypeValue:(int16_t)value_ {
	[self setType:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveTypeValue {
	NSNumber *result = [self primitiveType];
	return [result shortValue];
}

- (void)setPrimitiveTypeValue:(int16_t)value_ {
	[self setPrimitiveType:[NSNumber numberWithShort:value_]];
}


@dynamic polygons;

- (NSMutableSet *)polygonsSet {
	[self willAccessValueForKey:@"polygons"];
  
	NSMutableSet *result = (NSMutableSet *)[self mutableSetValueForKey:@"polygons"];
  
	[self didAccessValueForKey:@"polygons"];
	return result;
}

@dynamic prototypeMeshes;

- (NSMutableSet *)prototypeMeshesSet {
	[self willAccessValueForKey:@"prototypeMeshes"];
  
	NSMutableSet *result = (NSMutableSet *)[self mutableSetValueForKey:@"prototypeMeshes"];
  
	[self didAccessValueForKey:@"prototypeMeshes"];
	return result;
}

@dynamic resources;

- (NSMutableSet *)resourcesSet {
	[self willAccessValueForKey:@"resources"];
  
	NSMutableSet *result = (NSMutableSet *)[self mutableSetValueForKey:@"resources"];
  
	[self didAccessValueForKey:@"resources"];
	return result;
}


@end
