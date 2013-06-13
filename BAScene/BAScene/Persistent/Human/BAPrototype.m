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
	
	BAPrototype *prototype = [self.managedObjectContext prototypeWithName:nil];
	NSMutableSet *newPrototypeMeshes = [NSMutableSet setWithCapacity:[self.prototypeMeshes count]];
	
	for(BAPrototypeMesh *prototypeMesh in self.prototypeMeshes) {
		
		BAPrototypeMesh *newPrototypeMesh = [self.managedObjectContext prototypeMesh];
		
		newPrototypeMesh.mesh = [[prototypeMesh.mesh mutableCopyWithZone:zone] autorelease];
		[newPrototypeMeshes addObject:newPrototypeMesh];
	}
	
	prototype.prototypeMeshes = newPrototypeMeshes;
	
	return [prototype retain];
}


#pragma mark Factories
+ (BAPrototype *)prototypeWithName:(NSString *)aName create:(BOOL*)create {
    BAAssertActiveContext();
    if(create && *create)
        return [BAActiveContext prototypeWithName:aName];
    else
        return [BAActiveContext findPrototypeWithName:aName];
}

+ (BAPrototype *)prototypeWithName:(NSString *)aName {
    BAAssertActiveContext();
    return [BAActiveContext prototypeWithName:aName];
}

+ (BAPrototype *)prototypeWithName:(NSString *)aName mesh:(BAMesh *)mesh {
	BAAssertActiveContext();
    return [BAActiveContext prototypeWithName:aName mesh:mesh];
}


#pragma mark New
+ (BAPrototype *)findPrototypeWithName:(NSString *)aName {
    BAAssertActiveContext();
	return [BAActiveContext findPrototypeWithName:aName];
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

@implementation NSManagedObjectContext (BAPrototypeCreating)

- (BAPrototype *)findPrototypeWithName:(NSString *)aName {
    return [self objectForEntityNamed:[BAPrototype entityName] matchingValue:aName forKey:@"name"];
}

- (BAPrototype *)prototypeWithName:(NSString *)aName {
    
    BAPrototype *proto = [self findPrototypeWithName:aName];
    
    if(!proto)
        proto = [BAPrototype insertInManagedObjectContext:self];
    
    return proto;
}

- (BAPrototype *)prototypeWithName:(NSString *)aName mesh:(BAMesh *)mesh {
	
	BAPrototype *proto = [self prototypeWithName:aName];		
    BAPrototypeMesh *pm = [self prototypeMesh];
    
    pm.mesh = mesh;
    [proto addPrototypeMeshesObject:pm];
	
	return proto;
}

- (BAPrototype *)platonicSolidNamed:(NSString *)name {
	
	NSString *protoName = [NSString stringWithFormat:@"BAPrototype:%@", name];
	BAPrototype *proto = [self findPrototypeWithName:protoName];
    
    SEL meshSelector = NSSelectorFromString([name stringByAppendingString:@"Mesh"]);
	
	if(!proto)
		proto = [self prototypeWithName:protoName mesh:objc_msgSend(self, meshSelector)];
	
	return proto;
}

- (BAPrototype *)tetrahedron {
	return [self platonicSolidNamed:@"tetrahedron"];
}

- (BAPrototype *)cube {
	return [self platonicSolidNamed:@"cube"];
}

- (BAPrototype *)octahedron {
	return [self platonicSolidNamed:@"octahedron"];
}

- (BAPrototype *)dodecahedron {
	return [self platonicSolidNamed:@"dodecahedron"];
}

- (BAPrototype *)icosahedron {
	return [self platonicSolidNamed:@"icosahedron"];
}

@end
