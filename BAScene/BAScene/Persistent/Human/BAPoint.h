//
//  BAPoint.h
//  BAScene
//
//  Created by Brent Gulanowski on 30/05/09.
//  Copyright 2009 Bored Astronaut. All rights reserved.
//

#import <BAScene/_BAPoint.h>

#import <BAScene/BACamera.h>


@class BATuple;

@interface BAPoint : _BAPoint<BAVisible, NSMutableCopying> {}

+ (BAPoint *)pointWithVertex:(BATuple *)vert texCoord:(BATuple *)texC index:(UInt16)newIndex;
+ (BAPoint *)pointWithVertex:(BATuple *)vert index:(UInt16)newIndex;
+ (NSSet *)pointsWithWithVertices:(NSArray *)verts texCoords:(NSArray *)texCoords count:(NSUInteger)count;
+ (NSSet *)pointsWithWithVertices:(NSArray *)verts count:(NSUInteger)count;

@end
