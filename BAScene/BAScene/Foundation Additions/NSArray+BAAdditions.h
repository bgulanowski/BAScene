//
//  NSArray+BAAdditions.h
//  BAScene
//
//  Created by Brent Gulanowski on 11-04-30.
//  Copyright (c) 2011-2014 Bored Astronaut. All rights reserved.
//

#import <Foundation/NSArray.h>


@interface NSArray (BAAdditions)
- (NSArray *)objectsWithIndexArray:(NSUInteger *)indices count:(NSUInteger)count;
@end
