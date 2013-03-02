//
//  BAVectorTester.m
//  BAScene
//
//  Created by Brent Gulanowski on 11-03-17.
//  Copyright 2011 Bored Astronaut. All rights reserved.
//

#import "BAVectorTester.h"

#import <BAScene/BASceneUtilities.h>


@implementation BAVectorTester

- (void)testVectorInverse {
	
}

- (void)testTransformVector3 {

	BAMatrix3x3f m = BAIdentityMatrix3x3f;
	BAPointf v = BAMakePointf(2.0f, 3.0f, 7.0f);
	BAPointf r = BATransformPointf(v, m);
	
	STAssertTrue(BAEqualVectors3(v, r), @"Error: Vectors are not equal; expected: %@; actual: %@", BAStringFromPointf(v), BAStringFromPointf(r));
	
#if 1
	// Column-major
	m = BAMakeColMatrix3x3f(1.0f,   0,     0,  //  1  0  2     0     2   |               1  0  2
						       0, 1.0f,    0,  //  0  1  4  x  0  =  4   |   0  0  1  x  0  1  4  =  0  0  1
							2.0f, 4.0f, 1.0f); //  0  0  1     1     1   |               0  0  1
	v = BAMakePointf( 0, 0, 1.0f);
	r = BATransformPointf(v, m);
	
	BAPointf e = BAMakePointf(2.0f, 4.0f, 1.0f);

#else		
	m = BAMakeMatrix3x3f(1.0f,    0, 5.0f,  //  1  2  0     2     8   |               1  2  0
						 2.0f, 3.0f,    0,  //  0  3  4  x  3  = 13   |   2  3  1  x  0  3  4  =  7 13 18
						    0,    4, 6.0f); //  5  0  6     1    16   |               5  0  6
	v = BAMakePointf(2.0f, 3.0f, 1.0f);
	r = BATransformPointf(v, m);
	
	/*
	 ex = 2 + 0  + 5 = 7
	 ey = 4 + 9  + 0 = 13
	 ez = 0 + 12 + 6 = 18
	 */
	BAPointf e = BAMakePointf(7.0f, 13.0f, 18.0f);
#endif
	STAssertTrue(BAEqualVectors3(e, r), @"Error: Vectors3 are not equal; expected: %@; actual: %@", BAStringFromPointf(e), BAStringFromPointf(r));
}

- (void)testTransformVector4 {
	
	BAMatrix4x4f m = BAMakeRowMatrix4x4f(1.0f,    0,    0,    2,
									        0, 1.0f,    0, 1.0f,
									        0,    0, 1.0f, 3.0f,
									        0,    0,    3, 1.0f);
	
	BAPoint4f v = BAMakePoint4f(0, 0, 0, 1);
	BAPoint4f r = BATransformPoint4f(v, m);
	BAPoint4f e = BAMakePoint4f(2.0f, 1.0f, 3.0f, 1.0f);
		
	STAssertTrue(BAEqualPoints4f(e, r), @"Error: Points4f are not equal: expected: %@; actual: %@", BAStringFromPoint4f(e), BAStringFromPoint4f(r));
}

@end
