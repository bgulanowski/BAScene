//
//  BANoiseMaker.h
//  BANoiseMaker
//
//  Created by Brent Gulanowski on 11-01-20.
//  Copyright 2011 Bored Astronaut. All rights reserved.
//

#import <BAFoundation/BANoise.h>


// THIS CLASS IS OBSOLETE - use BANoise instead


/*
 * By necessity, this class invokes srandom(), but random()
 * values are only used at initialization time. If you use
 * random() in other parts of your program, be sure to use
 * the initstate() and setstate() functions to preserve
 * your state, if necessary.
 */
@interface BANoiseMaker : NSObject<BANoise> {
    NSData *data;
	int *p;
}



- (id)init; // uses Perlin's permute
- (id)initWithSeed:(unsigned)seed; // designated initializer; use 0 for Perlin's permute

- (double)blendX:(double)x Y:(double)y Z:(double)z octaves:(unsigned)octave_count persistence:(double)persistence;

- (double *)blendX:(double)x Y:(double)y Z:(double)z
             width:(unsigned)w height:(unsigned)h depth:(unsigned)d
         increment:(double)increment octaves:(unsigned)octave_count persistence:(double)persistence;

// generates a new random seed by first seeding with the current time
+ (BANoiseMaker *)randomNoise;

@end
