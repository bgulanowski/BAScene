//
//  BACamera+NSColor.m
//  BAScene
//
//  Created by Brent Gulanowski on 12/6/2013.
//  Copyright (c) 2013 Bored Astronaut. All rights reserved.
//

#import "BACamera+NSColor.h"

@implementation BACamera (NSColor)

- (NSColor *)nsbgColor {
	return [NSColor colorWithCalibratedRed:bgColor.c.r green:bgColor.c.g blue:bgColor.c.b alpha:bgColor.c.a];
}

- (void)setNsbgColor:(NSColor *)aColor {
	[self setBgColor:[aColor BAColorf]];
}

- (NSColor *)nslColor {
    return [NSColor colorWithCalibratedRed:lightColor.c.r green:lightColor.c.g blue:lightColor.c.b alpha:1];
}

- (void)setNslColor:(NSColor *)aColor {
    [self setLightColor:[aColor BAColorf]];
}

- (NSColor *)nslShine {
    return [NSColor colorWithCalibratedRed:lightShine.c.r green:lightShine.c.g blue:lightShine.c.b alpha:1];
}
- (void)setNslShine:(NSColor *)aColor {
    [self setLightShine:[aColor BAColorf]];
}

@end
