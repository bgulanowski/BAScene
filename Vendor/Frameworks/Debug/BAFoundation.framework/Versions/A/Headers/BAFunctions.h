//
//  BAFunctions.h
//  BAFoundation
//
//  Created by Brent Gulanowski on 13-03-15.
//  Copyright (c) 2013 Lichen Labs. All rights reserved.
//

#ifndef BAFoundation_BAFunctions_h
#define BAFoundation_BAFunctions_h

static inline NSInteger powi ( NSInteger base, NSUInteger exp ) {
    NSInteger result = 1;
    while(exp) {
        if (exp & 1)
            result *= base;
        exp >>= 1;
        base *= base;
    }
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

static inline NSUInteger countBits(BOOL *bits, NSUInteger length) {
    NSUInteger count = 0;
    for (NSUInteger i=0; i<length; ++i)
        if(bits[i])
            ++ count;
    return count;
}

#endif
