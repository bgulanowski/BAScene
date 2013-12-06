//
//  BAResourceStorage.m
//  BAScene
//
//  Created by Brent Gulanowski on 10-12-31.
//  Copyright (c) 2010-2014 Bored Astronaut. All rights reserved.
//

#import <BAScene/BAResourceStorage.h>

#import <BAScene/BASceneResource.h>


BAResourceStorage *ResourceStorage = nil;


@implementation BAResourceStorage

@synthesize rootPath;

- (void)dealloc {
	self.rootPath = nil;
	[super dealloc];
}

- (id)init {

	NSString *appSupport = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) lastObject];
	NSString *processName = [[NSProcessInfo processInfo] processName];
	NSString *path = [NSString pathWithComponents:[NSArray arrayWithObjects:appSupport, processName, @"Resources", nil]];

	return [self initWitRoot:path];
}

- (id)initWitRoot:(NSString *)path {
	self = [super init];
	if(self) {

		NSError *error = nil;
		NSFileManager *fm = [NSFileManager defaultManager];
		
		if(![fm createDirectoryAtPath:[path stringByAppendingPathComponent:@"vertices"]
		  withIntermediateDirectories:YES
						   attributes:nil
								error:&error])
			NSLog(@"Error: %@", error);
		if(![fm createDirectoryAtPath:[path stringByAppendingPathComponent:@"indices"]
		  withIntermediateDirectories:YES
						   attributes:nil
								error:&error])
			NSLog(@"Error: %@", error);
		self.rootPath = path;
	}
	return self;
}

+ (NSString *)nameForType:(int)type {
	static NSArray *names = nil;
	if(!names)
		names = [[NSArray arrayWithObjects:@"vertices", @"indices", nil] retain];
	return [names objectAtIndex:type];
}

- (NSString *)nameForType:(int)type {
	return [[self class] nameForType:type];
}

#define GENERIC_ERROR_LOG NSLog(@"Error %@", NSStringFromSelector(_cmd))
- (void)storeData:(NSData *)data type:(int)type uniqueID:(NSString *)uuid {
	NSAssert(self.rootPath, @"No root path set");
	if(![data writeToFile:[NSString pathWithComponents:[NSArray arrayWithObjects:rootPath, [self nameForType:type], uuid, nil]] atomically:NO])
		GENERIC_ERROR_LOG;
	else
		NSLog(@"Stored %lu bytes of %@ data for %@", (unsigned long)[data length], [self nameForType:type], uuid);
}

- (void)storeDataForResource:(BASceneResource *)aResource {
	[self storeData:aResource.data type:aResource.typeValue uniqueID:aResource.uniqueID];
}

- (NSData *)retrieveDataWithType:(int)type uniqueID:(NSString *)uuid {
	NSAssert(self.rootPath, @"No root path set");
	NSData *data = [NSData dataWithContentsOfFile:[NSString pathWithComponents:[NSArray arrayWithObjects:rootPath, [self nameForType:type], uuid, nil]]];
	if(!data)
		GENERIC_ERROR_LOG;
	else
		NSLog(@"Loaded %lu bytes of %@ data for %@", (unsigned long)[data length], [self nameForType:type], uuid);
	return data;
}

@end
