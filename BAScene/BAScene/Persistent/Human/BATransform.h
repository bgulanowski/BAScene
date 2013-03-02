//
//  BATransform.h
//  BAScene
//
//  Created by Brent Gulanowski on 25/06/08.
//  Copyright 2008 Bored Astronaut. All rights reserved.
//


#import <BAScene/_BATransform.h>

#import "BASceneTypes.h"

@interface BATransform : _BATransform {
	BOOL dirty;
	BAMatrix4x4f transform;
}

@property (nonatomic, readonly) BAMatrix4x4f transform;
@property (nonatomic, readonly) NSData *transformData;

+ (BATransform *)transform;
// The following 2 methods do not work as desired -- requires decomposing the matrix into separate translation, rotation and scale elements
+ (BATransform *)transformWithMatrix4x4f:(BAMatrix4x4f)matrix;
+ (BATransform *)transformWithMatrixData:(NSData *)matrixData;
+ (BATransform *)translationWithX:(double)x y:(double)y z:(double)z;
+ (BATransform *)translationWithLocation:(BALocationf)location;
+ (BATransform *)rotationWithX:(double)x y:(double)y z:(double)z;
+ (BATransform *)scaleWithX:(double)x y:(double)y z:(double)z;

- (void)scaleX:(double)x y:(double)y z:(double)z;
- (void)rotateX:(double)x y:(double)y z:(double)z;
- (void)translateX:(double)x y:(double)y z:(double)z;

- (BALocationf)location;

- (void)rebuild;
- (void)reset;

- (void)apply;

@end
