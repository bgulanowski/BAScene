//
//  BAPrototype.h
//  BAScene
//
//  Created by Brent Gulanowski on 30/05/09.
//  Copyright 2009 Bored Astronaut. All rights reserved.
//

#import "BAPrototype.h"

#import "BAMesh.h"
#import "BAPrototypeMesh.h"

#import <objc/message.h>


@implementation BAPrototype

#pragma mark NSMutableCopying
- (id)mutableCopyWithZone:(NSZone *)zone {
	
	BAPrototype *prototype = [[self class] prototypeWithName:nil];
	NSMutableSet *newPrototypeMeshes = [NSMutableSet setWithCapacity:[self.prototypeMeshes count]];
	
	for(BAPrototypeMesh *prototypeMesh in self.prototypeMeshes) {
		
		BAPrototypeMesh *newPrototypeMesh = [BAPrototypeMesh prototypeMesh];
		
		newPrototypeMesh.mesh = [[prototypeMesh.mesh mutableCopyWithZone:zone] autorelease];
		[newPrototypeMeshes addObject:newPrototypeMesh];
	}
	
	prototype.prototypeMeshes = newPrototypeMeshes;
	
	return [prototype retain];
}


#pragma mark Factories
+ (BAPrototype *)prototypeWithName:(NSString *)aName create:(BOOL*)create {
	return [BAActiveContext objectForEntityNamed:@"Prototype" matchingValue:aName forKey:@"name" create:create];
}

+ (BAPrototype *)prototypeWithName:(NSString *)aName {
	BOOL create = YES;
	return [self prototypeWithName:aName create:&create];
}

+ (BAPrototype *)prototypeWithName:(NSString *)aName mesh:(BAMesh *)mesh {
	
	BOOL create = YES;
	BAPrototype *proto = [self prototypeWithName:aName create:&create];
	
	if(create) {
		
		BAPrototypeMesh *pm = [BAPrototypeMesh prototypeMesh];
		
		pm.mesh = mesh;
		[proto addPrototypeMeshesObject:pm];
	}
	
	return proto;
}


#pragma mark New
+ (BAPrototype *)findPrototypeWithName:(NSString *)aName {
	return [self prototypeWithName:aName create:NULL];
}


#pragma mark BAVisible
- (void)paintForCamera:(BACamera *)camera {
	for(BAPrototypeMesh *pm in self.prototypeMeshes)
		[pm paintForCamera:camera];
}

- (void)setColor:(BAColor *)aColor {
	[self.prototypeMeshes makeObjectsPerformSelector:@selector(setColor:) withObject:aColor];
}

@end

@implementation BAPrototype (BAPrototypeFactories)

+ (BAPrototype *)platonicSolidNamed:(NSString *)name {
	
	NSString *protoName = [NSString stringWithFormat:@"BAPrototype:%@", name];
	BAPrototype *proto = [self findPrototypeWithName:protoName];
	
	if(!proto)
		proto = [self prototypeWithName:protoName mesh:objc_msgSend([BAMesh class], NSSelectorFromString(name))];
	
	return proto;
}

+ (BAPrototype *)tetrahedron {
	return [self platonicSolidNamed:@"tetrahedron"];
}

+ (BAPrototype *)cube {
	return [self platonicSolidNamed:@"cube"];
}

+ (BAPrototype *)octahedron {
	return [self platonicSolidNamed:@"octahedron"];
}

+ (BAPrototype *)dodecahedron {
	return [self platonicSolidNamed:@"dodecahedron"];
}

+ (BAPrototype *)icosahedron {
	return [self platonicSolidNamed:@"icosahedron"];
}


@end
