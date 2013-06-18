// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// This template requires Bored Astronaut Core Data Additions (BAAdditions)
// Make changes to BAPrototypeMesh.m instead.

#import "_BAPrototypeMesh.h"


@implementation NSManagedObjectContext (BAPrototypeMeshConveniences)

- (BAPrototypeMesh *)findBAPrototypeMeshWithID:(BAPrototypeMeshID *)objectID {
    return (BAPrototypeMesh *)[self objectWithID:objectID];
}

- (BAPrototypeMesh *)insertBAPrototypeMesh {
	return [NSEntityDescription insertNewObjectForEntityForName:@"PrototypeMesh" inManagedObjectContext:self];
}

- (NSUInteger)countOfPrototypeMeshObjectsWithPredicate:(NSPredicate *)predicate {
    
    __strong static NSFetchRequest *fetch;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fetch = [NSFetchRequest fetchRequestWithEntityName:@"PrototypeMesh"];
    });
    
    fetch.predicate = predicate;
    
    NSError *error = nil;
    NSUInteger result = [self countForFetchRequest:fetch error:&error];
    
    if(result == NSNotFound) {
        NSLog(@"Count of PrototypeMesh objects failed; error: %@", error);
        return 0;
    }
    
    return result;
}

- (NSUInteger)countOfPrototypeMeshObjectsWithValue:(id)value forKey:(NSString *)key {
    return [self countOfPrototypeMeshObjectsWithPredicate:[NSPredicate predicateWithFormat:@"%K = %@", key, value]];
}

- (NSUInteger)countOfPrototypeMeshObjects {
    return [self countOfPrototypeMeshObjectsWithPredicate:nil];
}

@end

@implementation BAPrototypeMeshID
@end

@implementation _BAPrototypeMesh

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"PrototypeMesh" inManagedObjectContext:moc_];
}

+ (NSString *)entityName {
	return @"PrototypeMesh";
}

+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"PrototypeMesh" inManagedObjectContext:moc_];
}

- (BAPrototypeMeshID *)objectID {
	return (BAPrototypeMeshID *)[super objectID];
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

- (NSMutableSet *)resourcesSet {
	[self willAccessValueForKey:@"resources"];
  
	NSMutableSet *result = (NSMutableSet *)[self mutableSetValueForKey:@"resources"];
  
	[self didAccessValueForKey:@"resources"];
	return result;
}

@dynamic transform;


@end
