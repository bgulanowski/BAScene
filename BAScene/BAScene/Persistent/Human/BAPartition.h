//
//  BAPartition.h
//  BAScene
//
//  Created by Brent Gulanowski on 01/06/09.
//  Copyright 2009 Bored Astronaut. All rights reserved.
//

#import <BAScene/_BAPartition.h>


@class BAMesh, BACamera;

@interface BAPartition : _BAPartition {
	BARegionf region;
    NSMutableDictionary *userData;
}

@property (readonly) BARegionf region;
@property (retain) NSMutableDictionary *userData;

+ (BAPartition *)rootPartitionWithDimension:(GLfloat)dim;
+ (BAPartition *)rootPartition;

- (void)subdivide;

- (void)addProp:(BAProp *)aProp;
- (void)removeProp:(BAProp *)aProp;

- (BOOL)containsPointX:(double)x y:(double)y z:(double)z;
- (BAPartition *)partitionForPointX:(double)x y:(double)y z:(double)z;

- (BOOL)intersectsLine:(BALine)line;

- (BOOL)containsCamera:(BACamera *)camera;
- (BAPartition *)partitionForCamera:(BACamera *)camera;

@end
