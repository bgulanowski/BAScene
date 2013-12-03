//
//  NSOpenGLContext+BAScene.m
//  BAScene
//
//  Created by Brent Gulanowski on 12/2/2013.
//  Copyright (c) 2013 Bored Astronaut. All rights reserved.
//

#import "NSOpenGLContext+BAScene.h"

@implementation NSOpenGLContext (BAScene)

- (CGLOpenGLProfile)ba_profile {
	
	CGLContextObj cglContext = [self CGLContextObj];
	CGLPixelFormatObj cglPixelFormat = CGLGetPixelFormat(cglContext);
	GLint format = 0;
	CGLError cglError = CGLDescribePixelFormat(cglPixelFormat, 0, kCGLPFAOpenGLProfile, &format);
	
	if (cglError != 0) {
		NSLog(@"Error reading pixel format for NSOpenGLContext");
	}
	
	return (CGLOpenGLProfile)format;
}

@end
