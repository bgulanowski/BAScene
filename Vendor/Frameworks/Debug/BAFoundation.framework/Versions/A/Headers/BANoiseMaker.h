//
//  BANoiseMaker.h
//  BANoiseMaker
//
//  Created by Brent Gulanowski on 11-01-20.
//  Copyright 2011 Bored Astronaut. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol BANoise <NSObject>

- (double)evaluateX:(double)x Y:(double)y Z:(double)z;
- (double)blendX:(double)x Y:(double)y Z:(double)z octaves:(unsigned)octave_count persistence:(double)persistence function:(int)func;

@end

#define BA_NOISE_RANDOM_STATE_SIZE 32

/*
 * By necessity, this class invokes srandom(), but random()
 * values are only used at initialization time. If you use
 * random() in other parts of your program, be sure to use
 * the initstate() and setstate() functions to preserve
 * your state, if necessary.
 */
@interface BANoiseMaker : NSObject<BANoise> {

	int p[512];
//    char randomState[BA_NOISE_RANDOM_STATE_SIZE]; // we'll need this if we adopt NSCoding
    unsigned seed;
}

//@property (nonatomic) unsigned dimensions;

- (id)init; // uses Perlin's permute
- (id)initWithSeed:(unsigned)seed; // designated initializer; use 0 for Perlin's permute

// generates a new random seed by first seeding with the current time
+ (BANoiseMaker *)randomNoise;

@end
