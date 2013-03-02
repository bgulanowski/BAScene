//
//  SparseBitArray.h
//  Dungineer
//
//  Created by Brent Gulanowski on 12-10-25.
//  Copyright (c) 2012 Lichen Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import <BAScene/BASceneTypes.h>


#define USE_NEW 1

#define TABLE_SIZE 10

extern uint32_t powersOf2[TABLE_SIZE];
extern uint32_t powersOf4[TABLE_SIZE];
extern uint32_t powersOf8[TABLE_SIZE];


@class BASparseBitArray;


typedef void (^SparseArrayUpdate)(BASparseBitArray *bitArray, NSUInteger index, BOOL set);
typedef void  (^SparseArrayBuild)(BASparseBitArray *bitArray, NSUInteger childIndex);
typedef void (^SparseArrayExpand)(BASparseBitArray *bitArray, NSUInteger newLevel);


static inline NSInteger powi ( NSInteger base, NSUInteger exp ) {
    NSInteger result = base;
    if(0 == exp) return 1;
    while(--exp) result *= base;
    return result;
}

static inline uint32_t NextPowerOf2( uint32_t v ) {
    
    v--;
    v |= v >> 1;
    v |= v >> 2;
    v |= v >> 4;
    v |= v >> 8;
    v |= v >> 16;
    v++;
    
    return v;
}


extern uint32_t LeafIndexFor2DCoordinates(uint32_t x, uint32_t y, uint32_t base);
extern void LeafCoordinatesForIndex2D(uint32_t leafIndex, uint32_t *px, uint32_t *py);

extern uint32_t LeafIndexFor3DCoordinates(uint32_t x, uint32_t y, uint32_t z, uint32_t base);
extern void LeafCoordinatesForIndex3D(uint32_t leafIndex, uint32_t *px, uint32_t *py, uint32_t *pz);


@class BABitArray;

@interface BASparseBitArray : NSObject {
    
    SparseArrayUpdate _updateBlock;
    SparseArrayBuild _enlargeBlock;
    SparseArrayExpand _expandBlock;
    
    BABitArray *_bits; // storage for leaf nodes
    NSMutableArray *_children; // storage for interior nodes
    
    __weak id _userObject;
    
    NSUInteger _base;  // size of each dimensions of each leaf node
    NSUInteger _power; // number of dimensions, usually 1 for line, 2 for plane, 3 for volume
    NSUInteger _scale; // number of children of each interior node: 2^power
    NSUInteger _level; // distance to the leaves (level zero); max level is 9 in 32-bit mode
    NSUInteger _leafSize; // maximum storable bits in a leaf node: base^power
    NSUInteger _treeSize; // maximum storable bits for the while sub-tree: treeBase^power = (base * 2^level)^power = leafSize * 2^(level+power)
    NSUInteger _treeBase; // size of each dimension of the whole sub-tree: base * 2^level
}

@property (nonatomic, strong) SparseArrayUpdate updateBlock;
@property (nonatomic, strong)  SparseArrayBuild buildBlock;
@property (nonatomic, strong) SparseArrayExpand expandBlock;

@property (nonatomic, readonly) BABitArray *bits;
@property (nonatomic, readonly) NSArray *children;

@property (nonatomic, weak) id userObject;

@property (nonatomic, readonly) NSUInteger base;
@property (nonatomic, readonly) NSUInteger power;
@property (nonatomic, readonly) NSUInteger level;
@property (nonatomic, readonly) NSUInteger scale;
@property (nonatomic, readonly) NSUInteger leafSize;
@property (nonatomic, readonly) NSUInteger treeSize;
@property (nonatomic, readonly) NSUInteger treeBase;

// The initial tree always has two levels (0 and 1)
// The root, at level 1, has <scale> children, all leaves, each with <leafSize> storage
- (id)initWithBase:(NSUInteger)base power:(NSUInteger)power;

- (void)expandToFitSize:(NSUInteger)newTreeSize;

- (BASparseBitArray *)childAtIndex:(NSUInteger)index;
- (BASparseBitArray *)leafForBit:(NSUInteger)index offset:(NSUInteger *)pOffset;

- (BOOL)bit:(NSUInteger)index;
- (void)setBit:(NSUInteger)index;
- (void)clearBit:(NSUInteger)index;

- (void)setRange:(NSRange)range;
- (void)clearRange:(NSRange)range;

- (void)setAll;
- (void)clearAll;

// power 2 conveniences
- (BOOL)bitAtX:(NSUInteger)x y:(NSUInteger)y;
- (void)updateBitAtX:(NSUInteger)x y:(NSUInteger)y set:(BOOL)set;
- (void)setBitAtX:(NSUInteger)x y:(NSUInteger)y;
- (void)clearBitAtX:(NSUInteger)x y:(NSUInteger)y;

// power 3 conveniences
- (BOOL)bitAtX:(NSUInteger)x y:(NSUInteger)y z:(NSUInteger)z;
- (void)updateBitAtX:(NSUInteger)x y:(NSUInteger)y z:(NSUInteger)z set:(BOOL)set;
- (void)setBitAtX:(NSUInteger)x y:(NSUInteger)y z:(NSUInteger)z;
- (void)clearBitAtX:(NSUInteger)x y:(NSUInteger)y z:(NSUInteger)z;

// Add new category to BAScene and move there
//- (void)setRegion:(BARegioni)region;

@end
