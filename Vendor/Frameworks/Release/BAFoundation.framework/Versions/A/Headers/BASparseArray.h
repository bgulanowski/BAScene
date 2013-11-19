//
//  BASparseArray.h
//  BAFoundation
//
//  Created by Brent Gulanowski on 13-03-07.
//  Copyright (c) 2013 Lichen Labs. All rights reserved.
//

#import <Foundation/Foundation.h>


#define TABLE_SIZE 10

extern uint32_t powersOf2[TABLE_SIZE];
extern uint32_t powersOf4[TABLE_SIZE];
extern uint32_t powersOf8[TABLE_SIZE];


@class BASparseArray;


typedef void  (^SparseArrayUpdate)(BASparseArray *sparseArray, NSUInteger index, void *newValue);
typedef void   (^SparseArrayBuild)(BASparseArray *sparseArray, NSUInteger childIndex);
typedef void  (^SparseArrayExpand)(BASparseArray *sparseArray, NSUInteger newLevel);
// This can be used for application-specific changes
typedef void (^SparseArrayRefresh)(BASparseArray *sparseArray);

// return YES to prune the given tree
typedef BOOL (^SparseArrayWalk)(BASparseArray *sparseArray, NSIndexPath *indexPath, NSUInteger *offset);


/* Leaf indexes for multi-dimensional arrays are numbered consistently following a recursive pattern.
 * Each leaf index is determined by its search order in the tree. As the tree grows, new leaves
 * are appended to the end of the seach order, thus preserving the numbering scheme.
 *
 * For example, in the two-dimensional case, a 2-level tree has four leaves, with co-ordinates:
 *    (0,0), (0,1), (1,0), (1,1)
 *
 * A 3-level tree has 16 leaves; the co-ordinates of the first three in the first row (along the X-axis) are:
 *    (0,0) -> (0,0):(0,0) -> 00 00 -> 0
 *    (0,1) -> (0,0):(0,1) -> 00 01 -> 1
 *    (0,2) -> (0,1):(0,1) -> 01 01 -> 5
 *
 * The co-ordinates of the first column (counting upward from zero along the Y-axis) are:
 *    (0,0) -> (0,0):(0,0) -> 00 00 -> 0
 *    (1,0) -> (0,0):(1,0) -> 00 10 -> 2
 *    (2,0) -> (1,0):(0,0) -> 10 00 -> 8
 *
 * The first form of the leaf index is the absolute co-ordinate of the leaf (x,y). The second form
 * is the recursive coordinate at each level, starting at the highest. The third form shows the recursive
 * co-ordinate without the punctuation: it is a binary number with stanzas, each with a width equal to the
 * dimension of the tree (in this case, the tree has 2 dimensions, and the stanzas have 2 bits).
 *
 * Here are the first few indexes for a 2-dimensional ordering, graphically:
 *
 * |    |    $    |     #    |    $    |
 * +----+----+----+---- +----+----+----+-
 * | 40 | 41 $ 44 | 45  # 48 | 49 $ 52 |
 * ++++++++++++++++++++ ++++++++++++++++-
 * | 34 | 35 $ 38 | 39  # 50 | 51 $ 54 |
 * +----+----+----+---- +----+----+----+-
 * | 32 | 33 $ 36 | 37  # 48 | 49 $ 52 |
 * +====+====+====+==== +====+====+====+-
 
 * | 10 | 11 $ 14 | 15  # 26 | 27 $ 30 |
 * +----+----+----+---- +----+----+----+-
 * |  8 |  9 $ 12 | 13  # 24 | 25 $ 28 |
 * ++++++++++++++++++++ ++++++++++++++++-
 * |  2 |  3 $  6 |  7  # 18 | 19 $ 22 |
 * +----+----+----+---- +----+----+----+-
 * |  0 |  1 $  4 |  5  # 16 | 17 $ 20 |
 * +----+----+----+---- +----+----+----+-
 *
 * A 4-level, 3-dimensional tree example:
 *    - tree base (max length of each dimension): 2^(4-1) = 2^3 = 8; co-ordinate elements range from 0-7
 *    - total tree size (number of leaves): (2^(4-1))^3 = 8^3 = 512 (size sequence: 1, 8, 64, 512)
 *
 *    (5,3,6) -> (1*4+1,0*4+3,1*4+2):(0*2+1,1*2+1,1*2+0):(1,0,1) -> (1,0,1):(0,1,1):(1,0,1) -> 101 011 101 -> 349
 *
 * Notes:
 *    - 5 is decomposed into (1*4)+(0*2)+1
 *    - 3 is decomposed into (0*4)+(1*2)+1
 *    - 6 is decomposed into (1*4)+(1*2)+0
 *    - 4 is half of 8 (tree base); the child index at level 4, (1,0,1), is determined by whether the element is >=4
 *         - if the element is >=4, subtract 4 and recurse with the remainder
 *    - 2 is half of 4; the child index at level 3, (0,1,1), is determined by whether the new element >= 2
 *
 * When adding a level, all existing leaves are prepended with zero coordinates (0,0) or (0,0,0) or (0,0...,0).
 * Thus their sequential index is constant regardless of the size of the tree. We simply need a larger number
 * of stanzas to describe the largest addressable index.
 *
 * The one-dimensional case degenerates to sequential order.
 *
 * Although this numbering sequence only supports positive co-ordinate values, it is possible to build
 * an array that supports negative growth out of multiple sparse arrays, one sparse array per partition,
 * where a partition is a combination of signed directions, one per axis. A 1-d aggregate array would need 2 sparse
 * arrays; a 2-d aggregate would need 4, etc.
 *
 * The aggregate representation is responsible for transforming the absolute coordinate space into a relative
 * coordinate space of positive values using mirroring and translation by 1 (-1 -> 0, -2 -> 1, -3 -> 2, etc).
 * If transforming from a floating point co-ordinate space to an integer space, more care is needed.
 */


extern uint32_t LeafIndexFor2DCoordinates(uint32_t x, uint32_t y, uint32_t base);
extern void LeafCoordinatesForIndex2D(uint32_t leafIndex, uint32_t *px, uint32_t *py);

extern uint32_t LeafIndexFor3DCoordinates(uint32_t x, uint32_t y, uint32_t z, uint32_t base);
extern void LeafCoordinatesForIndex3D(uint32_t leafIndex, uint32_t *px, uint32_t *py, uint32_t *pz);

extern uint32_t LeafIndexForCoordinates(uint32_t *coords, uint32_t base, uint32_t power);
extern void LeafCoordinatesForIndex(uint32_t leafIndex, uint32_t *coords, uint32_t power);

@interface BASparseArray : NSObject<NSCoding> {
    
    SparseArrayBuild _enlargeBlock;
    SparseArrayExpand _expandBlock;
    SparseArrayUpdate _updateBlock;
    SparseArrayRefresh _refreshBlock;
    
    NSMutableArray *_children; // interior nodes
    
    __weak id _userObject;
    
    NSUInteger _base;  // size of each dimensions of each leaf node
    NSUInteger _power; // number of dimensions, usually 1 for line, 2 for plane, 3 for volume
    NSUInteger _scale; // number of children of each interior node: 2^power
    NSUInteger _level; // distance to the leaves (level zero); max level is 9 in 32-bit mode
    NSUInteger _leafSize; // maximum storable bits in a leaf node: base^power
    NSUInteger _treeSize; // maximum storable bits for the while sub-tree: treeBase^power = (base * 2^level)^power = leafSize * 2^(level+power)
    NSUInteger _treeBase; // size of each dimension of the whole sub-tree: base * 2^level
    
    BOOL _enableArchiveCompression;
}

@property (nonatomic, copy) SparseArrayBuild buildBlock;
@property (nonatomic, copy) SparseArrayExpand expandBlock;
@property (nonatomic, copy) SparseArrayUpdate updateBlock;
@property (nonatomic, copy) SparseArrayRefresh refreshBlock;

@property (nonatomic, readonly) NSArray *children;

@property (nonatomic, weak) id userObject;

@property (nonatomic, readonly) NSUInteger base;
@property (nonatomic, readonly) NSUInteger power;
@property (nonatomic, readonly) NSUInteger level;
@property (nonatomic, readonly) NSUInteger scale;
@property (nonatomic, readonly) NSUInteger leafSize;
@property (nonatomic, readonly) NSUInteger treeSize;
@property (nonatomic, readonly) NSUInteger treeBase;

@property (nonatomic) BOOL enableArchiveCompression;

- (void)walkChildren:(SparseArrayWalk)walkBlock;

// The initial tree always has two levels (0 and 1)
// The root, at level 1, has <scale> children, all leaves, each with <leafSize> storage
- (id)initWithBase:(NSUInteger)base power:(NSUInteger)power;

- (void)expandToFitSize:(NSUInteger)newTreeSize;

- (BASparseArray *)childAtIndex:(NSUInteger)index;
- (BASparseArray *)leafForIndex:(NSUInteger)index;
- (BASparseArray *)leafForStorageIndex:(NSUInteger)index offset:(NSUInteger *)pOffset;

@end
