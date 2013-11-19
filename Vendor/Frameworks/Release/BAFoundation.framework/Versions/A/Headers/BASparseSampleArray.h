//
//  BASparseSampleArray.h
//  BAFoundation
//
//  Created by Brent Gulanowski on 13-03-07.
//  Copyright (c) 2013 Lichen Labs. All rights reserved.
//

#import <BAFoundation/BASparseArray.h>

#import <BAFoundation/BASampleArray.h>


typedef NSUInteger BAPageSample;
typedef NSUInteger BABlockSample;


@interface BASparseSampleArray : BASparseArray<BASampleArray> {
    BASampleArray *_samples;
    NSUInteger _sampleSize;  // bytes per sample, starting at 1; default is 1
}

@property (nonatomic, strong, readonly) BASampleArray *samples;
@property (nonatomic) NSUInteger sampleSize;

- (id)initWithBase:(NSUInteger)base power:(NSUInteger)power sampleSize:(NSUInteger)size;

- (BAPageSample)pageSampleAtX:(NSUInteger)x y:(NSUInteger)y;
- (void)setPageSample:(BAPageSample)sample atX:(NSUInteger)x y:(NSUInteger)y;

- (BABlockSample)blockSampleAtX:(NSUInteger)x y:(NSUInteger)y z:(NSUInteger)z;
- (void)setBlockSample:(BABlockSample)sample atX:(NSUInteger)x y:(NSUInteger)y z:(NSUInteger)z;

- (float)blockFloatAtX:(NSUInteger)x y:(NSUInteger)y z:(NSUInteger)z;
- (void)setBlockFloat:(float)sample  atX:(NSUInteger)x y:(NSUInteger)y z:(NSUInteger)z;

@end
