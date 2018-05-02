//
//  BACameraSetup.m
//  BAScene
//
//  Created by Brent Gulanowski on 10-04-18.
//  Copyright (c) 2010-2014 Bored Astronaut. All rights reserved.
//

#import "BACameraSetup.h"


@implementation BACameraSetup

@synthesize camera;

- (void)dealloc {
    self.camera = nil;
    [super dealloc];
}

@end
