//
//  BAPoint.h
//  BAScene
//
//  Created by Brent Gulanowski on 30/05/09.
//  Copyright 2009 Bored Astronaut. All rights reserved.
//

#import "BAPoint.h"

#import "BATuple.h"


@implementation BAPoint

#pragma mark NSMutableCopying
- (id)mutableCopyWithZone:(NSZone *)zone {
	
	BAPoint *point = [[[self managedObjectContext] pointWithVertex:[[self.vertex mutableCopyWithZone:zone] autorelease]
                                                             index:self.indexValue] retain];
	
	point.normal = [[self.normal mutableCopyWithZone:zone] autorelease];
	point.texCoord = [[self.texCoord mutableCopyWithZone:zone] autorelease];
	point.color = self.color;
	
	return point;
}


#pragma mark BAVisible
- (void)paintForCamera:(BACamera *)camera {
	
}

- (BALocationf)location {
	BALocationf loc;
	loc.p = [self.vertex point4f];
	return loc;
}


+ (BAPoint *)pointWithVertex:(BATuple *)vert texCoord:(BATuple *)texC index:(UInt16)newIndex {
	BAAssertActiveContext();
    return [BAActiveContext pointWithVertex:vert texCoord:texC index:newIndex];
}

+ (BAPoint *)pointWithVertex:(BATuple *)vert index:(UInt16)newIndex {
    BAAssertActiveContext();
    return [BAActiveContext pointWithVertex:vert index:newIndex];
}

+ (NSSet *)pointsWithWithVertices:(NSArray *)verts texCoords:(NSArray *)texCoords count:(NSUInteger)count {
    BAAssertActiveContext();
    return [BAActiveContext pointsWithWithVertices:verts texCoords:texCoords count:count];
}

+ (NSSet *)pointsWithWithVertices:(NSArray *)verts count:(NSUInteger)count {
    BAAssertActiveContext();
    return [BAActiveContext pointsWithWithVertices:verts count:count];
}

@end


@implementation NSManagedObjectContext (BAPointCreating)

- (BAPoint *)pointWithVertex:(BATuple *)vert texCoord:(BATuple *)texC index:(UInt16)newIndex {
	
	BAPoint *point = [self insertBAPoint];
	
	point.indexValue = newIndex;
	point.vertex = vert;
	point.texCoord = texC;
	
	return point;
}

- (BAPoint *)pointWithVertex:(BATuple *)vert index:(UInt16)newIndex {
	return [self pointWithVertex:vert texCoord:nil index:newIndex];
}

- (NSSet *)pointsWithWithVertices:(NSArray *)verts texCoords:(NSArray *)texCoords count:(NSUInteger)count {
    
	NSMutableSet *results = [NSMutableSet set];
	
	for(NSUInteger i=0;i<count;++i)
		[results addObject:[self pointWithVertex:[verts objectAtIndex:i] texCoord:[texCoords objectAtIndex:i] index:i]];
	
	return results;
}

- (NSSet *)pointsWithWithVertices:(NSArray *)verts count:(NSUInteger)count {
	return [self pointsWithWithVertices:verts texCoords:nil count:count];
}

@end
