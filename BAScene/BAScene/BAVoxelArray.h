//
//  BAVoxelArray.h
//  BAScene
//
//  Created by Brent Gulanowski on 11-04-01.
//  Copyright 2011 Bored Astronaut. All rights reserved.
//

#import <BAFoundation/BABitArray.h>

#import <BAScene/BASceneTypes.h>

@protocol BANoise;

@interface BAVoxelArray : BABitArray<NSCopying> {

	NSUInteger width;
	NSUInteger depth;
	NSUInteger height;
}

- (BOOL)hiddenBit:(NSUInteger)index;
- (BAVoxelArray *)voxelArrayByRemovingHiddenBits;

+ (BAVoxelArray *)voxelArrayWithWidth:(NSUInteger)w height:(NSUInteger)h depth:(NSUInteger)d;
+ (BAVoxelArray *)voxelCubeWithDimension:(NSUInteger)d;
// The provided region must have uniform dimensions (ie be a cube)
+ (BAVoxelArray *)voxelArrayInRegion:(BARegionf)region scale:(BAScalef)scale precision:(NSUInteger)bits noise:(id<BANoise>)nm;

@end
