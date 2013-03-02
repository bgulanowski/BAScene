//
//  BACameraSetup.h
//  BAScene
//
//  Created by Brent Gulanowski on 10-04-18.
//  Copyright 2010 Bored Astronaut. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <BAScene/BAViewController.h>

@class BACamera;


@interface BACameraSetup : BAViewController {

	BACamera *camera;
}

@property (retain) BACamera *camera;

@end
