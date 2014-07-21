//
//  BACameraGL1.m
//  BAScene
//
//  Created by Brent Gulanowski on 12/2/2013.
//  Copyright (c) 2013 Bored Astronaut. All rights reserved.
//

#import "BACameraGL1.h"

#import <OpenGL/gl.h>
#import <OpenGL/glu.h>

static inline GLenum BAPolygonModeToGL(BAPolygonMode mode) {
    
    switch (mode) {
        case BAPolygonModePoint: return GL_POINT; break;
        case BAPolygonModeLine:  return GL_LINE;  break;
        case BAPolygonModeFill:
        default:                 return GL_FILL;  break;
    }
}

#if 0
static inline BAPolygonMode BAPolygonModeFromGL(GLenum mode) {
    switch (mode) {
        case GL_POINT: return BAPolygonModePoint; break;
        case GL_LINE:  return BAPolygonModeLine;  break;
        case GL_FILL:
        default:       return BAPolygonModeFill;  break;
    }
}
#endif

@implementation BACameraGL1

- (void)setup {
    
	glDepthFunc(GL_LESS);
	glBlendFunc(GL_SRC_ALPHA,  GL_ONE_MINUS_SRC_ALPHA);
	glEnable(GL_BLEND);
	glShadeModel(GL_SMOOTH);
	glLightModelf(GL_LIGHT_MODEL_TWO_SIDE, 1.0);
	glEnable(GL_COLOR_MATERIAL);
    glClearDepth(1.0);
	glColorMaterial(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE);
		
	GLfloat diffuse[4]  = { 0.5f, 0.5f, 0.5f, 1.0f};
    
	glLightfv(GL_LIGHT0, GL_DIFFUSE, diffuse);
	glEnable(GL_LIGHT0);
    
	glEnable(GL_NORMALIZE);
}

- (void)applyViewTransform:(BAMatrix4x4f * const)transform {
	_transformApplyCount++;
	glPushMatrix();
	glMultMatrixf( transform->i );
}

- (void)revertViewTransform {
	glPopMatrix();
	_transformApplyCount--;
}

- (void)updateGLState {
    if(changes.lightsOn) options.lightsOn ? glEnable(GL_LIGHTING)   : glDisable(GL_LIGHTING);
    if(changes.cullOn)   options.cullOn   ? glEnable(GL_CULL_FACE)  : glDisable(GL_CULL_FACE);
    if(changes.depthOn)  options.depthOn  ? glEnable(GL_DEPTH_TEST) : glDisable(GL_DEPTH_TEST);
    
    if(changes.frontMode) glPolygonMode(GL_FRONT, BAPolygonModeToGL(self.frontMode));
    if(changes.backMode)  glPolygonMode(GL_BACK, BAPolygonModeToGL(self.backMode));
    if(colorChanges.background) glClearColor(bgColor.c.r, bgColor.c.g, bgColor.c.b, 1.0f);
    
    
    if(colorChanges.lightLoc)   glLightfv(GL_LIGHT0, GL_POSITION,  lightLoc.i);
    if(colorChanges.light) 	    glLightfv(GL_LIGHT0, GL_AMBIENT,   lightColor.i);
    if(colorChanges.shine)      glLightfv(GL_LIGHT0, GL_SPECULAR, lightShine.i);
    
    changes = (BACameraOptions) {};
    colorChanges = (BACameraColorChanges) {};
}

#if 0
// This is now so old I forget exactly how it worked
- (void)blurWithAccumulateBuffer {
	
	if(options.blurOn && blur > 0)
		glAccum(GL_RETURN, blur);
	
	GLint viewport[4];
	glGetIntegerv(GL_VIEWPORT, viewport);
	
	glBindFramebuffer(GL_FRAMEBUFFER, blurBuffer);
	glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, blurTexture, 0);
	
	if(GL_FRAMEBUFFER_COMPLETE == glCheckFramebufferStatus(GL_FRAMEBUFFER)) {
		glCopyTexImage2D(GL_TEXTURE_2D, 0, GL_RGB8, 0, 0, viewport[2], viewport[3], 0);
		
		// do stuff
		
		// set rendering back to the windowing system's default framebuffer
		glBindFramebuffer(GL_FRAMEBUFFER, 0);
	}
}
#endif

- (void)drawFramerate:(NSTimeInterval)start {
	
	renderTimes[timeIndex] = [NSDate timeIntervalSinceReferenceDate] - start;
	static BOOL logTime = YES;
	if(logTime) {
		NSLog(@"Frame took %.5f", renderTimes[timeIndex]);
		logTime = NO;
	}
	if(++timeIndex > 30) {
		timeIndex = 0;
		
		NSTimeInterval total = 0;
		for(NSUInteger index = 0; index<30; ++index)
			total += renderTimes[index];
		
		self.frameRate = 30.0f/total;
		
		NSLog(@"Last thirty renders took %f seconds total", total);
	}
}

- (void)capture {
	
	NSTimeInterval start = options.rateOn ? [NSDate timeIntervalSinceReferenceDate] : 0;
	
    [self updateGLState];
    
	if (options.blurOn)
        [self paintBlur];
	else
		glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
    
	glMatrixMode(GL_MODELVIEW);
	glRenderMode(GL_RENDER);
    
    glPushMatrix();
    glLoadIdentity();
    
    BAMatrix4x4f m;
    
    if(options.revolveOn)
        m = BAMatrixFocus(self.location, self.focus);
    else
        m = matrix;
    
    glLoadMatrixf(m.i);
		
#if ! TARGET_OS_IPHONE
	// TODO: make these into BAVisible objects; add to props
	if(options.testOn) {
		static GLUquadric *quad = NULL;
		if(NULL == quad) quad = gluNewQuadric();
		gluSphere(quad, 4, 32, 32);
	}
	if(options.showOriginOn)
		BADrawOrigin();
	if(options.showFocusOn) {
		glBegin(GL_POINTS);
		glColor3i(1, 1, 1);
		glVertex3fv(&focus.x);
		glEnd();
	}
#endif
    
	NSArray *props = [container sortedPropsForCamera:self];
	
	for(self.exposureIndex=0; self.exposureIndex<self.exposures ; ++self.exposureIndex)
		[props makeObjectsPerformSelector:@selector(paintForCamera:) withObject:self];
	
	[drawDelegate paintForCamera:self];
	
	glPopMatrix();
	
	if(options.rateOn)
		[self drawFramerate:start];
}

- (void)logCameraState {
    NSLog(@"Settings: %@", BACameraOptionsToString(options));
    NSLog(@"Out of date: %@", BACameraOptionsToString(changes));
}

- (void)logGLState {
    
#define STRING(bool) ((bool)?@"YES":@"NO")
    
    GLboolean lightingOn;
    GLboolean cullingOn;
    GLboolean depthOn;
    GLint polygonModes[2];
    
    CGLContextObj cglContext = CGLGetCurrentContext();
    
    CGLLockContext(cglContext);
    
    glGetBooleanv(GL_LIGHTING, &lightingOn);
    glGetBooleanv(GL_CULL_FACE, &cullingOn);
    glGetBooleanv(GL_DEPTH_TEST, &depthOn);
    glGetIntegerv(GL_POLYGON_MODE, polygonModes);
    
    CGLUnlockContext(cglContext);
    
    NSLog(@"Lighting:   %@", STRING(lightingOn));
    NSLog(@"Cull face:  %@", STRING(cullingOn));
    NSLog(@"Depth test: %@", STRING(depthOn));
    NSLog(@"Front mode: %@", BAStringForPolygonMode(polygonModes[0]));
    NSLog(@"Back mode:  %@", BAStringForPolygonMode(polygonModes[1]));
}

#pragma mark - Private Helpers

- (void)paintBlur {
    
    BOOL reEnableLighting = self.lightsOn;
    BOOL reEnableDepth = self.depthOn;
    
    self.lightsOn = NO;
    self.depthOn = NO;
    
    glMatrixMode (GL_MODELVIEW);
    glPushMatrix ();
    glLoadIdentity ();
    glMatrixMode (GL_PROJECTION);
    glPushMatrix ();
    glLoadIdentity ();
    
    glBegin (GL_QUADS);
    glColor4f(bgColor.c.r, bgColor.c.g, bgColor.c.b, 1-blur);
    glVertex3i (-1, -1, -1);
    glVertex3i (1, -1, 0-1);
    glVertex3i (1, 1, -1);
    glVertex3i (-1, 1, -1);
    glEnd ();
    
    glPopMatrix ();
    glMatrixMode (GL_MODELVIEW);
    glPopMatrix ();
    
    glClear(GL_DEPTH_BUFFER_BIT);
    
    if(reEnableLighting)
        self.lightsOn = YES;
    if(reEnableDepth)
        self.depthOn = YES;
}

@end
