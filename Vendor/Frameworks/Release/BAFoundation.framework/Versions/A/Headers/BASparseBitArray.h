//
//  SparseBitArray.h
//  Dungineer
//
//  Created by Brent Gulanowski on 12-10-25.
//  Copyright (c) 2012 Lichen Labs. All rights reserved.
//

#import <BAFoundation/BASparseArray.h>

#import <BAFoundation/BABitArray.h>


@class BASparseBitArray;

typedef void(^SparseRangeUpdate)(BASparseBitArray *bitArray, NSRange range, BOOL set);


@interface BASparseBitArray : BASparseArray<NSCoding, BABitArray> {
    SparseRangeUpdate _rangeUpdateBlock;
    BABitArray *_bits; // storage for leaf data
}

@property (nonatomic, strong) BABitArray *bits;

// Add new category to BAScene and move there
//- (void)setRegion:(BARegioni)region;

@end


@interface BASparseBitArray (SpatialStorage) <BABitArray2D>
@end
