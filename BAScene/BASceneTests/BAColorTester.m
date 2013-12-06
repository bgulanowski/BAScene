//
//  BAColorTester.m
//  BAScene
//
//  Created by Brent Gulanowski on 11-03-17.
//  Copyright (c) 2011-2014 Bored Astronaut. All rights reserved.
//

#import "BAColorTester.h"

#import <BAScene/BASceneUtilities.h>


static NSString *testStringi = @"(1,20,100,255)";
static BAColori colori = {
	1, 20, 100, 255
};

static NSString *testStringf = @"(0.001,0.100,0.333,1.000)";
static BAColorf colorf = {
	0.001f, 0.1f, 0.333f, 1.0f
};


@implementation BAColorTester

//- (void)testColorEquali {
//	
//}

- (void)testToStringi {
	
	NSString *result = BAStringFromColori(colori);
	
	STAssertTrue([testStringi isEqualToString:result], @"string from colori failed: expected: %@; actual: %@", testStringi, result);
}

- (void)testFromStringi {
	
	BAColori result = BAColorFromStringi(testStringi);

	STAssertTrue(colori.c.r == result.c.r, @"color from string i failed; (R) expected %f; actual %f", colori.c.r, result.c.r);
	STAssertTrue(colori.c.g == result.c.g, @"color from string i failed; (G) expected %f; actual %f", colori.c.g, result.c.g);
	STAssertTrue(colori.c.b == result.c.b, @"color from string i failed; (B) expected %f; actual %f", colori.c.b, result.c.b);
	STAssertTrue(colori.c.a == result.c.a, @"color from string i failed; (A) expected %f; actual %f", colori.c.a, result.c.a);
}

- (void)testToStringf {
	
	NSString *result = BAStringFromColorf(colorf);
	
	STAssertTrue([testStringf isEqualToString:result], @"string from colori failed; expected: %@; actual: %@", testStringf, result);
}

- (void)testFromStringf {
	
	BAColorf result = BAColorFromStringf(testStringf);
	
	STAssertTrue(colorf.c.r == result.c.r, @"color from string i failed; (R) expected %f; actual %f", colorf.c.r, result.c.r);
	STAssertTrue(colorf.c.g == result.c.g, @"color from string i failed; (G) expected %f; actual %f", colorf.c.g, result.c.g);
	STAssertTrue(colorf.c.b == result.c.b, @"color from string i failed; (B) expected %f; actual %f", colorf.c.b, result.c.b);
	STAssertTrue(colorf.c.a == result.c.a, @"color from string i failed; (A) expected %f; actual %f", colorf.c.a, result.c.a);
}

@end
