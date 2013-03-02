//
//  BASceneMainView.h
//  BAScene
//
//  Created by Brent Gulanowski on 11/10/08.
//  Copyright 2008 Bored Astronaut. All rights reserved.
//

/*
 * This view requires very little setup. The view creates for itself a camera. For the camera to function, it must have
 * it's drawDelegate property set (see BACamera.h).
 */


#import <CoreVideo/CoreVideo.h>


@class BACamera;

@interface BASceneView : NSOpenGLView {

	BACamera *camera;

	GLfloat nearZ;
	GLfloat farZ;
	GLfloat movementRate;
    GLfloat diagRate;
    
    BOOL trackMouse;
    NSPoint mouseLocation;
    
    BOOL _drawInBackground;
    
    CVDisplayLinkRef displayLink;
}

@property (nonatomic, retain) BACamera *camera;
@property (nonatomic) GLfloat nearZ;
@property (nonatomic) GLfloat farZ;
@property (nonatomic) GLfloat movementRate;
@property (nonatomic) BOOL trackMouse;
@property (nonatomic) BOOL drawInBackground;

- (void)enableDisplayLink;
- (void)disableDisplayLink;

+ (void)setCameraClass:(Class)cameraClass;
+ (Class)cameraClass;

@end
