//
//  BACamera.m
//  BAScene
//
//  Created by Brent Gulanowski on 11/10/08.
//  Copyright 2008 Bored Astronaut. All rights reserved.
//

#import "BACamera.h"

#import "BASceneUtilities.h"

#import <math.h>


#if ! TARGET_OS_IPHONE
#import <OpenGL/glu.h>
#endif


static inline GLenum BAPolygonModeToGL(BAPolygonMode mode) {
    
    switch (mode) {
        case BAPolygonModePoint: return GL_POINT; break;
        case BAPolygonModeLine:  return GL_LINE;  break;
        case BAPolygonModeFill:
        default:                 return GL_FILL;  break;
    }
}

static inline BAPolygonMode BAPolygonModeFromGL(GLenum mode) {
    switch (mode) {
        case GL_POINT: return BAPolygonModePoint; break;
        case GL_LINE:  return BAPolygonModeLine;  break;
        case GL_FILL:
        default:       return BAPolygonModeFill;  break;
    }
}

static inline NSString *BAStringForGLPolygonMode(GLenum mode) {
    switch (mode) {
        case GL_POINT: return @"Point"; break;
        case GL_LINE:  return @"Line";  break;
        case GL_FILL:
        default:       return @"Fill";  break;
    }    
}

NSString *BACameraOptionsToString(BACameraOptions options) {
    NSMutableArray *optionNames = [NSMutableArray array];
    if(options.testOn) [optionNames addObject:@"TEST"];
    if(options.rateOn) [optionNames addObject:@"RATE"];
    if(options.showOriginOn) [optionNames addObject:@"SHOW_ORIGIN"];
    if(options.showFocusOn) [optionNames addObject:@"SHOW_FOCUS"];
    if(options.revolveOn) [optionNames addObject:@"REVOLVE"];
    if(options.blurOn) [optionNames addObject:@"BLUR"];
    if(options.lightsOn) [optionNames addObject:@"LIGHTS"];
    if(options.cullOn) [optionNames addObject:@"CULL"];
    if(options.depthOn) [optionNames addObject:@"DEPTH"];
    
    [optionNames addObject:[NSString stringWithFormat:@"FRONT FACE:%@", BAStringForGLPolygonMode(BAPolygonModeToGL(options.frontMode))]];
    [optionNames addObject:[NSString stringWithFormat:@"BACK FACE:%@", BAStringForGLPolygonMode(BAPolygonModeToGL(options.backMode))]];
    
    return [optionNames componentsJoinedByString:@", "];
}


void compareMatrices(BAMatrix4x4f a, BAMatrix4x4f b);


@interface BACamera ()
@property (nonatomic, retain) id<BAPropContainer>container;
@end


@implementation BACamera

@synthesize drawDelegate, container, exposures, exposureIndex;
@synthesize xRot, yRot, zRot;
@synthesize xRate, yRate, zRate, xRotRate, yRotRate, zRotRate;
@synthesize focus, blur;
@synthesize bgColor, lightColor, lightShine, lightLoc;
@synthesize frameRate;


#pragma mark NSObject

- (void)dealloc {
    self.drawDelegate = nil;
    [super dealloc];
}

- (id)init {
	self = [super init];
	if(self) {
		self.focus = BAMakePointf(0, 0, 0);
		self.bgColor = BAMakeColorf(0, 0, 0.1f, 1.0f);
		self.lightColor = BAMakeColorf(1.f, 1.f, 1.f, 1.f);
		self.exposures = 1;
        matrix = (BAMatrix4x4f)BAIdentityMatrix4x4f;
        self.lightsOn = YES;
        self.cullingOn = YES;
        self.depthOn = YES;
        self.frontMode = self.backMode = BAPolygonModeToGL(BAPolygonModeFill);
	}
	return self;
}

+ (NSSet *)keyPathsForValuesAffectingNsbgColor {
	return [NSSet setWithObject:@"bgColor"];
}


#pragma mark - Accessors

- (void)setDrawDelegate:(id<BACameraDrawDelegate>)delegate {
    if(drawDelegate != delegate) {
        drawDelegate = delegate;
        self.container = [drawDelegate propContainer];
    }
}

- (GLfloat)xLoc { return -matrix.i[12]; }
- (void)setXLoc:(GLfloat)x { matrix.i[12] = -x; }

- (GLfloat)yLoc { return -matrix.i[13]; }
- (void)setYLoc:(GLfloat)y { matrix.i[13] = -y; }

- (GLfloat)zLoc { return -matrix.i[14]; }
- (void)setZLoc:(GLfloat)z { matrix.i[14] = -z; }

- (void)setXRot:(GLfloat)value {
	if(value > 180.0)
		value -= 360.0;
	else if(value < -180)
		value += 360.0;
	xRot = value;
}

- (void)setYRot:(GLfloat)value {
	if(value > 180.0)
		value -= 360.0;
	else if(value < -180)
		value += 360.0;
	yRot = value;
}

- (void)setZRot:(GLfloat)value {
	if(value > 360.0)
		value -= 360.0;
	else if(value < 0)
		value += 360.0;
	zRot = value;
}

- (BOOL)areLightsOn {
    return options.lightsOn;
}

- (BOOL)isLightsOn {
    return options.lightsOn;
}

- (void)setLightsOn:(BOOL)flag {
    options.lightsOn = flag;
    changes.lightsOn = YES;
}

- (BOOL)isCullingOn {
    return options.cullOn;
}

- (void)setCullingOn:(BOOL)flag {
    options.cullOn = flag;
    changes.cullOn = YES;
}

- (BOOL)isDepthOn {
    return options.depthOn;
}

- (void)setDepthOn:(BOOL)flag {
    options.depthOn = flag;
    changes.depthOn = YES;
}

- (BOOL)isShowOriginOn {
    return options.showOriginOn;
}

- (void)setShowOriginOn:(BOOL)flag {
    options.showOriginOn = flag;
    changes.showOriginOn = YES;
}

- (BOOL)isTestOn {
    return options.testOn;
}

- (void)setTestOn:(BOOL)testOn {
    options.testOn = testOn;
    changes.testOn = YES;
}

- (BOOL)isRateOn {
    return options.rateOn;
}

- (void)setRateOn:(BOOL)rateOn {
    options.rateOn = rateOn;
    changes.rateOn = YES;
    @synchronized(self) {
        if(options.rateOn && !renderTimes)
            renderTimes = malloc(sizeof(NSTimeInterval)*30);
        else if(!options.rateOn && renderTimes)
            free(renderTimes), renderTimes = NULL;
    }
}

- (BOOL)isRevolveOn {
    return options.revolveOn;
}

- (void)setRevolveOn:(BOOL)flag {
    options.revolveOn = flag;
    changes.revolveOn = YES;
}

- (BOOL)isShowFocusOn {
    return options.showFocusOn;
}

- (void)setShowFocusOn:(BOOL)showFocusOn {
    options.showFocusOn = showFocusOn;
    changes.showFocusOn = YES;
}

- (BOOL)isBlurOn {
    return options.blurOn;
}

- (void)setBlurOn:(BOOL)flag {
    options.blurOn = flag;
    changes.blurOn = YES;
}

- (GLenum)frontMode {
    return BAPolygonModeToGL(options.frontMode);
}

- (void)setFrontMode:(GLenum)frontMode {
    options.frontMode = BAPolygonModeFromGL(frontMode);
    changes.frontMode = 1;
}

- (GLenum)backMode {
    return BAPolygonModeToGL(options.backMode);
}

- (void)setBackMode:(GLenum)backMode {
    options.backMode = BAPolygonModeFromGL(backMode);
    changes.backMode = 1;
}

#if ! TARGET_OS_IPHONE
- (BOOL)isFrontLineModeOn {
    return options.frontMode == BAPolygonModeLine;
}

- (void)setFrontLineModeOn:(BOOL)flag {
    options.frontMode = flag ? BAPolygonModeLine : BAPolygonModeFill;
    changes.frontMode = 1;
}

- (BOOL)isBackLineModeOn {
    return options.backMode == BAPolygonModeLine;
}

- (void)setBackLineModeOn:(BOOL)flag {
    options.backMode = flag ? BAPolygonModeLine : BAPolygonModeFill;
    changes.backMode = 1;
}
#endif

- (void)setBgColor:(BAColorf)aColor {
    bgColor = aColor;
    colorChanges.background = YES;
}

- (void)setLightLoc:(BALocationf)location {
    lightLoc = location;
    colorChanges.lightLoc = YES;
}

- (void)setLightColor:(BAColorf)aColor {
	lightColor = aColor;
    colorChanges.light = YES;
}

- (void)setLightShine:(BAColorf)aColor {
	lightShine = aColor;
    colorChanges.shine = YES;
}

#if ! TARGET_OS_IPHONE && ! TARGET_IPHONE_SIMULATOR
- (NSColor *)nsbgColor {
	return [NSColor colorWithCalibratedRed:bgColor.c.r green:bgColor.c.g blue:bgColor.c.b alpha:bgColor.c.a];
}

- (void)setNsbgColor:(NSColor *)aColor {
	[self setBgColor:[aColor BAColorf]];
}

- (NSColor *)nslColor {
	return [NSColor colorWithCalibratedRed:lightColor.c.r green:lightColor.c.g blue:lightColor.c.b alpha:1];
}

- (void)setNslColor:(NSColor *)aColor {
	[self setLightColor:[aColor BAColorf]];
}

- (NSColor *)nslShine {
	return [NSColor colorWithCalibratedRed:lightShine.c.r green:lightShine.c.g blue:lightShine.c.b alpha:1];
}
- (void)setNslShine:(NSColor *)aColor {
	[self setLightShine:[aColor BAColorf]];
}
#endif

- (void)setBlur:(GLfloat)val {
	if(val > 1 || val < 0)
		blur = 0;
	else
		blur = val;
}

/*
- (void)setBlurOn:(BOOL)flag {
	if(flag && !blurBuffer) {
		glGenFramebuffers(1, &blurBuffer);
		glGenTextures(1, &blurTexture);
		glBindTexture(GL_TEXTURE_2D, blurTexture);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

		GLint viewport[4];
		glGetIntegerv(GL_VIEWPORT, viewport);

		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA8, viewport[2], viewport[3], 0, GL_RGBA, GL_UNSIGNED_BYTE, NULL);
	}
	blurOn = flag;
}
*/

- (void)setLightX:(GLfloat)lightX {
    lightLoc.p.x = lightX;
}

- (GLfloat)lightX {
    return lightLoc.p.x;
}

- (void)setLightY:(GLfloat)lightY {
    lightLoc.p.y = lightY;
}

- (BAPoint4f)location {
    BAPoint4f l = matrix.v[3];
    l.x *= -1; l.y *= -1;  l.z *= -1;
    return l;
}

- (GLfloat)lightY {
    return lightLoc.p.y;
}

- (void)setLightZ:(GLfloat)lightZ {
    lightLoc.p.z = lightZ;
}

- (GLfloat)lightZ {
    return lightLoc.p.z;
}


#pragma mark - BACamera

- (NSString *)matrixDescription {
	return BAStringFromMatrix4x4f(matrix);
}

- (void)translateX:(GLfloat)dx y:(GLfloat)dy z:(GLfloat)dz {
    matrix = BAMultiplyMatrix4x4f(BATranslationMatrix4x4f(BAMakePointf(-dx, -dy, -dz)), matrix);
}

void compareMatrices(BAMatrix4x4f a, BAMatrix4x4f b) {
	if(!BAEqualMatrices4x4f(a, b))
		NSLog(@"expected:\n%@\nactual:\n%@", BAStringFromMatrix4x4f(a), BAStringFromMatrix4x4f(b));
}

-(void)rotateX:(GLfloat)xDeg y:(GLfloat)yDeg {
	
 	if(xDeg + xRot > 90.f)
		xDeg = 90.0 - xRot;
	else if(xDeg + xRot < -90.f)
		xDeg = -(xRot + 90.f);
    
	BAMatrix4x4f m = BAXAxisRotationD4f(xRot+xDeg);
	
    m = BAMultiplyMatrix4x4f(m, BAYAxisRotationD4f(yDeg));
    m = BAMultiplyMatrix4x4f(m, BAXAxisRotationD4f(-xRot));
    matrix = BAMultiplyMatrix4x4f(m, matrix);
    
	self.xRot += xDeg;
	self.yRot += yDeg;
}

- (void)setup {

	glDepthFunc(GL_LESS);
	glBlendFunc(GL_SRC_ALPHA,  GL_ONE_MINUS_SRC_ALPHA);
	glEnable(GL_BLEND);
	glShadeModel(GL_SMOOTH);
	glLightModelf(GL_LIGHT_MODEL_TWO_SIDE, 1.0);
	glEnable(GL_COLOR_MATERIAL);
#if ! TARGET_OS_IPHONE
    glClearDepth(1.0);
	glColorMaterial(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE);
#endif
	
	self.lightColor = BAMakeColorf(0.5f, 0.5f, 0.5f, 1.0f);
	self.lightShine = BAMakeColorf(0.8f, 0.8f, 0.8f, 1.0f);
	
	BALocationf loc;
	
	loc.p = BAMakePoint4f(0, 0, 0, 1);
	self.lightLoc = loc;
	
	GLfloat diffuse[4]  = { 0.5f, 0.5f, 0.5f, 1.0f};

	glLightfv(GL_LIGHT0, GL_DIFFUSE, diffuse);
	glEnable(GL_LIGHT0);

#if 0
    GLfloat ambient[4] = { 0.2, 0.2, 0.2, 1.0f};
    GLfloat light7[4] = { 0, -1, 0, 0 };
	
	glLightfv(GL_LIGHT7, GL_POSITION, light7);

	glLightfv(GL_LIGHT7, GL_AMBIENT, ambient);
	glLightfv(GL_LIGHT7, GL_DIFFUSE, ambient);
	glEnable(GL_LIGHT7);
#endif
    
	glEnable(GL_NORMALIZE);
}

- (void)update:(NSTimeInterval)interval {
    
    // All the rates are units per second; update the postion and orientation in light of the change
    if(!interval || !(xRate || yRate || zRate || xRotRate || yRotRate || zRotRate))
        return;
    
    // These transformations may happen on background thread, so must avoid triggering KVO updates
    // KVO updates will be sent after the fact in -capture (which is on the main thread)
    [self translateX:xRate*interval y:yRate*interval z:zRate*interval];
    [self rotateX:xRotRate*interval y:yRotRate*interval];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self sendKeyValueUpdates];
    });
}

- (void)updateGLState {
    if(changes.lightsOn) options.lightsOn ? glEnable(GL_LIGHTING)   : glDisable(GL_LIGHTING);
    if(changes.cullOn)   options.cullOn   ? glEnable(GL_CULL_FACE)  : glDisable(GL_CULL_FACE);
    if(changes.depthOn)  options.depthOn  ? glEnable(GL_DEPTH_TEST) : glDisable(GL_DEPTH_TEST);
    
    if(changes.frontMode) glPolygonMode(GL_FRONT, self.frontMode);
    if(changes.backMode)  glPolygonMode(GL_BACK, self.backMode);
    
    if(colorChanges.background) glClearColor(bgColor.c.r, bgColor.c.g, bgColor.c.b, 1.0f);
    
    
    if(colorChanges.lightLoc)   glLightfv(GL_LIGHT0, GL_POSITION,  lightLoc.i);
    if(colorChanges.light) 	    glLightfv(GL_LIGHT0, GL_AMBIENT,   lightColor.i);
    if(colorChanges.shine)      glLightfv(GL_LIGHT0, GL_SPECULAR, lightShine.i);
    
    changes = (BACameraOptions) {};
    colorChanges = (BACameraColorChanges) {};
}

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

#define BASendKeyValueUpdates(key) \
do {\
[self willChangeValueForKey:key];\
[self didChangeValueForKey:key];\
} while(0)


- (void)sendKeyValueUpdates {
	if(xRate||yRate||zRate) {
		BASendKeyValueUpdates(@"xLoc");
		BASendKeyValueUpdates(@"yLoc");
		BASendKeyValueUpdates(@"zLoc");
	}
	if(xRotRate||yRotRate||zRotRate) {
		BASendKeyValueUpdates(@"xRot");
		BASendKeyValueUpdates(@"yRot");
		BASendKeyValueUpdates(@"zRot");
	}
}

- (void)capture {
	
	NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
	
    [self updateGLState];

#if ! TARGET_OS_IPHONE
	if (options.blurOn)
        [self paintBlur];
	else
#endif
		glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);

	glMatrixMode(GL_MODELVIEW);
#if ! TARGET_OS_IPHONE
	glRenderMode(GL_RENDER);
#endif
    
    glPushMatrix();
    glLoadIdentity();
    
    BAMatrix4x4f m;
        
    if(options.revolveOn) {
                
        BAPoint4f e = [self location];

        BAVector3 e3 = BAMakePointf(e.x, e.y, e.z);
        BAVector3 Z = BANormalizeVector3(e3);
        BAVector3 X = BANormalizeVector3(BACrossProductVectors3(BAMakePointf(0, 1, 0), Z));
        BAVector3 Y = BANormalizeVector3(BACrossProductVectors3(Z, X));
        
        m.v[0] = BAMakePoint4f(X.x, Y.x, Z.x, 0);
        m.v[1] = BAMakePoint4f(X.y, Y.y, Z.y, 0);
        m.v[2] = BAMakePoint4f(X.z, Y.z, Z.z, 0);
        m.v[3] = BAMakePoint4f(-BADotProductVectors3(X, e3), -BADotProductVectors3(Y, e3), -BADotProductVectors3(Z, e3), 1);
    }
    else
        m = matrix;
    
    glLoadMatrixf(m.i);

    
//	if(blurOn && blur > 0)
//		glAccum(GL_RETURN, blur);
/*
	{
		
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
*/	
#if ! TARGET_OS_IPHONE
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

//	if(blurOn && blur > 0) {
//		glAccum(GL_MULT, 0.6);
//		glAccum(GL_ACCUM, 0.4);
//	}
	
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
	
- (void)stop {
	self.xRate = 0;
	self.yRate = 0;
	self.zRate = 0;
	self.xRotRate = 0;
	self.yRotRate = 0;
	self.zRotRate = 0;
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
    NSLog(@"Front mode: %@", BAStringForGLPolygonMode(polygonModes[0]));
    NSLog(@"Back mode:  %@", BAStringForGLPolygonMode(polygonModes[1]));
}

@end
