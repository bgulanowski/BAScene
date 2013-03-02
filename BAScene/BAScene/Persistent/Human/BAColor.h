//
//  BAColor.h
//  BAScene
//
//  Created by Brent Gulanowski on 16/10/08.
//  Copyright 2008 Bored Astronaut. All rights reserved.
//


#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
#import <OpenGLES/ES1/gl.h>
#else
#import <OpenGL/gl.h>
#endif

#import <BAScene/_BAColor.h>
#import <BAScene/BASceneTypes.h>


@interface BAColor : _BAColor {
@public
	BAColorf values;
}

+ (BAColor *)colorWithRed:(GLfloat)red green:(GLfloat)green blue:(GLfloat)blue alpha:(GLfloat)alpha;
+ (BAColor *)colorWithRed:(GLfloat)red green:(GLfloat)green blue:(GLfloat)blue;
+ (BAColor *)colorWithColor:(BAColorf)color;

+ (BAColor *)randomColor;
+ (BAColor *)randomOpaqueColor;
+ (BAColor *)randomWarmColor; // also opaque

@end
