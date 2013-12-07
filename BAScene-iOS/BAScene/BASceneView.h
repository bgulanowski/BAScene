//
//  BASceneView.h
//  BAScene
//
//  Created by Brent Gulanowski on 12-01-14.
//  Copyright (c) 2012 Marketcircle Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BACamera;
@class CADisplayLink;

@interface BASceneView : UIView

@property (nonatomic, strong) BACamera *camera;

@property (nonatomic, strong) EAGLContext *glContext;

@end
