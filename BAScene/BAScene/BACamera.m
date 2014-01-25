//
//  BACamera.m
//  BAScene
//
//  Created by Brent Gulanowski on 11/10/08.
//  Copyright (c) 2008-2014 Bored Astronaut. All rights reserved.
//

#import <BAScene/BACamera.h>

#import <BAScene/BASceneUtilities.h>

#import <math.h>

#if TARGET_OS_IPHONE
#import <BAScene/BACamera+EAGLCreation.h>
#else
#import <BAScene/BACamera+Creation.h>
#endif

NSString *BAStringForPolygonMode(BAPolygonMode mode) {
    switch (mode) {
        case BAPolygonModePoint: return @"Point"; break;
        case BAPolygonModeLine:  return @"Line";  break;
        case BAPolygonModeFill:
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

    [optionNames addObject:[NSString stringWithFormat:@"FRONT FACE:%@", BAStringForPolygonMode(options.frontMode)]];
    [optionNames addObject:[NSString stringWithFormat:@"BACK FACE:%@", BAStringForPolygonMode(options.backMode)]];
	
    return [optionNames componentsJoinedByString:@", "];
}


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
	if([self isMemberOfClass:[BACamera class]]) {
		SEL selector;
#if TARGET_OS_IPHONE
		selector = @selector(cameraForEAGLContext:);
#else
		selector = @selector(cameraForGLContext:);
#endif
		NSLog(@"BACamera is an abstract class. Create cameras with %@", NSStringFromSelector(selector));
	}
	if(self) {
        matrix = (BAMatrix4x4f)BAIdentityMatrix4x4f;

		self.focus = BAMakePoint4f(0, 0, 0, 0);
		self.bgColor = BAMakeColorf(0, 0, 0.1f, 1.0f);
		self.lightColor = BAMakeColorf(0.5f, 0.5f, 0.5f, 1.0f);
		self.lightShine = BAMakeColorf(0.8f, 0.8f, 0.8f, 1.0f);
		self.lightLoc = BAMakeLocationf(0, 0, 0, 1);
		self.frontMode = self.backMode = BAPolygonModeFill;
		self.exposures = 1;
		
		self.lightsOn = YES;
        self.cullingOn = YES;
        self.depthOn = YES;
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

- (BAPolygonMode)frontMode {
    return options.frontMode;
}

- (void)setFrontMode:(BAPolygonMode)frontMode {
    options.frontMode = frontMode;
    changes.frontMode = 1;
}

- (BAPolygonMode)backMode {
    return options.backMode;
}

- (void)setBackMode:(BAPolygonMode)backMode {
    options.backMode = backMode;
    changes.backMode = 1;
}

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

- (void)setBlur:(GLfloat)val {
    if(val > 1 || val < 0)
        blur = 0;
    else
        blur = val;
}

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

- (BOOL)isMoving {
	return xRate || yRate || zRate || xRotRate || yRotRate || zRotRate;
}

#pragma mark - BACamera

- (NSString *)matrixDescription {
    return BAStringFromMatrix4x4f(matrix);
}

- (void)translateX:(GLfloat)dx y:(GLfloat)dy z:(GLfloat)dz {
    matrix = BAMultiplyMatrix4x4f(BATranslationMatrix4x4f(BAMakePointf(-dx, -dy, -dz)), matrix);
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
	NSLog(@"Unimplemented method %@", NSStringFromSelector(_cmd));
}

- (void)updateViewPortWithSize:(CGSize)size {
	NSLog(@"Unimplemented method %@", NSStringFromSelector(_cmd));
}

- (void)applyViewTransform:(BAMatrix4x4f * const)transform {
	NSLog(@"Unimplemented method %@", NSStringFromSelector(_cmd));
}

- (void)submitMeshWithVertices:(GLfloat)vertices hasColors:(BOOL)hasColors hasNormals:(BOOL)hasNormals {
	NSLog(@"Unimplemented method %@", NSStringFromSelector(_cmd));
}

- (void)update:(NSTimeInterval)interval {
    
    // All the rates are units per second; update the postion and orientation in light of the change
    if(!interval || !self.moving)
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
	NSLog(@"Unimplemented method %@", NSStringFromSelector(_cmd));
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
	NSLog(@"Unimplemented method %@", NSStringFromSelector(_cmd));
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
	NSLog(@"Unimplemented method %@", NSStringFromSelector(_cmd));
}

- (void)logGLState {
	NSLog(@"Unimplemented method %@", NSStringFromSelector(_cmd));
}

@end
