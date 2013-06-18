//
//  BASceneResource.m
//  BAScene
//
//  Created by Brent Gulanowski on 31/12/10.
//  Copyright 2008-2011 Bored Astronaut. All rights reserved.
//

#import "BASceneResource.h"

#import "BAResourceStorage.h"


@implementation BASceneResource

@synthesize data;

- (void)dealloc {
	self.data = nil;
	[super dealloc];
}

- (void)awakeFromInsert {
	
	CFUUIDRef UUID = CFUUIDCreate(kCFAllocatorDefault);
	CFStringRef UUIDString = CFUUIDCreateString(kCFAllocatorDefault, UUID);
	
	self.uniqueID = (NSString *)UUIDString;
	
	CFRelease(UUID);
	CFRelease(UUIDString);
}

- (NSData *)data {
	if(!loadFailed && !data)
		self.data = [ResourceStorage retrieveDataWithType:self.typeValue uniqueID:self.uniqueID];
	return [[data retain] autorelease];
}

@end


@implementation NSManagedObjectContext (BAResourceCreating)

- (BASceneResource *)resourceWithType:(int)aType data:(NSData *)sourceData {
	
	BASceneResource *res = [self insertBASceneResource];
	
	res.data = sourceData;
	res.typeValue = aType;
	
	[ResourceStorage storeDataForResource:res];
	
	return res;
}

- (BASceneResource *)resourceWithType:(int)aType uniqueID:(NSData *)uuid {
	
	NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K=%d and %K=%@", @"type", aType, @"uniqueID", uuid];
	
	return [self objectForEntityNamed:[BASceneResource entityName] matchingPredicate:pred];
}

@end
