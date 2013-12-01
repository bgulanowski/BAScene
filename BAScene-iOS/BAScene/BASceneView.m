//
//  BASceneView.m
//  BAScene
//
//  Created by Brent Gulanowski on 12-01-14.
//  Copyright (c) 2012 Marketcircle Inc. All rights reserved.
//

#import <BAScene/BASceneView.h>

#import <BAScene/BACamera.h>
#import <BAScene/BASceneUtilities.h>

@implementation BASceneView {
    GLuint frameBuffer;
    GLuint colorRenderbuffer;
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
    

    camera = [[BACamera alloc] init];
    [camera setup];
    camera.zLoc = 10.0f;
    camera.bgColor = BAMakeColorf(0.2f, 0.1f, 0.1f, 1.0f);
//    camera.lightsOn = NO;
}

+ (Class)layerClass {
    return [CAEAGLLayer class];
}

- (void)display {
    [EAGLContext setCurrentContext:glContext];

    glBindRenderbuffer(GL_RENDERBUFFER, colorRenderbuffer);
    glColor4f(0.5f, 0.5f, 0.9f, 1.0f);

    [camera capture];
    
    glBindFramebuffer(GL_FRAMEBUFFER, frameBuffer);
    [glContext presentRenderbuffer:GL_FRAMEBUFFER];
}

- (void)awakeFromNib {
    [self sceneViewInit];
}

- (void)didMoveToWindow {
    
    CGSize size = self.bounds.size;
    
    glViewport(0, 0, size.width, size.height);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glFrustumf(-1.0f, 1.0f, -size.height/size.width, size.height/size.width, 5.0f, 50.0f);
}

@end
