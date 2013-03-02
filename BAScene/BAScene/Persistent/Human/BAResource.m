//
//  BAResource.m
//  BAScene
//
//  Created by Brent Gulanowski on 31/12/10.
//  Copyright 2008-2011 Bored Astronaut. All rights reserved.
//

#import "BAResource.h"

#import "BAResourceStorage.h"


@implementation BAResource

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

+ (BAResource *)resourceWithType:(int)aType data:(NSData *)sourceData {
	
	BAResource *res = (BAResource *)[self insertObject];
	
	res.data = sourceData;
	res.typeValue = aType;
	
	[ResourceStorage storeDataForResource:res];
	
	return res;
}

+ (BAResource *)resourceWithType:(int)aType uniqueID:(NSData *)uuid {
	
	NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K=%d and %K=%@", @"type", aType, @"uniqueID", uuid];
	
	return [BAActiveContext objectForEntityNamed:[self entityName] matchingPredicate:pred];
}

@end
