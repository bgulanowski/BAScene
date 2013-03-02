// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BAPrototype.m instead.

#import "_BAPrototype.h"

@implementation BAPrototypeID
@end

@implementation _BAPrototype

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Prototype" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Prototype";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Prototype" inManagedObjectContext:moc_];
}

- (BAPrototypeID*)objectID {
	return (BAPrototypeID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic name;






@dynamic props;

	
- (NSMutableSet*)propsSet {
	[self willAccessValueForKey:@"props"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"props"];
	[self didAccessValueForKey:@"props"];
	return result;
}
	

@dynamic prototypeMeshes;

	
- (NSMutableSet*)prototypeMeshesSet {
	[self willAccessValueForKey:@"prototypeMeshes"];
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"prototypeMeshes"];
	[self didAccessValueForKey:@"prototypeMeshes"];
	return result;
}
	





@end
