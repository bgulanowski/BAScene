//
//  BAMatrixTester.m
//  BAScene
//
//  Created by Brent Gulanowski on 11-03-17.
//  Copyright 2011 Bored Astronaut. All rights reserved.
//

#import "BAMatrixTester.h"

#import <BAScene/BASceneUtilities.h>
#import <BAScene/BASceneConstants.h>
#import <math.h>
#import <float.h>

@implementation BAMatrixTester

- (void)testEqualMatrices3x3 {
	
	BAMatrix3x3f m = BAIdentityMatrix3x3f;
	
	STAssertTrue(BAEqualMatrices3x3f(m, m), @"Test Equal Matrices failed.");
}

- (void)testMakeMatrix3x3 {
	
	BAMatrix3x3f e = { {
        { 1, -2,  3},
        { 3,  1, -4},
		{-2,  5,  1}
	} };
	BAMatrix3x3f r = BAMakeColMatrix3x3f(1, -2, 3, 3, 1, -4, -2, 5, 1);
	
	STAssertTrue(BAEqualMatrices3x3f(e, r), @"Make Column Matrix failed; expected: %@, actual: %@",
				 BAStringFromMatrix3x3f(e), BAStringFromMatrix3x3f(r));

	r = BAMakeRowMatrix3x3f(1, 3, -2, -2, 1, 5, 3, -4, 1);

	STAssertTrue(BAEqualMatrices3x3f(e, r), @"Make Row Matrix failed; expected: %@, actual: %@",
				 BAStringFromMatrix3x3f(e), BAStringFromMatrix3x3f(r));
}

- (void)testMakeMatrix4x4 {
    
    BAMatrix4x4f e = { {
        { 2,  0, -1,  4},
        {-1, -2,  0,  1},
        { 0,  3,  1, -3},
        { 5, -4, -5,  0}
    } };
	BAMatrix4x4f r = BAMakeColMatrix4x4f(2, 0, -1, 4, -1, -2, 0, 1, 0, 3, 1, -3, 5, -4, -5, 0);
    
    STAssertTrue(BAEqualMatrices4x4f(e, r), @"Make 4x4 Column Matrix failed; expected: %@, actual: %@",
                 BAStringFromMatrix4x4f(e), BAStringFromMatrix4x4f(r));
    
    r = BAMakeRowMatrix4x4f(2, -1, 0, 5, 0, -2, 3, -4, -1, 0, 1, -5, 4, 1, -3, 0);
    
    STAssertTrue(BAEqualMatrices4x4f(e, r), @"Make 4x4 Row Matrix failed; expected: %@, actual: %@",
                 BAStringFromMatrix4x4f(e), BAStringFromMatrix4x4f(r));
}

- (void)testTransposeMatrix3x3 {
	
	BAMatrix3x3f m = BAMakeColMatrix3x3f(1.0f, 2.0f, 3.0f,
										 4.0f, 5.0f, 6.0f,
										 7.0f, 8.0f, 9.0f);
	BAMatrix3x3f e = BAMakeColMatrix3x3f(1.0f, 4.0f, 7.0f,
										 2.0f, 5.0f, 8.0f,
										 3.0f, 6.0f, 9.0f);
	BAMatrix3x3f r = BATransposeMatrix3x3f(m);
	
	STAssertTrue(BAEqualMatrices3x3f(e, r), @"Error; transpose failed. Expected: %@; actual: %@", e, r);
}

- (void)testIdentityMatrix3x3 {

	BAMatrix3x3f a = BAIdentityMatrix3x3f;
	BAMatrix3x3f b = BAIdentityMatrix3x3f;
	BAMatrix3x3f e = a;
	BAMatrix3x3f r = BAMultiplyMatrix3x3f(a, b);
	
	STAssertTrue(BAEqualMatrices3x3f(a, r), @"Error: matrix multiply failed: Expected: %@; actual: %@",
				 BAStringFromMatrix3x3f(e), BAStringFromMatrix3x3f(r));
}
	
- (void)testSmallMultiplyMatrix3x3 {
	
	BAMatrix3x3f a = BAMakeColMatrix3x3f(1.0f,    0,    0,    //  1  0  3     1  2  0     4  5  3
										    0, 1.0f,    0,    //  0  1  2  x  2  4  0  =  4  6  2
										 3.0f, 2.0f, 1.0f);   //  0  0  1     1  1  1     1  1  1
	BAMatrix3x3f b = BAMakeColMatrix3x3f(1.0f, 2.0f, 1.0f, 
										 2.0f, 4.0f, 1.0f, 
									        0,    0, 1.0f);
	BAMatrix3x3f e = BAMakeColMatrix3x3f(4.0f,  4.0f,  1.0f,
										 5.0f,  6.0f,  1.0f,
										 3.0f,  2.0f,  1.0f);
	
	BAMatrix3x3f r = BAMultiplyMatrix3x3f(a, b);

	STAssertTrue(BAEqualMatrices3x3f(e, r), @"Error: matrix multiply failed: Expected: %@; actual: %@",
				 BAStringFromMatrix3x3f(e), BAStringFromMatrix3x3f(r));
}

- (void)test2SmallMultiplyMatrix3x3 {	

	// Column-major -- don't be fooled by the textual layout: it appears transposed because we always write left-to-write
	BAMatrix3x3f a = BAMakeColMatrix3x3f(1.0f,    0,    0,  //   1  0  3     1  4  0      1 10  9
										    0, 5.0f,-2.0f,  //   0  5  0  x -3  0  1  = -15  0  5
										 3.0f,    0, 4.0f); //   0 -2  4     0  2  3      6  8 10
	BAMatrix3x3f b = BAMakeColMatrix3x3f(1.0f,-3.0f,    0,
										 4.0f,    0, 2.0f,
									        0, 1.0f, 3.0f);
	BAMatrix3x3f e = BAMakeColMatrix3x3f( 1.0f,-15.0f,  6.0f,
										 10.0f,     0,  8.0f,
										  9.0f,  5.0f, 10.0f);
	BAMatrix3x3f r = BAMultiplyMatrix3x3f(a, b);
	
	STAssertTrue(BAEqualMatrices3x3f(e, r), @"Error: matrix multiply failed. Expected: %@; actual: %@",
				 BAStringFromMatrix3x3f(e), BAStringFromMatrix3x3f(r));
}

- (void)testTranslationMatrix3x3 {
	
	BAMatrix3x3f a = BATranslationMatrix3x3f(BAMakeVector(5.0f, -10.0f));
	BAMatrix3x3f e = BAMakeColMatrix3x3f(1.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f, 5.0f, -10.0f, 1.0f);
	
	STAssertTrue(BAEqualMatrices3x3f(e, a), @"Error: translation matrix failed. Expected: %@; actual: %@",
				 BAStringFromMatrix3x3f(e), BAStringFromMatrix3x3f(a));
}

- (void)testRotationMatrix3x3 {
	
	BAPointf points[5] = {
		{ 0,  0, 1},
		{ 1,  1, 1},
		{-1,  1, 1},
		{-1, -1, 1},
		{ 1, -1, 1},
	};
	BAPointf ep[5] = {
		{ 0,  0, 1},
		{-1,  1, 1},
		{-1, -1, 1},
		{ 1, -1, 1},
		{ 1,  1, 1},
	};
	const double angle = M_PI_2;
	BAMatrix3x3f em = BAMakeRowMatrix3x3f(0, -1, 0, 1, 0, 0, 0, 0, 1);
	BAMatrix3x3f am = BARotationMatrix3x3f(angle);
	
	STAssertTrue(BAEqualMatrices3x3f(am, em), @"Rotation matrix creation failed; expected: %@, actual: %@",
				 BAStringFromMatrix3x3f(em), BAStringFromMatrix3x3f(am));
	
	for(NSUInteger i=0; i<5; ++i) {
		BAPointf r = BATransformPointf(points[i], am);
		STAssertTrue(BAEqualPointsf(ep[i], r), @"Point %d transformation failed; expected: %@, actual: %@",
					 i, BAStringFromPointf(ep[i]), BAStringFromPointf(r));
	}
}

- (void)testArbitraryRotationMatrix3x3 {
	
	BAPointf points[5] = {
		{ 0,  0, 1},
		{ 3,  4, 1},
		{-2,  1, 1},
		{-5, -3, 1},
		{ 7, -9, 1}
	};
	BAPointf ep[5] = {
		{ 4,  4, 1},
		{ 1,  0, 1},
		{ 6,  3, 1},
		{ 9,  7, 1},
		{-3, 13, 1},
	};
	BAPointh p = BAMakePointh(2, 2, 1), z = BAZeroPointh;
	BAVector v = BASubtractPointsh(p, z);
	BAMatrix3x3f m = BAArbitraryRotationMatrix3x3f(p, M_PI);
	BAMatrix3x3f em = BATranslationMatrix3x3f(BAInverseVector(v));
	BAMatrix3x3f vm = BAMakeRowMatrix3x3f(1, 0, -2, 0, 1, -2, 0, 0, 1);
	
	STAssertTrue(BAEqualMatrices3x3f(vm, em), @"Create translation matrix failed: expected: %@, actual: %@",
				 BAStringFromMatrix3x3f(vm), BAStringFromMatrix3x3f(em));
	
	em = BAMultiplyMatrix3x3f(BARotationMatrix3x3f(M_PI), em);
	em = BAMultiplyMatrix3x3f(BATranslationMatrix3x3f(v), em);
	
	NSMutableString *detail = [NSString stringWithFormat:@"sin(π): %.20f cos(π): %.20f", sine(M_PI), cosine(M_PI)];
							   
	STAssertTrue(BAEqualMatrices3x3f(m, em), @"Create arbitrary rotation matrix failed; expected: %@, actual: %@\n%@",
				 BAStringFromMatrix3x3f(em), BAStringFromMatrix3x3f(m), detail);
	
	for(NSUInteger i=0; i<5; ++i) {
		BAPointf r = BATransformPointf(points[i], m);
		STAssertTrue(BAEqualPointsf(r, ep[i]), @"Point %d transformation failed; expected: %@, actual: %@",
					 i, BAStringFromPointf(ep[i]), BAStringFromPointf(r));
	}
}

- (void)transformPoints:(BAPoint4f *)p matrix:(BAMatrix4x4f)m expected:(BAPoint4f *)e {
	for(NSUInteger i=0; i<6; ++i) {
		p[i] = BATransformPoint4f(p[i], m);
		STAssertTrue(BAEqualPoints4f(e[i], p[i]), @"Point trasnformation %d failed; exected:\n%@\nactual:\n%@",
					 i, BAStringFromPoint4f(e[i]), BAStringFromPoint4f(p[i]));
	}	
}

- (void)testMultiplyMatrix4x4 {
	
#define M_SQRT2_2 (M_SQRT2*0.5f)
	
	BAPoint4f p[6] = {
		{ 0, 0, 0, 1},
		{ 2, 0, 0, 1},
		{ 0, 1, 0, 1},
		{ 0, 0, 1, 1},
		{ 2, 0, 1, 1},
		{ 0, 1, 1, 1},
	};
	
	// rotate 180 in Y
	BAMatrix4x4f ry = BAYAxisRotationMatrix4x4f(M_PI);
	BAPoint4f e1[6] = { { 0, 0, 0, 1}, { -2, 0, 0, 1}, { 0, 1, 0, 1}, { 0, 0, -1, 1}, { -2, 0, -1, 1}, { 0, 1, -1, 1} };
	
	[self transformPoints:p matrix:ry expected:e1];
	
	// translate 1 in X
	BAMatrix4x4f tx = BATranslationMatrix4x4f(BAMakeVector3(1, 0, 0));
	BAPoint4f e2[6] = { { 1, 0, 0, 1}, { -1, 0, 0, 1}, { 1, 1, 0, 1}, { 1, 0, -1, 1}, { -1, 0, -1, 1}, { 1, 1, -1, 1} };
	
	[self transformPoints:p matrix:tx expected:e2];
	
	// rotate 45 in Z
	BAMatrix4x4f rx = BAZAxisRotationMatrix4x4f(M_PI_4);
	BAPoint4f e3[6] = {
		{ M_SQRT2_2, M_SQRT2_2, 0, 1},  { -M_SQRT2_2, -M_SQRT2_2, 0, 1},  { 0, M_SQRT2,  0, 1},
		{ M_SQRT2_2, M_SQRT2_2, -1, 1}, { -M_SQRT2_2, -M_SQRT2_2, -1, 1}, { 0, M_SQRT2, -1, 1} };
	
	[self transformPoints:p matrix:rx expected:e3];
	
	// translate -3 in Z
	BAMatrix4x4f tz = BATranslationMatrix4x4f(BAMakeVector3(0,0,-3.0f));
	BAPoint4f e4[6] = {
		{ M_SQRT2_2, M_SQRT2_2, -3, 1},  { -M_SQRT2_2, -M_SQRT2_2, -3, 1},  { 0, M_SQRT2,  -3, 1},
		{ M_SQRT2_2, M_SQRT2_2, -4, 1}, { -M_SQRT2_2, -M_SQRT2_2, -4, 1}, { 0, M_SQRT2, -4, 1} };
	
	[self transformPoints:p matrix:tz expected:e4];
}

- (void)testSmallestMatrixLine3 {
    
    BAMatrix3x3f m = BAMakeColMatrix3x3f(0, 0, 1, 1, 1, 1, 1, 1, 1);
    BOOL isRow = NO;
    NSUInteger rc = BAMatrixSmallestRowOrColumn(&isRow, m.i, 3);
    
    STAssertTrue(!isRow && 0==rc, @"BAMatrixSmallestRowOrColumn failed; expected: col 0; actual: %@ %u",
                 isRow ? @"row":@"col", rc);
    
    m = BAMakeRowMatrix3x3f(1, 1, 1, 1, 1, 1, 0, 0, 0);
    rc = BAMatrixSmallestRowOrColumn(&isRow, m.i, 3);
    
    STAssertTrue(isRow && 2==rc, @"BAMatrixSmallestRowOrColumn failed; expected: row 2; actual: %@ %u",
                 isRow ? @"row":@"col", rc);
}

// Matrix samples from http://people.richland.edu/james/lecture/m116/matrices/determinant.html
- (void)testDeterminantMatrix2x2 {
    
    GLfloat m[] = { 3, 5, 2, 2 };
    GLfloat det = BAMatrixDeterminant(m, 2);
    
    STAssertTrue(det == -4, @"Determinant for 2x2 failed; expected -4; actual: %f", det);
}

- (void)testMinorMatrix3x3f {
    
    BAMatrix3x3f m = BAMakeColMatrix3x3f(1, 4, 2, 3, 1, 5, 2, 3, 2);
    BAMatrix3x3f e = BAMakeColMatrix3x3f(-13, -4, 7, 2, -2, -5, 18, -1, -11);
    BAMatrix3x3f a;
    
    for(NSUInteger i=0; i<3; ++i)     // columns
        for(NSUInteger j=0; j<3; ++j) // rows
            a.i[j*3+i] = BAMatrixMinor(m.i, i, j, 3);

    STAssertTrue(BAEqualMatrices3x3f(e, a), @"Minor failed for matrix %@; expected: %@; actual: %@",
                 BAStringFromMatrix3x3f(m), BAStringFromMatrix3x3f(e), BAStringFromMatrix3x3f(a));
}

- (void)testDeterminantMatrix3x3f {
    
    BAMatrix3x3f m = BAMakeColMatrix3x3f(1, 4, 2, 3, 1, 5, 2, 3, 2);
    
    GLfloat e = 17, det = BAMatrixDeterminant3x3f(m);
    
    STAssertTrue(det == e, @"Determinant failed for matrix %@; expected: %f; actual: %f", BAStringFromMatrix3x3f(m), e, det);
    
    m = BAMakeColMatrix3x3f(4, 3, 9, 1, 2, 3, 2, 1, 1);
    e = -16;
    det = BAMatrixDeterminant3x3f(m);
    
    STAssertTrue(det == e, @"Determinant failed for matrix %@; expected: %f; actual: %f", BAStringFromMatrix3x3f(m), e, det);
    
    m = BAMakeColMatrix3x3f(3, 4, 3, 0, 1, 2, 1, 2, 1);
    e = -4;
    det = BAMatrixDeterminant3x3f(m);
    
    STAssertTrue(det == e, @"Determinant failed for matrix %@; expected: %f; actual: %f", BAStringFromMatrix3x3f(m), e, det);
}

- (void)testDeterminantMatrix4x4f {
    
    BAMatrix4x4f m = BAMakeColMatrix4x4f(3, 4, 3, 9, 2, 0, 0, 2, 0, 1, 2, 3, 1, 2, 1, 1);
    
    GLfloat e = 24;
    GLfloat det = BAMatrixDeterminant4x4f(m);
    
    STAssertTrue(det == e, @"Determinant failed for matrix %@; expected: %f; actual: %f", BAStringFromMatrix4x4f(m), e, det);
    
    // Additional sample from http://www.intmath.com/matrices-determinants/2-large-determinants.php
    m = BAMakeColMatrix4x4f(7, 6, 4, 8, 4, 3, 6, 2, 2, -1, 2, -7, 0, 2, 5, 1);
    e = -279;
    det = BAMatrixDeterminant4x4f(m);
    
    STAssertTrue(det == e, @"Determinant failed for matrix %@; expected: %f; actual: %f", BAStringFromMatrix4x4f(m), e, det);
}

- (void)testInverseMatrix3x3f {
    
    BAMatrix3x3f m = BAMakeColMatrix3x3f(1, 4, 2, 3, 1, 5, 2, 3, 2);
    BAMatrix3x3f e = BAMakeColMatrix3x3f(-13.0f/17.0f, -2.0f/17.0f, 18.0f/17.0f,
                                         4.0f/17.0f, -2.0f/17.0f, 1.0f/17.0f,
                                         7.0f/17.0f, 5.0f/17.0f, -11.0f/17.0f);
    BAMatrix3x3f a = BAMatrixInverse3x3f(m);
    
    STAssertTrue(BAEqualMatrices3x3f(e, a), @"Inverse failed for matrix %@; expected: %@; actual: %@",
                 BAStringFromMatrix3x3f(m), BAStringFromMatrix3x3f(e), BAStringFromMatrix3x3f(a));
    
    for(NSUInteger i=0;i<9;++i)
        m.i[i] = (GLfloat) BARandomIntegerInRange(0, 10) - 5;
    
    a = BAMatrixInverse3x3f(m);
    a = BAMultiplyMatrix3x3f(a, m);
    
    BAMatrix3x3f I = BAIdentityMatrix3x3f;

    STAssertTrue(BAEqualMatrices3x3f(I, a), @"Inverse failed for random 3x3 matrix %@", BAStringFromMatrix3x3f(m));
}

- (void)testInverseMatrix4x4f {
    
    BAMatrix4x4f I4 = BAIdentityMatrix4x4f;
    BAMatrix4x4f m;
    BAMatrix4x4f a;
    
    for(NSUInteger i=0;i<16;++i)
        m.i[i] = (GLfloat) BARandomIntegerInRange(0, 10) - 5;
    
    a = BAMatrixInverse4x4f(m);
    a = BAMultiplyMatrix4x4f(a, m);
    
    STAssertTrue(BAEqualMatrices4x4f(I4, a), @"Inverse failed for random 4x4 matrix %@; matrix should be identify: %@",
                 BAStringFromMatrix4x4f(m), BAStringFromMatrix4x4f(a));
}

@end
