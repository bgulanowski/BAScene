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
    GLuint frameBuffer;
    GLuint colorRenderbuffer;
	CADisplayLink *displayLink;
	BOOL running;
}

@synthesize camera;
@synthesize glContext;

- (void)sceneViewInit {
    
    glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];    
    [EAGLContext setCurrentContext:glContext];
    
    CAEAGLLayer *layer = (CAEAGLLayer *)self.layer;
    
    layer.opaque = YES;
    
    glGenFramebuffers(1, &frameBuffer);    
    glBindFramebuffer(GL_FRAMEBUFFER, frameBuffer);

    glGenRenderbuffers(1, &colorRenderbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, colorRenderbuffer);

    [glContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:layer];
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, colorRenderbuffer);
	
    camera = [[BACamera cameraForEAGLContext:glContext] retain];
    [camera setup];
    camera.zLoc = 10.0f;
    camera.bgColor = BAMakeColorf(0.2f, 0.1f, 0.1f, 1.0f);
    camera.lightsOn = NO;
}

+ (Class)layerClass {
    return [CAEAGLLayer class];
}

- (void)display:(id)sender {
	
    [EAGLContext setCurrentContext:glContext];

    glBindRenderbuffer(GL_RENDERBUFFER, colorRenderbuffer);
//    glColor4f(0.5f, 0.5f, 0.9f, 1.0f);
    [camera capture];
    
    glBindFramebuffer(GL_FRAMEBUFFER, frameBuffer);
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
