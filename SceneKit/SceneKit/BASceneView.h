//
//  BASceneView.h
//  SceneKit
//
//  Created by Brent Gulanowski on 12-01-14.
//  Copyright (c) 2012 Marketcircle Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BASceneView : UIView

@property (nonatomic, strong) BACamera *camera;

@property (nonatomic, strong) EAGLContext *glContext;

- (void)display;

@end
