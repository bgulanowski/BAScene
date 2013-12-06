/*
 *  scenetest_main.c
 *  BAScene
 *
 *  Created by Brent Gulanowski on 11-04-02.
 *  Copyright (c) 2011-2014 Bored Astronaut. All rights reserved.
 *
 */

#import <BAScene/BAVoxelArray.h>
#import <BAScene/BAMesh.h>
#import <BAScene/BAScene.h>
#import <math.h>



static BOOL equalMatrices(BAMatrix3x3f _a_, BAMatrix3x3f _b_, int _c_) {
	for(int _i_=0; _i_<_c_; ++_i_)
		for(int _j_=0; _j_<_c_; ++_j_)
			if(BAEqualFloats(_a_.i[_c_*_i_+_j_], _b_.i[_c_*_i_+_j_]))
				return NO;
	return YES;
}

static BAUInt ulpDiff(GLfloat f1, GLfloat f2) {
	
	BAInt a = *(BAInt*)&f1;
	BAInt b = *(BAInt*)&f2;
	
	if (a < 0) a = (BAInt)(NAN_OFFSET - (BAUInt)a);
	if (b < 0) b = (BAInt)(NAN_OFFSET - (BAUInt)b);
	
	BAUInt r = absolute(a - b);
	
	return r;
}

static void testVoxelArrayRemoveHidden( void ) {
	
	BAVoxelArray *va = [BAVoxelArray voxelCubeWithDimension:3];
	
	[va setAll];
	va = [va voxelArrayByRemovingHiddenBits];
}

static void testBoxVsCube( void ) {
	
	NSManagedObjectContext *oc = [BAScene configuredContext];
	BAMesh *cube = [BAMesh cube];
	BAMesh *box = [BAMesh boxWithWidth:10 depth:2 height:31.5];
	
	[oc save:nil];
	
	NSLog(@"Cube dimensions: %f, %f, %f", [cube width], [cube height], [cube depth]);
	NSLog(@"Box dimensions: %f, %f, %f", [box width], [box height], [box depth]);
}

static void testCosine( void ) {
	
	GLfloat cosp2 = cosine(M_PI_2);
	
	NSLog(@"PI: %.20f; PI/2: %.20f", M_PI, M_PI_2);
	NSLog(@"cos pi/2: %.110f; ULPs from zero: %llu; equal? %@; ULP_DELTA: %u",
		  cosp2, ulpDiff(cosp2, 0), BAEqualFloats(cosp2, 0)? @"YES":@"NO", ULPS_DELTA);
}

static void testMatrixMultiply( void ) {
	
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
	
	if(!BAEqualMatrices3x3f(e, r))
		NSLog(@"Why?");
}

static void testMatrixRotation( void ) {
	
	GLfloat angle = M_PI_2;
	BAPointh p = BAMakePointh(2, 2, 1), z = BAZeroPointh;
	BAVector v = BASubtractPointsh(p, z);
	BAMatrix3x3f m = BAArbitraryRotationMatrix3x3f(p, angle);
	BAMatrix3x3f r = BARotationMatrix3x3f(angle);
	BAMatrix3x3f em = BATranslationMatrix3x3f(BAInverseVector(v));
	BAMatrix3x3f vm = BAMakeRowMatrix3x3f(1, 0, -2, 0, 1, -2, 0, 0, 1);
	
	NSLog(@"Create translation matrix: expected:\n%@\nactual:\n%@", BAStringFromMatrix3x3f(vm), BAStringFromMatrix3x3f(em));
	NSLog(@"Rotation matrix:\n%@", BAStringFromMatrix3x3f(r));
	
	em = BAMultiplyMatrix3x3f(r, em);
	
	NSLog(@"Incomplete test matrix:\n%@", BAStringFromMatrix3x3f(em));
	
	em = BAMultiplyMatrix3x3f(BATranslationMatrix3x3f(v), em);
	
	NSLog(@"Create arbitrary rotation matrix; expected:\n%@\nactual:\n%@", BAStringFromMatrix3x3f(em), BAStringFromMatrix3x3f(m));
}


int main(int argc, char **argv) {
	
	NSAutoreleasePool *p = [NSAutoreleasePool new];
	
	testMatrixRotation();
	
	[p drain];
	
	return 0;
}
