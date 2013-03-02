// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BAResource.m instead.

#import "_BAResource.h"

@implementation BAResourceID
@end

@implementation _BAResource

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Resource" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Resource";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Resource" inManagedObjectContext:moc_];
}

- (BAResourceID*)objectID {
	return (BAResourceID*)[super objectID];
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





@dynamic uniqueID;






@dynamic mesh;

	

@dynamic prototypeMesh;

	






+ (id)fetchOneTexture:(NSManagedObjectContext*)moc_ MESH:(BAMesh*)MESH_ {
	NSError *error = nil;
	id result = [self fetchOneTexture:moc_ MESH:MESH_ error:&error];
	if (error) {
#if TARGET_OS_IPHONE
		NSLog(@"error: %@", error);
#else
		[NSApp presentError:error];
#endif
	}
	return result;
}
+ (id)fetchOneTexture:(NSManagedObjectContext*)moc_ MESH:(BAMesh*)MESH_ error:(NSError**)error_ {
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
				//	Nothing found matching the fetch request. That's cool, though: we'll just return nil.
				break;
			case 1:
				result = [results objectAtIndex:0];
				break;
			default:
				NSLog(@"WARN fetch request oneTexture: 0 or 1 objects expected, %lu found (substitutionVariables:%@, results:%@)",
					(unsigned long)[results count],
					substitutionVariables,
					results);
		}
	}
	
	if (error_) *error_ = error;
	return result;
}


@end
