//
//  BACamera+EAGLCreation.h
//  BAScene-iOS
//
//  Created by Brent Gulanowski on 12/6/2013.
//  Copyright (c) 2013 Marketcircle Inc. All rights reserved.
//

#import "BACamera.h"

@interface BACamera (EAGLCreation)

+ (Class)classForEAGLContext:(EAGLContext *)context;
+ (BACamera *)cameraForEAGLContext:(EAGLContext *)context;

@end
