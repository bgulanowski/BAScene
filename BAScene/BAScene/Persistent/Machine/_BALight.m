// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BALight.m instead.

#import "_BALight.h"

@implementation BALightID
@end

@implementation _BALight

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Light" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Light";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Light" inManagedObjectContext:moc_];
}

- (BALightID*)objectID {
	return (BALightID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}








@end
