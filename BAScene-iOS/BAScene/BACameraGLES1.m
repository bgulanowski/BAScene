//
//  BACameraGLES1.m
//  BAScene-iOS
//
//  Created by Brent Gulanowski on 12/2/2013.
//  Copyright (c) 2013 Marketcircle Inc. All rights reserved.
//

#import <BAScene/BACameraGLES1.h>

#import <BAScene/BASceneUtilities.h>

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@implementation BACameraGLES1

- (void)setup {
    
	glDepthFunc(GL_LESS);
	glBlendFunc(GL_SRC_ALPHA,  GL_ONE_MINUS_SRC_ALPHA);
	glEnable(GL_BLEND);
	glShadeModel(GL_SMOOTH);
	glLightModelf(GL_LIGHT_MODEL_TWO_SIDE, 1.0);
	glEnable(GL_COLOR_MATERIAL);
	
	GLfloat diffuse[4]  = { 0.5f, 0.5f, 0.5f, 1.0f};
    
	glLightfv(GL_LIGHT0, GL_DIFFUSE, diffuse);
	glEnable(GL_LIGHT0);
    
	glEnable(GL_NORMALIZE);
}

- (void)updateGLState {
    if(changes.lightsOn) options.lightsOn ? glEnable(GL_LIGHTING)   : glDisable(GL_LIGHTING);
    if(changes.cullOn)   options.cullOn   ? glEnable(GL_CULL_FACE)  : glDisable(GL_CULL_FACE);
    if(changes.depthOn)  options.depthOn  ? glEnable(GL_DEPTH_TEST) : glDisable(GL_DEPTH_TEST);
    
    if(colorChanges.background) glClearColor(bgColor.c.r, bgColor.c.g, bgColor.c.b, 1.0f);
    
    if(colorChanges.lightLoc)   glLightfv(GL_LIGHT0, GL_POSITION,  lightLoc.i);
    if(colorChanges.light) 	    glLightfv(GL_LIGHT0, GL_AMBIENT,   lightColor.i);
    if(colorChanges.shine)      glLightfv(GL_LIGHT0, GL_SPECULAR, lightShine.i);
    
    changes = (BACameraOptions) {};
    colorChanges = (BACameraColorChanges) {};
}

- (void)capture {
	
	NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
	
    [self updateGLState];
    
	glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
    
	glMatrixMode(GL_MODELVIEW);
    glPushMatrix();
    glLoadIdentity();
    
    BAMatrix4x4f m;
    
    if(options.revolveOn)
        m = BAMatrixFocus(self.location, self.focus);
    else
        m = matrix;
    
    glLoadMatrixf(m.i);
		
	NSArray *props = [container sortedPropsForCamera:self];
	
	for(self.exposureIndex=0; self.exposureIndex<self.exposures ; ++self.exposureIndex)
		[props makeObjectsPerformSelector:@selector(paintForCamera:) withObject:self];
	
	[drawDelegate paintForCamera:self];
	
	glPopMatrix();
	
	if(options.rateOn) {
		
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
}

- (void)updateViewPortWithSize:(CGSize)size {
	glViewport(0, 0, size.width, size.height);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glFrustumf(-1.0f, 1.0f, -size.height/size.width, size.height/size.width, 5.0f, 50.0f);
}

- (void)applyViewTransform:(BAMatrix4x4f *const)transform {
	glMultMatrixf( transform->i );
}

- (void)submitMeshWithVertices:(GLfloat)vertices hasColors:(BOOL)hasColors hasNormals:(BOOL)hasNormals {
}

@end
