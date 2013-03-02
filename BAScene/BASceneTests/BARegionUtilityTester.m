//
//  BARegionUtilityTester.m
//  BAScene
//
//  Created by Brent Gulanowski on 11-12-16.
//  Copyright (c) 2011 Bored Astronaut. All rights reserved.
//

#import "BARegionUtilityTester.h"
#import "BASceneUtilities.h"


@implementation BARegionUtilityTester

// All code under test must be linked into the Unit Test bundle
- (void)testLineSolutionX {
    
    BALine l;
    BAPoint4f p;
    
    l.p = BAMakePoint4f(0, 0, 0, 1); // origin
    l.v = BAMakePointf(1, 0, 0); // y axis
    
    p = BALineSolutionX(l, 0);
    STAssertTrue(p.y == 0 && p.z == 0, @"fail: %@", BAStringFromPoint4f(p));
    
    p = BALineSolutionX(l, 1);
}

@end
