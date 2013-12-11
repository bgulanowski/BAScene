//
//  BACameralGLES2.m
//  BAScene-iOS
//
//  Created by Brent Gulanowski on 12/2/2013.
//  Copyright (c) 2013 Marketcircle Inc. All rights reserved.
//

#import <BAScene/BACameraGLES2.h>

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@implementation BACameraGLES2 {
	GLuint frameBuffer;
    GLuint colorRenderbuffer;
}

- (void)setup {
	glGenFramebuffers(1, &frameBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, frameBuffer);
    glGenRenderbuffers(1, &colorRenderbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, colorRenderbuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, colorRenderbuffer);
}

@end
