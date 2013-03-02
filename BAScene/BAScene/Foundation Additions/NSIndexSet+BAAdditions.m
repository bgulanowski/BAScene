//
//  NSIndexSet+BAAdditions.m
//  BAScene
//
//  Created by Brent Gulanowski on 11-04-29.
//  Copyright 2011 Bored Astronaut. All rights reserved.
//

#import "NSIndexSet+BAAdditions.h"


@implementation NSIndexSet (BAAdditions)

- (id)initWithIndices:(NSUInteger *)indexList count:(NSUInteger)count {
	
	NSMutableIndexSet *indices = [NSMutableIndexSet indexSet];
	
	if(indexList)
		for(NSUInteger i=0; i<count; ++i)
			[indices addIndex:indexList[i]];

	return [self initWithIndexSet:indices];
}

+ (NSIndexSet *)indexSetWithIndices:(NSUInteger *)indexList count:(NSUInteger)count {
	return (NSIndexSet *)[[[self alloc] initWithIndices:indexList count:count] autorelease];
}

@end
