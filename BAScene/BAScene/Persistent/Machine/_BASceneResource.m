// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// This template requires Bored Astronaut Core Data Additions (BAAdditions)
// Make changes to BASceneResource.m instead.

#import "_BASceneResource.h"


@implementation NSManagedObjectContext (BASceneResourceConveniences)

- (BASceneResource *)findBASceneResourceWithID:(BASceneResourceID *)objectID {
    return (BASceneResource *)[self objectWithID:objectID];
}

- (BASceneResource *)insertBASceneResource {
	return (BASceneResource *)[NSEntityDescription insertNewObjectForEntityForName:@"SceneResource" inManagedObjectContext:self];
}

- (NSUInteger)countOfSceneResourceObjectsWithPredicate:(NSPredicate *)predicate {
    
    __strong static NSFetchRequest *fetch;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fetch = [NSFetchRequest fetchRequestWithEntityName:@"SceneResource"];
    });
    
    fetch.predicate = predicate;
    
    NSError *error = nil;
    NSUInteger result = [self countForFetchRequest:fetch error:&error];
    
    if(result == NSNotFound) {
        NSLog(@"Count of SceneResource objects failed; error: %@", error);
        return 0;
    }
    
    return result;
}

- (NSUInteger)countOfSceneResourceObjectsWithValue:(id)value forKey:(NSString *)key {
    return [self countOfSceneResourceObjectsWithPredicate:[NSPredicate predicateWithFormat:@"%K = %@", key, value]];
}

- (NSUInteger)countOfSceneResourceObjects {
    return [self countOfSceneResourceObjectsWithPredicate:nil];
}

@end

@implementation BASceneResourceID
@end

@implementation _BASceneResource

+ (id)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"SceneResource" inManagedObjectContext:moc_];
}

+ (NSString *)entityName {
	return @"SceneResource";
}

+ (NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"SceneResource" inManagedObjectContext:moc_];
}

- (BASceneResourceID *)objectID {
	return (BASceneResourceID *)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"typeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"type"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
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

@dynamic uniqueID;


@dynamic mesh;

@dynamic prototypeMesh;


+ (id)fetchOneTexture:(NSManagedObjectContext *)moc_ MESH:(BAMesh *)MESH_ {
	NSError *error = nil;
	id result = [self fetchOneTexture:moc_ MESH:MESH_ error:&error];
	if (error) {
		NSLog(@"error: %@", error);
	}
	return result;
}

+ (id)fetchOneTexture:(NSManagedObjectContext *)moc_ MESH:(BAMesh *)MESH_ error:(NSError **)error_ {
	NSParameterAssert(moc_);
	NSError *error = nil;
	
	NSManagedObjectModel *model = [[moc_ persistentStoreCoordinator] managedObjectModel];
	
	NSDictionary *substitutionVariables = [NSDictionary dictionaryWithObjectsAndKeys:
														
														MESH_, @"MESH",
														
														nil];
	
	NSFetchRequest *fetchRequest = [model fetchRequestFromTemplateWithName:@"oneTexture"
													 substitutionVariables:substitutionVariables];
	NSAssert(fetchRequest, @"Can't find fetch request named \"oneTexture\".");
	
	id result = nil;
	NSArray *results = [moc_ executeFetchRequest:fetchRequest error:&error];
	
	if (!error) {
		switch ([results count]) {
			case 0:
				result = nil;
				break;
			case 1:
				result = [results objectAtIndex:0];
				break;
			default:
				NSLog(@"WARN fetch request oneTexture: 0 or 1 objects expected, %u found (substitutionVariables:%@, results:%@)",
					(unsigned)[results count],
					substitutionVariables,
					results);
		}
	}
	
	if (error_) *error_ = error;
	return result;
}

@end
