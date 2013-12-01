//
//  BATransform.m
//  BAScene
//
//  Created by Brent Gulanowski on 25/06/08.
//  Copyright 2008 Bored Astronaut. All rights reserved.
//

#import <BAScene/BATransform.h>

#import <BAScene/BASceneUtilities.h>

@interface BATransform ()
@property (nonatomic, readwrite) BAMatrix4x4f transform;
@property (nonatomic, readwrite) BOOL dirty;
@end


@implementation BATransform

@dynamic transform;
@synthesize dirty;

static GLfloat BA_IDENTITY_MATRIX[16] = {
	1,0,0,0,
	0,1,0,0,
	0,0,1,0,
	0,0,0,1
};


#pragma mark NSManagedObject
- (void)awakeFromInsert {
	memcpy(transform.i, BA_IDENTITY_MATRIX, sizeof(GLfloat)*16);
}

- (void)awakeFromFetch {
	memcpy(transform.i, BA_IDENTITY_MATRIX, sizeof(GLfloat)*16);
	dirty = YES;
}


#pragma mark Core Data Scalar Accessors

#pragma mark Accessors
- (BAMatrix4x4f)transform {
	if(dirty)
		[self rebuild];
//	return BATransposeMatrix4x4f(transform);
	return transform;
}

- (void)setTransform:(BAMatrix4x4f)newTransform {
    transform = newTransform;
}

- (NSData *)transformData {
	return BAMatrix4x4Dataf(transform);
}


#pragma mark Factories
+ (BATransform *)transform {
    BAAssertActiveContext();
	return [BAActiveContext insertBATransform];
}

+ (BATransform *)transformWithMatrix4x4f:(BAMatrix4x4f)matrix {
    BAAssertActiveContext();
    return [BAActiveContext transformWithMatrix4x4f:matrix];
}

+ (BATransform *)transformWithMatrixData:(NSData *)matrixData {
    BAAssertActiveContext();
	return [BAActiveContext transformWithMatrixData:matrixData];
}

+ (BATransform *)translationWithX:(double)x y:(double)y z:(double)z {
    BAAssertActiveContext();
	return [BAActiveContext translationWithX:x y:y z:z];
}

+ (BATransform *)translationWithLocation:(BALocationf)location {
    BAAssertActiveContext();
    return [BAActiveContext translationWithLocation:location];
}

+ (BATransform *)rotationWithX:(double)x y:(double)y z:(double)z {
    BAAssertActiveContext();
    return [BAActiveContext rotationWithX:x y:y z:z];
}

+ (BATransform *)scaleWithX:(double)x y:(double)y z:(double)z {
    BAAssertActiveContext();
    return [BAActiveContext scaleWithX:x y:y z:z];
}


#pragma mark Operations
- (void)scaleX:(double)x y:(double)y z:(double)z {
	
    BAMatrix4x4f scale = BAMakeColMatrix4x4f(x, 0, 0, 0,  0, y, 0, 0,  0, 0, z, 0,  0, 0, 0, 1);
    
    transform = BAMultiplyMatrix4x4f(transform, scale);
	
	self.sxValue *= x;
	self.syValue *= y;
	self.szValue *= z;
}

-(void)rotateX:(double)x y:(double)y z:(double)z {
	
	double xRotation = self.rxValue;
	double yRotation = self.ryValue;
	double zRotation = self.rzValue;
	
	// Normalize
    if( (xRotation + x) > 180.0f ) {
        x -= 360.0f;
    }
    else if( (xRotation + x) < -180.0f ) {
        x += 360.0f;
    }
	
    if( (yRotation + y) > 180.0f ) {
        y -= 360.0f;
    }
    else if( (yRotation + y) < -180.0f ) {
        y += 360.0f;
    }
	
	if( (zRotation + z) > 180.0f ) {
        z -= 360.0f;
    }
    else if( (zRotation + z) < -180.0f ) {
        z += 360.0f;
    }
	
    transform = BAMultiplyMatrix4x4f(transform, BAXAxisRotationMatrix4x4f(-xRotation));
    transform = BAMultiplyMatrix4x4f(transform, BAYAxisRotationMatrix4x4f(-yRotation));
    transform = BAMultiplyMatrix4x4f(transform, BAZAxisRotationMatrix4x4f(z));
    transform = BAMultiplyMatrix4x4f(transform, BAYAxisRotationMatrix4x4f(yRotation+y));
    transform = BAMultiplyMatrix4x4f(transform, BAXAxisRotationMatrix4x4f(xRotation+x));
	
	self.rxValue = xRotation + x;
	self.ryValue = yRotation + y;
    self.rzValue = zRotation + z;
}

-(void)translateX:(double)x y:(double)y z:(double)z {
	
    transform = BAMultiplyMatrix4x4f(BATranslationMatrix4x4f(BAMakePointf(x, y, z)), transform);
	
	self.lxValue += x;
	self.lyValue += y;
	self.lzValue += z;
}

- (void)resetValues {
}

- (void)rebuild {
	
	double x = self.lxValue, y = self.lyValue, z = self.lzValue;
	double r = self.rxValue, s = self.ryValue, t = self.rzValue;
	double a = self.sxValue, b = self.syValue, c = self.szValue;
    
	[self reset];
		
	[self translateX:x y:y z:z];
	[self rotateX:r y:s z:t];
	[self scaleX:a y:b z:c];

	dirty = NO;
}

- (void)reset {
	transform = BAMakeIdentityMatrix4x4f();
	self.lxValue = 0;
	self.lyValue = 0;
	self.lzValue = 0;
	self.rxValue = 0;
	self.ryValue = 0;
	self.rzValue = 0;
	self.sxValue = 1;
	self.syValue = 1;
	self.szValue = 1;
	dirty = NO;
}

- (void)apply {
	if(dirty)
		[self rebuild];
#if ! TARGET_OS_IPHONE
	glMultMatrixf( transform.i );
#endif
}

- (BALocationf)location {
	return BAMakeLocationf(self.lxValue, self.lyValue, self.lzValue, 1.0f);
}

@end


@implementation NSManagedObjectContext (BATransformCreating)

- (BATransform *)transformWithMatrix4x4f:(BAMatrix4x4f)matrix {
	BATransform *xform = [self insertBATransform];
	xform.transform = matrix;
	return xform;
}

- (BATransform *)transformWithMatrixData:(NSData *)matrixData {
	return [self transformWithMatrix4x4f:BAMatrix4x4WithDataf(matrixData)];
}

- (BATransform *)translationWithX:(double)x y:(double)y z:(double)z {
	
	BATransform *xform = [self insertBATransform];
	
	xform.lxValue = x, xform.lyValue = y, xform.lzValue = z;
	xform.dirty = YES;
	
	return xform;
}

- (BATransform *)translationWithLocation:(BALocationf)location {
	return [self translationWithX:location.p.x y:location.p.y z:location.p.z];
}

- (BATransform *)rotationWithX:(double)x y:(double)y z:(double)z {
	
	BATransform *xform = [self insertBATransform];
	
	xform.rxValue = x, xform.ryValue = y, xform.rzValue = z;
	xform.dirty = YES;
	
	return xform;
}

- (BATransform *)scaleWithX:(double)x y:(double)y z:(double)z {
	
	BATransform *xform = [self insertBATransform];
	
	xform.sxValue = x, xform.syValue = y, xform.szValue = z;
	xform.dirty = YES;
	
	return xform;
}

@end
