//
//  BACameraGLES.h
//  BAScene-iOS
//
//  Created by Brent Gulanowski on 12/10/2013.
//  Copyright (c) 2013 Marketcircle Inc. All rights reserved.
//

#import <BAScene/BACamera.h>

@interface BACameraGLES : BACamera  {
	GLuint _frameBuffer;
	GLuint _colorRenderBuffer;
}

-(void)setup;

@end
