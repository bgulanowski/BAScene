//
//  NSIndexSet+BAAdditions.h
//  BAScene
//
//  Created by Brent Gulanowski on 11-04-29.
//  Copyright (c) 2011-2014 Bored Astronaut. All rights reserved.
//

#import <Foundation/NSIndexSet.h>


@interface NSIndexSet (BAAdditions)

- (id)initWithIndices:(NSUInteger *)indexList count:(NSUInteger)count;
+ (NSIndexSet *)indexSetWithIndices:(NSUInteger *)indexList count:(NSUInteger)count;

@end
