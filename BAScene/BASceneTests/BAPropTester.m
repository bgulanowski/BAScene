//
//  BAPropTester.m
//  BAScene
//
//  Created by Brent Gulanowski on 5/4/09.
//  Copyright (c) 2009-2014 Bored Astronaut. All rights reserved.
//

#import "BAPropTester.h"

#import "BASceneTestSupport.h"

#import <BAScene/BASceneUtilities.h>


@implementation BAPropTester

@synthesize prop;

- (void)setUp {
	self.prop = [NSEntityDescription insertNewObjectForEntityForName:@"Prop" inManagedObjectContext:[BASceneTestSupport testContext]];
	STAssertNotNil(self.prop, @"Failed to create prop.");
}

- (void)testModify {
	[self.prop setValue:@"blah" forKey:@"name"];
}

- (void)tearDown {
	self.prop = nil;
}

@end
