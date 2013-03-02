//
//  BACamera.h
//  BAScene
//
//  Created by Brent Gulanowski on 11/10/08.
//  Copyright 2008 Bored Astronaut. All rights reserved.
//


#import <BAScene/BASceneTypes.h>


/*
 * BACamera depends on a drawDelegate object which returns a propContainer, which in turn provides props, of which a representation can be drawn.
 * (Props are thus "drawable" but not in the same sense as a drawable surface, which can be drawn upon.) 
 * 
 */


typedef enum {
    BAPolygonModeFill = 0,
    BAPolygonModeLine = 1,
    BAPolygonModePoint = 2
} BAPolygonMode;


typedef struct BACameraOptionFlags {
    // Utility options
    unsigned int testOn:1;
    unsigned int rateOn:1;
    unsigned int showOriginOn:1;
    unsigned int showFocusOn:1;
    unsigned int revolveOn:1;
    unsigned int blurOn:1;
    unsigned int reserved:10;
    // OpenGL options
    unsigned int lightsOn:1;
    unsigned int cullOn:1;
    unsigned int depthOn:1;
    BAPolygonMode frontMode:2;
    BAPolygonMode backMode:2;
    unsigned int reserved2:9;
} BACameraOptions;

typedef struct BACameraValueChanges {
    unsigned int background:1;
    unsigned int lightLoc:1;
    unsigned int light:1;
    unsigned int shine:1;
    unsigned int reserved:12;
} BACameraColorChanges;


@class BACamera, BAColor;

@protocol BAPropContainer<NSObject>
- (NSArray *)sortedPropsForCamera:(BACamera *)camera;
@end


@protocol BAVisible<NSObject>
- (void)paintForCamera:(BACamera *)camera;
@optional
- (void)setColor:(BAColor *)aColor;
- (BALocationf)location;
@end


@protocol BACameraDrawDelegate<NSObject>
- (void)paintForCamera:(BACamera *)camera;
- (id<BAPropContainer>)propContainer;
@end


@class BAColor;


@interface BACamera : NSObject {

	id<BACameraDrawDelegate> drawDelegate;
    id<BAPropContainer> container;
    
	NSUInteger exposures;
	NSUInteger exposureIndex;

    // TODO: extract position info to separate animatable object
	BAMatrix4x4f matrix;
    	
	GLfloat xRot;
	GLfloat yRot;
	GLfloat zRot;
	
	GLfloat xRate;
	GLfloat yRate;
	GLfloat zRate;

	GLfloat xRotRate;
	GLfloat yRotRate;
	GLfloat zRotRate;

	BAPointf focus;
    
	BAColorf bgColor;
	BAColorf lightColor;
	BAColorf lightShine;
    
    BACameraColorChanges colorChanges;

	BALocationf lightLoc;
	
	GLfloat blur;

	GLuint blurBuffer;
	GLuint blurTexture;
    
    BACameraOptions options;
    BACameraOptions changes;

	NSTimeInterval *renderTimes;
	NSUInteger timeIndex;
	GLfloat frameRate;
}


@property (nonatomic, assign) id<BACameraDrawDelegate> drawDelegate;

@property (nonatomic) NSUInteger exposures;
@property (nonatomic) NSUInteger exposureIndex; // undefined if not capturing

@property (nonatomic) GLfloat xLoc;
@property (nonatomic) GLfloat yLoc;
@property (nonatomic) GLfloat zLoc;

@property (nonatomic) GLfloat xRot;
@property (nonatomic) GLfloat yRot;
@property (nonatomic) GLfloat zRot;

@property(nonatomic,assign) GLfloat xRate;
@property(nonatomic,assign) GLfloat yRate;
@property(nonatomic,assign) GLfloat zRate;

@property(nonatomic,assign) GLfloat xRotRate;
@property(nonatomic,assign) GLfloat yRotRate;
@property(nonatomic,assign) GLfloat zRotRate;

// GL_POINT, GL_LINE or GL_FILL
@property (nonatomic) GLenum frontMode;
@property (nonatomic) GLenum backMode;

@property (nonatomic) BAPointf focus;
@property (nonatomic) GLfloat blur;

@property (nonatomic) BAColorf bgColor;
@property (nonatomic) BAColorf lightColor;
@property (nonatomic) BAColorf lightShine;

#if ! TARGET_OS_IPHONE
@property (nonatomic, assign) NSColor *nsbgColor;
@property (nonatomic, assign) NSColor *nslColor;
@property (nonatomic, assign) NSColor *nslShine;
#endif

@property (nonatomic) BALocationf lightLoc;

@property (nonatomic, getter = isTestOn) BOOL testOn;
@property (nonatomic, getter = isRateOn) BOOL rateOn;
@property (nonatomic, getter = isShowOriginOn) BOOL showOriginOn;
@property (nonatomic, getter = isShowFocusOn) BOOL showFocusOn;
@property (nonatomic, getter = isRevolveOn) BOOL revolveOn;
@property (nonatomic, getter = areLightsOn) BOOL lightsOn;
@property (nonatomic, getter = isCullingOn) BOOL cullingOn;
@property (nonatomic, getter = isDepthOn) BOOL depthOn;
#if ! TARGET_OS_IPHONE
@property (nonatomic, getter = isBlurOn) BOOL blurOn;
#endif

@property (nonatomic, getter = isFrontLineModeOn) BOOL frontLineModeOn;
@property (nonatomic, getter = isBackLineModeOn) BOOL backLineModeOn;

@property(nonatomic) GLfloat frameRate;

@property (nonatomic) GLfloat lightX;
@property (nonatomic) GLfloat lightY;
@property (nonatomic) GLfloat lightZ;

@property (readonly) BAPoint4f location;

// move relative to the current position in absolute coordinates
- (void)translateX:(GLfloat)dx y:(GLfloat)dy z:(GLfloat)dz;

// rotate relative to the current rotation in absolute values
-(void)rotateX:(GLfloat)x y:(GLfloat)y;

- (void)setup;
- (void)update:(NSTimeInterval)interval;
- (void)capture;
- (void)stop;

@end

