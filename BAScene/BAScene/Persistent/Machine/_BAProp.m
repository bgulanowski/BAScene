// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BAProp.m instead.

#import "_BAProp.h"

@implementation BAPropID
@end

@implementation _BAProp

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Prop" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Prop";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Prop" inManagedObjectContext:moc_];
}

- (BAPropID*)objectID {
	return (BAPropID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic boundsData;






@dynamic name;






@dynamic color;

	

@dynamic group;

	

@dynamic prototype;

	

@dynamic transform;

	





@end
