//
//  BACamera+Creation.m
//  BAScene
//
//  Created by Brent Gulanowski on 12/5/2013.
//  Copyright (c) 2013 Bored Astronaut. All rights reserved.
//

#import "BACamera+Creation.h"

#import "NSOpenGLContext+BAScene.h"

#import <BAScene/BACameraGL1.h>
#import <BAScene/BACameraGL2.h>
#import <BAScene/BACameraGL3.h>

@implementation BACamera (Creation)

+ (Class)classForGLContext:(NSOpenGLContext *)context {
	
#if 0
	Class BACameraClass = self;
	switch ([context ba_profile]) {
		case kCGLOGLPVersion_Legacy:
			BACameraClass = [BACameraGL2 class]; break;
		case kCGLOGLPVersion_GL3_Core:
		case kCGLOGLPVersion_GL4_Core:
			BACameraClass = [BACameraGL3 class]; break;
		default:
			BACameraClass = [BACameraGL1 class]; break;
	}
	return BACameraClass;
#else
	return [BACameraGL1 class];
#endif
}

+ (BACamera *)cameraForGLContext:(NSOpenGLContext *)context {
	Class BACameraClass = [self classForGLContext:context];
	return [[[BACameraClass alloc] init] autorelease];
}

@end
