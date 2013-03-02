// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BAPoint.m instead.

#import "_BAPoint.h"

@implementation BAPointID
@end

@implementation _BAPoint

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Point" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Point";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Point" inManagedObjectContext:moc_];
}

- (BAPointID*)objectID {
	return (BAPointID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"indexValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"index"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
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





@dynamic color;

	

@dynamic normal;

	

@dynamic polygon;

	

@dynamic texCoord;

	

@dynamic vertex;

	






+ (NSArray*)fetchRelated:(NSManagedObjectContext*)moc_ sortDescriptors:(NSArray *)sortDescriptors POLYGON:(BAPolygon*)POLYGON_
{

	NSError *error = nil;
	NSArray *result = [self fetchRelated:moc_ sortDescriptors:sortDescriptors POLYGON:POLYGON_ error:&error];
	if (error) {
#if TARGET_OS_IPHONE
		NSLog(@"error: %@", error);
#else
		[NSApp presentError:error];
#endif
	}
	return result;
}

+ (NSArray*)fetchRelated:(NSManagedObjectContext*)moc_ sortDescriptors:(NSArray *)sortDescriptors POLYGON:(BAPolygon*)POLYGON_ error:(NSError**)error_ {
	NSParameterAssert(moc_);
	NSError *error = nil;
	
	NSManagedObjectModel *model = [[moc_ persistentStoreCoordinator] managedObjectModel];
	
	NSDictionary *substitutionVariables = [NSDictionary dictionaryWithObjectsAndKeys:
														
														POLYGON_, @"POLYGON",
														
														nil];
										
	NSFetchRequest *fetchRequest = [model fetchRequestFromTemplateWithName:@"related"
													 substitutionVariables:substitutionVariables];
	NSAssert(fetchRequest, @"Can't find fetch request named \"related\".");
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	NSArray *result = [moc_ executeFetchRequest:fetchRequest error:&error];
	if (error_) *error_ = error;
	return result;
}


+ (NSArray*)fetchConnected:(NSManagedObjectContext*)moc_ sortDescriptors:(NSArray *)sortDescriptors MESH:(BAMesh*)MESH_
{
	NSError *error = nil;
	NSArray *result = [self fetchConnected:moc_ sortDescriptors:sortDescriptors MESH:MESH_ error:&error];
	if (error) {
#if TARGET_OS_IPHONE
		NSLog(@"error: %@", error);
#else
		[NSApp presentError:error];
#endif
	}
	return result;
}

+ (NSArray*)fetchConnected:(NSManagedObjectContext*)moc_ sortDescriptors:(NSArray *)sortDescriptors MESH:(BAMesh*)MESH_ error:(NSError**)error_ {
	NSParameterAssert(moc_);
	NSError *error = nil;
	
	NSManagedObjectModel *model = [[moc_ persistentStoreCoordinator] managedObjectModel];
	
	NSDictionary *substitutionVariables = [NSDictionary dictionaryWithObjectsAndKeys:
														
														MESH_, @"MESH",
														
														nil];
										
	NSFetchRequest *fetchRequest = [model fetchRequestFromTemplateWithName:@"connected"
													 substitutionVariables:substitutionVariables];
	NSAssert(fetchRequest, @"Can't find fetch request named \"connected\".");
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	NSArray *result = [moc_ executeFetchRequest:fetchRequest error:&error];
	if (error_) *error_ = error;
	return result;
}

@end
