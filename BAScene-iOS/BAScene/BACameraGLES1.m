//
//  BACameraGLES1.m
//  BAScene-iOS
//
//  Created by Brent Gulanowski on 12/2/2013.
//  Copyright (c) 2013 Marketcircle Inc. All rights reserved.
//

#import "BACameraGLES1.h"

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@implementation BACameraGLES1

- (void)updateViewPortWithSize:(CGSize)size {
	glViewport(0, 0, size.width, size.height);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glFrustumf(-1.0f, 1.0f, -size.height/size.width, size.height/size.width, 5.0f, 50.0f);
}

- (void)submitMeshWithVertices:(GLfloat)vertices hasColors:(BOOL)hasColors hasNormals:(BOOL)hasNormals {
}

@end
