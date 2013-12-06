//
//  BAPointTester.m
//  BAScene
//
//  Created by Brent Gulanowski on 5/4/09.
//  Copyright (c) 2009-2014 Bored Astronaut. All rights reserved.
//

#import "BATupleTester.h"

#import "BASceneTestSupport.h"

#import <BAScene/BATuple.h>
#import <BAScene/BASceneUtilities.h>


@implementation BATupleTester

@synthesize point;

- (void)setUp {
	self.point = [NSEntityDescription insertNewObjectForEntityForName:@"Tuple" inManagedObjectContext:[BASceneTestSupport testContext]];
}

- (void)testAttributes {
	NSLog(@"%@", self.point);
	NSLog(@"%f", [self.point xValue]);
	NSLog(@"%@", [self.point className]);
	[self.point takeValuesFromPoint:BAMakePointf(100.0f, 19.6f, -10.999f)];
	NSLog(@"%@", self.point);
}

- (void)tearDown {
	self.point = nil;
}
@end
