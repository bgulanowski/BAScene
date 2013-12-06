//
//  BACamera+Creation.h
//  BAScene
//
//  Created by Brent Gulanowski on 12/5/2013.
//  Copyright (c) 2013 Bored Astronaut. All rights reserved.
//

#import <BAScene/BACamera.h>

@interface BACamera (Creation)
+ (Class)classForGLContext:(NSOpenGLContext *)context;
+ (BACamera *)cameraForGLContext:(NSOpenGLContext *)context;
@end
