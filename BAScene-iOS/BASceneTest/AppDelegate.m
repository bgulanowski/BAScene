//
//  BAAppDelegate.m
//  BASceneTest
//
//  Created by Brent Gulanowski on 12-01-09.
//  Copyright (c) 2012 Bored Astronaut. All rights reserved.
//

#import "AppDelegate.h"

#import "BAViewController.h"
#import "BASceneView.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize scene = _scene;

- (id)init {
	self = [super init];
	if (self) {
		self.scene = [[BAScene alloc] init];
		BAStage *stage = self.scene.stage;
		[stage createPartitionRoot];
	}
	return self;
}

- (void)prepareScene {
	
	NSManagedObjectContext *context = self.scene.context;
	BAProp *ico = [context propWithName:@"ico" prototype:[context icosahedron]];

	ico.color = [context colorWithColor:BAMakeColorf(1, 1, 1, 1)];
	[self.scene.stage addProp:ico];
}

- (void)prepareWindow {
	
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[BAViewController alloc] initWithNibName:@"BAViewController_iPhone" bundle:nil];
    } else {
        self.viewController = [[BAViewController alloc] initWithNibName:@"BAViewController_iPad" bundle:nil];
    }
    self.window.rootViewController = self.viewController;
}

- (void)prepareCamera {
	
	BASceneView *sceneView = (BASceneView *)self.viewController.view;
	BACamera *camera = sceneView.camera;
	
	[EAGLContext setCurrentContext:sceneView.glContext];
	[self.scene.stage.partitionRoot compileProps];
	
	camera.drawDelegate = self.scene.stage;
	[self.scene addActiveCamerasObject:camera];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[self prepareScene];
	[self prepareWindow];
	[self prepareCamera];
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
