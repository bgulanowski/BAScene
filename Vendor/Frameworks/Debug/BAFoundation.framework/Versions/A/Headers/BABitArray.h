//
//  BABitArray.h
//
//  Created by Brent Gulanowski on 09-09-27.
//  Copyright 2009 Bored Astronaut. All rights reserved.
//


typedef void (^BABitArrayEnumerator) (NSUInteger bit);


@interface BABitArray : NSObject<NSCopying, NSCoding> {
	unsigned char *buffer;
	NSUInteger bufferLength; // in bytes, rounded up
	NSUInteger length;       // in bits as initialized
	NSUInteger count;        // number of set bits
}

@property (readonly) NSUInteger length;
@property (readonly) NSUInteger count;

- (BOOL)bit:(NSUInteger)index;
- (void)setBit:(NSUInteger)index;
- (void)setRange:(NSRange)range;
- (void)setAll;
- (void)clearBit:(NSUInteger)index;
- (void)clearRange:(NSRange)range;
- (void)clearAll;

- (NSUInteger)firstSetBit;
- (NSUInteger)lastSetBit;
- (NSUInteger)firstClearBit;
- (NSUInteger)lastClearBit;

- (NSUInteger)nextAfter:(NSUInteger)prev;
- (void)enumerate:(BABitArrayEnumerator)block;

- (BOOL)checkCount;
- (void)refreshCount;

- (id)initWithLength:(NSUInteger)bits;

+ (BABitArray *)bitArrayWithLength:(NSUInteger)bits;
+ (BABitArray *)bitArray8;
+ (BABitArray *)bitArray64;
+ (BABitArray *)bitArray512;
+ (BABitArray *)bitArray4096; // 16^3, our zone volume

@end
