//
//  BAVoxelArray.m
//  BAScene
//
//  Created by Brent Gulanowski on 11-04-01.
//  Copyright 2011 Bored Astronaut. All rights reserved.
//

#import "BAVoxelArray.h"
#import <BAFoundation/BANoise.h>

@implementation BAVoxelArray

#pragma mark NSCopying
- (id)copyWithZone:(NSZone *)zone {
	
	BAVoxelArray *copy = [super copyWithZone:zone];
	
	copy->width = width;
	copy->depth = depth;
	copy->height = height;
	
	return copy;
}

/*
 i*area + j*width + k = (h-1)*w*d + (d-1)*w + (w-1) = w*((h-1)d + d-1 + 1) - 1 = w*(d*(h-1) + d) - 1 = w*d*(h-1+1) = w*d*h - 1
 */

- (BOOL)hiddenBit:(NSUInteger)index {
	
	BOOL l=[self bit:index - 1],               r=[self bit:index + 1];
	BOOL f=[self bit:index - width],           b=[self bit:index + width];
	BOOL u=[self bit:index - (width * depth)], d=[self bit:index + (width * depth)];
	
	return (l && r && f && b && u && d );
}

- (BAVoxelArray *)voxelArrayByRemovingHiddenBits {
	
	BAVoxelArray *new = [[self copy] autorelease];
	NSUInteger area = width * depth;
	NSUInteger removed = 0;
	
	for(NSUInteger i=0; i<height; ++i) {
		for(NSUInteger j=0; j<depth; ++j) {
			for(NSUInteger k=0; k<width; ++k) {
				
				NSUInteger index = i*area + j*width + k;
                
                BOOL edge = i==0 || j==0 || k==0 || i==height-1 || j==depth-1 || k==width-1;
				
				if([self bit:index] && !edge && [self hiddenBit:index]) {
					NSAssert([new bit:index], @"DEATH");
					[new clearBit:index];
					removed++;
				}
			}
		}
	}
	
	return new;
}

+ (BAVoxelArray *)voxelArrayWithWidth:(NSUInteger)w height:(NSUInteger)h depth:(NSUInteger)d {

	BAVoxelArray *va = [[[self alloc] initWithLength:w*h*d] autorelease];
	
	va->width = w;
	va->height = h;
	va->depth = d;
	
	return va;
}

+ (BAVoxelArray *)voxelCubeWithDimension:(NSUInteger)d {
	return [self voxelArrayWithWidth:d height:d depth:d];
}

+ (BAVoxelArray *)voxelArrayInRegion:(BARegionf)region scale:(BAScalef)scale precision:(NSUInteger)bits noise:(id<BANoise>)nm {
    
    NSUInteger i = 0;
    GLfloat minX = BAMinXf(region), maxX = BAMaxXf(region);
    GLfloat minY = BAMinYf(region), maxY = BAMaxYf(region);
    GLfloat minZ = BAMinZf(region), maxZ = BAMaxZf(region);

    BAVoxelArray *va = [BAVoxelArray voxelCubeWithDimension:maxX-minX];

	for(double z = minZ; z<maxZ; ++z) {
		for(double y = minY; y<maxY; ++y) {
			for(double x = minX; x<maxX; ++x) {
				if ([nm evaluateX:x*scale.s.w Y:y*scale.s.h Z:z*scale.s.d]) {
					[va setBit:i];
				}
				i++;
			}
		}
	}
    
    return va;
}

@end
