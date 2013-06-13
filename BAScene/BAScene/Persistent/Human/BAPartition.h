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

- (void)subdivide;

- (void)addProp:(BAProp *)aProp;
- (void)removeProp:(BAProp *)aProp;

- (BOOL)containsPointX:(double)x y:(double)y z:(double)z;
- (BAPartition *)partitionForPointX:(double)x y:(double)y z:(double)z;

- (BOOL)intersectsLine:(BALine)line;

- (BOOL)containsCamera:(BACamera *)camera;
- (BAPartition *)partitionForCamera:(BACamera *)camera;

@end


@interface BAPartition (BAPartitionDeprecated)

+ (BAPartition *)rootPartitionWithDimension:(GLfloat)dim DEPRECATED_ATTRIBUTE;
+ (BAPartition *)rootPartition DEPRECATED_ATTRIBUTE;

@end


@interface NSManagedObjectContext (BAPartitionCreating)

- (BAPartition *)partitionWithDimension:(GLfloat)dim location:(BALocationf)loc parent:(BAPartition *)parent;
- (BAPartition *)rootPartitionWithDimension:(GLfloat)dim;
- (BAPartition *)rootPartition;

@end
