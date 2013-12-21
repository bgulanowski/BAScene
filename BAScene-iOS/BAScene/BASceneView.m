//
//  BASceneView.m
//  BAScene
//
//  Created by Brent Gulanowski on 12-01-14.
//  Copyright (c) 2012 Marketcircle Inc. All rights reserved.
//

#import <BAScene/BASceneView.h>

#import <BAScene/BACamera+EAGLCreation.h>
#import <BAScene/BASceneUtilities.h>
#import <CoreVideo/CoreVideo.h>

@implementation BASceneView {
	CADisplayLink *displayLink;
	BOOL running;
}

@synthesize camera;
@synthesize glContext;

- (void)sceneViewInit {
    
    glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    camera = [[BACamera cameraForEAGLContext:glContext] retain];
	
	if (!camera) {
		glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
		camera = [[BACamera cameraForEAGLContext:glContext] retain];
	}
	
    [EAGLContext setCurrentContext:glContext];
    [camera setup];
    camera.zLoc = 10.0f;
    camera.bgColor = BAMakeColorf(0.2f, 0.1f, 0.1f, 1.0f);
    
    CAEAGLLayer *layer = (CAEAGLLayer *)self.layer;
    layer.opaque = YES;
    [glContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:layer];
}

+ (Class)layerClass {
    return [CAEAGLLayer class];
}

- (void)display:(CADisplayLink *)sender {
    [EAGLContext setCurrentContext:glContext];
	[camera update:sender.duration];
    [camera capture];
    [glContext presentRenderbuffer:GL_FRAMEBUFFER];
}

- (void)awakeFromNib {
    [self sceneViewInit];
}

- (void)didMoveToWindow {
    
	if (self.window) {
		if (!running) {
			displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(display:)];
			[displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
			running = YES;
		}
		
		[EAGLContext setCurrentContext:glContext];
		[camera updateViewPortWithSize:self.bounds.size];
	}
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
	if (!newWindow && running) {
		[displayLink invalidate];
		displayLink = nil;
		running = NO;
	}
}

@end
