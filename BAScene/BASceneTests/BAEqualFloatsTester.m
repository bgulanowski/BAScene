//
//  BAEqualFloatsTester.m
//  BAScene
//
//  Created by Brent Gulanowski on 11-04-15.
//  Copyright 2011 Bored Astronaut. All rights reserved.
//

#import "BAEqualFloatsTester.h"

#import <BAScene/BASceneUtilities.h>


@implementation BAEqualFloatsTester

- (void)testEqualZero {
	STAssertTrue(BAEqualFloats(0, 0), @"Zero not equal to itself");
	GLfloat cos2p = cosine(M_PI_2);
	STAssertTrue(BAEqualFloats(cos2p, 0), @"cos π/2 not equal to 0; diff: %u", BAULPDiffFloats(cos2p, 0));
}
/*
- (void)testEqualOne {
	
}

- (void)testEqualNegative {
	
}

- (void)testEqualPositive {
	
}

- (void)testEqualHugelyNegative {
	
}

- (void)testEqualHugelyPositive {
	
}

- (void)testEqualInfinity {
	
}

- (void)testEqualNAN {
	
}
*/
@end
