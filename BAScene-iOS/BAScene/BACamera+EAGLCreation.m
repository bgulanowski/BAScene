//
//  BACamera+EAGLCreation.m
//  BAScene-iOS
//
//  Created by Brent Gulanowski on 12/6/2013.
//  Copyright (c) 2013 Marketcircle Inc. All rights reserved.
//

#import <BAScene/BACamera+EAGLCreation.h>

#import <BAScene/BACameraGLES1.h>
#import <BAScene/BACameraGLES2.h>

@implementation BACamera (EAGLCreation)

+ (Class)classForEAGLContext:(EAGLContext *)context {
	Class BACameraClass = nil;
	switch (context.API) {
		case kEAGLRenderingAPIOpenGLES3:
//			BACameraClass = [BACameraGLES3 class];
//			break;
		case kEAGLRenderingAPIOpenGLES2:
//			BACameraClass = [BACameraGLES2 class];
			break;
		case kEAGLRenderingAPIOpenGLES1:
		default:
			BACameraClass = [BACameraGLES1 class];
			break;
	}
	return BACameraClass;
}

+ (BACamera *)cameraForEAGLContext:(EAGLContext *)context {
	Class BACameraClass = [self classForEAGLContext:context];
	return [[[BACameraClass alloc] init] autorelease];
}

@end
