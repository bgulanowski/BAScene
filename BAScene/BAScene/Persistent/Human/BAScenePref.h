//
//  BAPref.h
//  BAScene
//
//  Created by Brent Gulanowski on 25/06/08.
//  Copyright (c) 2008-2014 Bored Astronaut. All rights reserved.
//

#import <BAScene/_BAScenePref.h>


@interface BAScenePref : _BAScenePref {}

+ (NSManagedObject *)objectForIdentifier:(NSString *)identifier;
+ (void)setObject:(NSManagedObject *)anObject forIdentifier:(NSString *)identifier;

@end
