//
//  BATuple.h
//  BAScene
//
//  Created by Brent Gulanowski on 5/4/09.
//  Copyright 2009 Bored Astronaut. All rights reserved.
//

#import <BAScene/BATuple.h>

#import <BAScene/BASceneUtilities.h>
#import <BAScene/BATransform.h>

#import <BAFoundation/NSManagedObject+BAAdditions.h>


@implementation BATuple

#pragma mark - NSMutableCopying
- (id)mutableCopyWithZone:(NSZone *)zone {
	return [[[self managedObjectContext] tupleWithPoint4f:[self point4f]] retain];
}


#pragma mark - New
- (void)takeValuesFromPoint:(BAPointf)point {
	self.xValue = point.x;
	self.yValue = point.y;
	self.zValue = point.z;
}

- (void)takeValuesFromPoint4f:(BAPoint4f)point {
	self.xValue = point.x;
	self.yValue = point.y;
	self.zValue = point.z;
}

- (BAPointf)pointf {
	return BAMakePointf(self.xValue, self.yValue, self.zValue);
}

- (BAPoint4f)point4f {
	return BAMakePoint4f(self.xValue, self.yValue, self.zValue, 1.0f);
}

- (BAPoint4f)vector4f {
	return BAMakePoint4f(self.xValue, self.yValue, self.zValue, 1.0f);
}

- (NSString *)baDescription {
	return [NSString stringWithFormat:@"(%.3f %.3f %.3f)", self.xValue, self.yValue, self.zValue];
}

- (void)applyMatrixTransform:(BAMatrix4x4f)matrix {
	[self takeValuesFromPoint4f:BATransformPoint4f([self vector4f], matrix)];
}

- (id)applyTransform:(BATransform *)transform {
	[self applyMatrixTransform:[transform transform]];
	return self;
}

- (BATuple *)transformedTuple:(BATransform *)transform {
	return [[[self managedObjectContext] tupleWithPoint:[self pointf]] applyTransform:transform];
}

@end


@implementation NSManagedObjectContext (BATupleCreating)

- (BATuple *)tupleWithPoint:(BAPointf)point {
	
	BATuple *tuple = [self insertBATuple];
	
	[tuple takeValuesFromPoint:point];
	
	return tuple;
}

- (BATuple *)tupleWithPoint4f:(BAPoint4f)point {
	
	BATuple *tuple = [self insertBATuple];
	
	[tuple takeValuesFromPoint4f:point];
	
	return tuple;
}

- (BATuple *)tupleWithX:(double)x y:(double)y z:(double)z {
	
#if 0
	return [self tupleWithPoint:BAMakePointf(x, y, z)];
#else
#if 1
	BATuple *tuple = nil;
#else
	NSPredicate *pred = [NSPredicate predicateWithFormat:@"x=%f AND y=%f AND z=%f", x, y, z];
	BATuple *tuple = [BAActiveContext objectForEntityNamed:@"Point" matchingPredicate:pred];
#endif
	
	if(nil == tuple) {
		tuple = (BATuple *)[BATuple insertInManagedObjectContext:self];
		
		tuple.xValue = x;
		tuple.yValue = y;
		tuple.zValue = z;
	}
	
	return tuple;
#endif
}

- (NSArray *)tuplesWithPointArray:(BAPointf *)points count:(NSUInteger)count {
	
	NSMutableArray *result = [NSMutableArray array];
	
	for(NSUInteger i = 0; i<count; ++i)
		[result addObject:[self tupleWithPoint:*(points+i)]];
	
	return result;
}

@end
