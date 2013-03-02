//
//  BAResource.h
//  BAScene
//
//  Created by Brent Gulanowski on 31/12/10.
//  Copyright 2008-2011 Bored Astronaut. All rights reserved.
//

#import "_BAResource.h"

@interface BAResource : _BAResource {
	NSData *data;
	BOOL loadFailed;
}

@property (nonatomic, retain) NSData *data;

+ (BAResource *)resourceWithType:(int)aType data:(NSData *)sourceData; // always creates a new resource
+ (BAResource *)resourceWithType:(int)aType uniqueID:(NSData *)uuid; // always searches for existing resource

@end
