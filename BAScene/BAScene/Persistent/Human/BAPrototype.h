//
//  BAPrototype.h
//  BAScene
//
//  Created by Brent Gulanowski on 30/05/09.
//  Copyright 2009 Bored Astronaut. All rights reserved.
//

#import <BAScene/_BAPrototype.h>

#import <BAScene/BACamera.h>


@class BAMesh;

@interface BAPrototype : _BAPrototype<BAVisible, NSMutableCopying> {
}

@end

@interface BAPrototype (BAPrototypeDeprecated)

+ (BAPrototype *)findPrototypeWithName:(NSString *)aName DEPRECATED_ATTRIBUTE;

+ (BAPrototype *)prototypeWithName:(NSString *)aName create:(BOOL*)create DEPRECATED_ATTRIBUTE;
+ (BAPrototype *)prototypeWithName:(NSString *)aName DEPRECATED_ATTRIBUTE;
+ (BAPrototype *)prototypeWithName:(NSString *)aName mesh:(BAMesh *)mesh DEPRECATED_ATTRIBUTE;

+ (BAPrototype *)tetrahedron DEPRECATED_ATTRIBUTE;
+ (BAPrototype *)cube DEPRECATED_ATTRIBUTE;
+ (BAPrototype *)octahedron DEPRECATED_ATTRIBUTE;
+ (BAPrototype *)dodecahedron DEPRECATED_ATTRIBUTE;
+ (BAPrototype *)icosahedron DEPRECATED_ATTRIBUTE;

@end


@interface NSManagedObjectContext (BAPrototypeCreating)

- (BAPrototype *)findPrototypeWithName:(NSString *)aName;

- (BAPrototype *)prototypeWithName:(NSString *)aName;
- (BAPrototype *)prototypeWithName:(NSString *)aName mesh:(BAMesh *)mesh; // This will replace any existing mesh

- (BAPrototype *)tetrahedron;
- (BAPrototype *)cube;
- (BAPrototype *)octahedron;
- (BAPrototype *)dodecahedron;
- (BAPrototype *)icosahedron;

@end

