//
//  BAVoxelArrayTester.m
//  BAScene
//
//  Created by Brent Gulanowski on 11-04-01.
//  Copyright (c) 2011-2014 Bored Astronaut. All rights reserved.
//

#import "BAVoxelArrayTester.h"

#import <BAScene/BAVoxelArray.h>


@implementation BAVoxelArrayTester

- (void)testHiddenBitRemoval {
	
	BAVoxelArray *ba = [BAVoxelArray voxelCubeWithDimension:3];
	
	[ba setAll];
	
	ba = [ba voxelArrayByRemovingHiddenBits];
	
	STAssertTrue([ba count] == 26, @"Too many set bits; expected: 26; actual; %d", [ba count]);
}

@end
