// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BAStage.m instead.

#import "_BAStage.h"

@implementation BAStageID
@end

@implementation _BAStage

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Stage" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Stage";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Stage" inManagedObjectContext:moc_];
}

- (BAStageID*)objectID {
	return (BAStageID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic partitionRoot;

	





@end
