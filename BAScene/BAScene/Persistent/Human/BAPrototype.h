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

+ (BAPrototype *)prototypeWithName:(NSString *)aName create:(BOOL*)create;
+ (BAPrototype *)prototypeWithName:(NSString *)aName;
+ (BAPrototype *)prototypeWithName:(NSString *)aName mesh:(BAMesh *)mesh; // This will replace any existing mesh

+ (BAPrototype *)findPrototypeWithName:(NSString *)aName;

@end

@interface BAPrototype (BAPrototypeFactories)

+ (BAPrototype *)tetrahedron;
+ (BAPrototype *)cube;
+ (BAPrototype *)octahedron;
+ (BAPrototype *)dodecahedron;
+ (BAPrototype *)icosahedron;

@end

