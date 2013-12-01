//
//  NSArray+BAAdditions.m
//  BAScene
//
//  Created by Brent Gulanowski on 11-04-30.
//  Copyright 2011 Bored Astronaut. All rights reserved.
//

#import <BAScene/NSArray+BAAdditions.h>


@implementation NSArray (BAAdditions)

- (NSArray *)objectsWithIndexArray:(NSUInteger *)indices count:(NSUInteger)count {
	
	if(!indices)
		return [NSArray array];
	
	id *objects = malloc(count * sizeof(id));
	
	for(NSUInteger i=0; i<count; ++i)
		objects[i] = [self objectAtIndex:indices[i]];
	
	NSArray *result = [NSArray arrayWithObjects:objects count:count];
	
	free(objects);
	
	return result;
}

@end
