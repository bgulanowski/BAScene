// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BAScenePref.m instead.

#import "_BAScenePref.h"

@implementation BAScenePrefID
@end

@implementation _BAScenePref

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Pref" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Pref";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Pref" inManagedObjectContext:moc_];
}

- (BAScenePrefID*)objectID {
	return (BAScenePrefID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic prefKey;






@dynamic prefValue;










@end
