//
//  BAAppDelegate.h
//  BASceneTest
//
//  Created by Brent Gulanowski on 12-01-09.
//  Copyright (c) 2012 Bored Astronaut. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BAViewController, BAScene;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) BAViewController *viewController;
@property (strong, nonatomic) BAScene *scene;

@end
