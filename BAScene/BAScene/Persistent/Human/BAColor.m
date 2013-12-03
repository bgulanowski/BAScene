//
//  BAColor.m
//  BAScene
//
//  Created by Brent Gulanowski on 16/10/08.
//  Copyright 2008 Bored Astronaut. All rights reserved.
//

#import <BAScene/BAColor.h>

#import <BAScene/BASceneUtilities.h>

#import "BASceneOpenGL.h"

#if TARGET_OS_IPHONE
#define NSColor UIColor

@interface UIColor (BASceneAdditions)
+ (UIColor *)colorWithDeviceHue:(GLfloat)hue saturation:(GLfloat)saturation brightness:(GLfloat)brightness alpha:(GLfloat)alpha;
@end

@implementation UIColor (BASceneAdditions)
+ (UIColor *)colorWithDeviceHue:(GLfloat)hue saturation:(GLfloat)saturation brightness:(GLfloat)brightness alpha:(GLfloat)alpha {
    return [self colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}
@end
#endif


@implementation BAColor
#pragma mark NSObject
- (NSString *)description {
	return [NSString stringWithFormat:@"r:%1.3f g:%1.3f b:%1.3f a:%1.3f", values.c.r, values.c.g, values.c.b, values.c.a];
}


#pragma mark NSManagedObject
- (void)awakeFromFetch {
	values.c.r = self.rValue;
	values.c.g = self.gValue;
	values.c.b = self.bValue;
	values.c.a = self.aValue;
}

+ (BAColor *)colorWithRed:(GLfloat)red green:(GLfloat)green blue:(GLfloat)blue alpha:(GLfloat)alpha {
    BAAssertActiveContext();
	return [BAActiveContext colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (BAColor *)colorWithRed:(GLfloat)red green:(GLfloat)green blue:(GLfloat)blue {
    BAAssertActiveContext();
    return [BAActiveContext colorWithRed:red green:green blue:blue];
}

+ (BAColor *)colorWithColor:(BAColorf)color {
    BAAssertActiveContext();
    return [BAActiveContext colorWithColor:color];
}

+ (BAColor *)randomColor {
    BAAssertActiveContext();
    return [BAActiveContext randomColor];
}

+ (BAColor *)randomOpaqueColor {
    BAAssertActiveContext();
    return [BAActiveContext randomOpaqueColor];
}

+ (BAColor *)randomWarmColor {
    BAAssertActiveContext();
    return [BAActiveContext randomWarmColor];
}

#if 1
- (void)setRValue:(float)value_ {
	[super setRValue:value_];
	values.c.r = value_;
}

- (void)setGValue:(float)value_ {
	[super setGValue:value_];
	values.c.g = value_;
}

- (void)setBValue:(float)value_ {
	[super setBValue:value_];
	values.c.b = value_;
}

- (void)setAValue:(float)value_ {
	[super setAValue:value_];
	values.c.a = value_;
}

#else
// Why aren't these methods working properly?
- (void)setR:(NSNumber *)value {
	values.c.r = [value floatValue];
	[super setR:value];
}

- (void)setG:(NSNumber *)value {
	values.c.g = [value floatValue];
	[super setG:value];
}

- (void)setB:(NSNumber *)value {
	values.c.b = [value floatValue];
	[super setB:value];
}

- (void)setA:(NSNumber *)value {
	values.c.a = [value floatValue];
	[super setA:value];
}
#endif

@end


@implementation NSManagedObjectContext (BAColorCreating)

- (BAColor *)colorWithRed:(GLfloat)red green:(GLfloat)green blue:(GLfloat)blue alpha:(GLfloat)alpha {
    
    BAColor *color = [self insertBAColor];
    
	color.rValue = red;
	color.gValue = green;
	color.bValue = blue;
	color.aValue = alpha;

    return color;
}

- (BAColor *)colorWithRed:(GLfloat)red green:(GLfloat)green blue:(GLfloat)blue {
    return [self colorWithRed:red green:green blue:blue alpha:1.0f];
}

- (BAColor *)colorWithColor:(BAColorf)color {
    return [self colorWithRed:color.c.r green:color.c.g blue:color.c.b alpha:color.c.a];
}

- (BAColor *)randomColor {
    return [self colorWithColor:BARandomColorf()];
}

- (BAColor *)randomOpaqueColor {
    return [self colorWithColor:BARandomOpaqueColorf()];
}

- (BAColor *)randomWarmColor {
    
    NSColor *base = [NSColor colorWithDeviceHue:BARandomFloat()*0.25f
                                     saturation:BARandomFloat()*0.75f + 0.25f
                                     brightness:BARandomFloat()*0.5f + 0.5f
                                          alpha:1.0f];
    CGFloat r, g, b;
    
    [base getRed:&r green:&g blue:&b alpha:NULL];
    
    return [self colorWithRed:r green:g blue:b];
}

@end
