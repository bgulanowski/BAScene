//
//  BAAppDelegate.h
//  SceneKitTest
//
//  Created by Brent Gulanowski on 12-01-09.
//  Copyright (c) 2012 Bored Astronaut. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BAViewController;

@interface BAAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) BAViewController *viewController;

@end
