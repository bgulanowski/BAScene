//
//  BASampleArray.h
//  BAFoundation
//
//  Created by Brent Gulanowski on 12-04-22.
//  Copyright (c) 2012 Lichen Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BASampleArray <NSObject>

- (id)initWithPower:(NSUInteger)power order:(NSUInteger)order size:(NSUInteger)size;

- (void)sample:(UInt8 *)sample atIndex:(NSUInteger)index;
- (void)setSample:(UInt8 *)sample atIndex:(NSUInteger)index;
- (void)sample:(UInt8 *)sample atCoordinates:(uint32_t *)coordinates;
- (void)setSample:(UInt8 *)sample atCoordinates:(uint32_t *)coordinates;

@optional
- (void)readSamples:(UInt8 *)samples range:(NSRange)range;
- (void)writeSamples:(UInt8 *)samples range:(NSRange)range;

@end

@interface BASampleArray : NSObject<NSCoding, NSCopying, BASampleArray> {
    
    UInt8 *_samples;
    
    NSUInteger _power; // the number of dimensions
    NSUInteger _order; // samples per dimension - the same in all dimensions
    NSUInteger _size;  // bytes per sample, starting at 1
    NSUInteger _count;
}

// These are immutable
@property (nonatomic, readonly) UInt8 *samples;

@property (nonatomic, readonly) NSUInteger power;
@property (nonatomic, readonly) NSUInteger order;
@property (nonatomic, readonly) NSUInteger size;
@property (nonatomic, readonly) NSUInteger count;

- (BOOL)isEqualToSampleArray:(BASampleArray *)other;

- (UInt32)pageSampleAtX:(NSUInteger)x y:(NSUInteger)y;
- (void)setPageSample:(UInt32)sample atX:(NSUInteger)x y:(NSUInteger)y;
- (UInt32)blockSampleAtX:(NSUInteger)x y:(NSUInteger)y z:(NSUInteger)z;
- (void)setBlockSample:(UInt32)sample atX:(NSUInteger)x y:(NSUInteger)y z:(NSUInteger)z;

- (float)blockFloatAtX:(NSUInteger)x y:(NSUInteger)y z:(NSUInteger)z;
- (void)setBlockFloat:(float)sample  atX:(NSUInteger)x y:(NSUInteger)y z:(NSUInteger)z;

+ (BASampleArray *)sampleArrayWithPower:(NSUInteger)power order:(NSUInteger)order size:(NSUInteger)size;
+ (BASampleArray *)page;  // power=2, order=32, size=4 =>   4kB
+ (BASampleArray *)block; // power=3, order=32, size=4 => 128kB

@end
