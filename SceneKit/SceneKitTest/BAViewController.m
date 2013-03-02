//
//  BAViewController.m
//  SceneKitTest
//
//  Created by Brent Gulanowski on 12-01-09.
//  Copyright (c) 2012 Bored Astronaut. All rights reserved.
//

#import "BAViewController.h"

#import <SceneKit/BASceneView.h>


@implementation BAViewController

@synthesize sceneContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        sceneContext = [BAScene configuredContext];
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    BAProp *ico = [BAProp propWithName:@"ico" prototype:[BAPrototype icosahedron]];
    [[BAStage stage] addProp:ico];
    
    [EAGLContext setCurrentContext:[(BASceneView *)self.view glContext]];
    [[[ico.prototype.prototypeMeshes anyObject] mesh] compile];
    
//    BASceneView *sv = (BASceneView *)self.view;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [(BASceneView *)self.view display];
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
