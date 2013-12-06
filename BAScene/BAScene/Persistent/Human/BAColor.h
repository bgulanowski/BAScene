//
//  BAColor.h
//  BAScene
//
//  Created by Brent Gulanowski on 16/10/08.
//  Copyright (c) 2008-2014 Bored Astronaut. All rights reserved.
//


#import <BAScene/_BAColor.h>
#import <BAScene/BASceneTypes.h>


@interface BAColor : _BAColor {
@public
	BAColorf values;
}
@end


@interface BAColor (BAColorDeprecated)

+ (BAColor *)colorWithRed:(GLfloat)red green:(GLfloat)green blue:(GLfloat)blue alpha:(GLfloat)alpha DEPRECATED_ATTRIBUTE;
+ (BAColor *)colorWithRed:(GLfloat)red green:(GLfloat)green blue:(GLfloat)blue DEPRECATED_ATTRIBUTE;
+ (BAColor *)colorWithColor:(BAColorf)color DEPRECATED_ATTRIBUTE;

+ (BAColor *)randomColor DEPRECATED_ATTRIBUTE;
+ (BAColor *)randomOpaqueColor DEPRECATED_ATTRIBUTE;
+ (BAColor *)randomWarmColor DEPRECATED_ATTRIBUTE; // also opaque

@end


@interface NSManagedObjectContext (BAColorCreating)

- (BAColor *)colorWithRed:(GLfloat)red green:(GLfloat)green blue:(GLfloat)blue alpha:(GLfloat)alpha;
- (BAColor *)colorWithRed:(GLfloat)red green:(GLfloat)green blue:(GLfloat)blue;
- (BAColor *)colorWithColor:(BAColorf)color;

- (BAColor *)randomColor;
- (BAColor *)randomOpaqueColor;
- (BAColor *)randomWarmColor; // also opaque

@end
