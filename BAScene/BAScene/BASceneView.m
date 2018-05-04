//
//  BASceneView.m
//  BAScene
//
//  Created by Brent Gulanowski on 11/10/08.
//  Copyright (c) 2008-2014 Bored Astronaut. All rights reserved.
//

#import <BAScene/BASceneView.h>

#import <BAScene/BACamera+Creation.h>
#import <BAScene/BASceneConstants.h>

#import "BASceneOpenGL.h"

CVReturn BASceneViewDisplayLink(CVDisplayLinkRef displayLink,
                                const CVTimeStamp *inNow,
                                const CVTimeStamp *inOutputTime,
                                CVOptionFlags flagsIn,
                                CVOptionFlags *flagsOut,
                                void *displayLinkContext);

@interface BASceneView ()
- (void)captureScene;
- (void)processKeys:(NSString *)characters up:(BOOL)up;
- (void)mouseLook;
@end



@implementation BASceneView

@synthesize camera, nearZ, farZ, movementRate, trackMouse;
@synthesize drawInBackground=_drawInBackground;

#pragma mark - Private

CVReturn BASceneViewDisplayLink(CVDisplayLinkRef displayLink,
								const CVTimeStamp *inNow,
								const CVTimeStamp *inOutputTime,
								CVOptionFlags flagsIn,
								CVOptionFlags *flagsOut,
								void *sceneView) {
    
    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    [(BASceneView *)sceneView captureScene];
    [pool drain];
    
    return kCVReturnSuccess;
}

- (void)updateDisplayLinkScreen {
    
    CGLContextObj cglContext = [[self openGLContext] CGLContextObj];
    CGLPixelFormatObj cglPixelFormat = [[self pixelFormat] CGLPixelFormatObj];
        
    CVDisplayLinkSetCurrentCGDisplayFromOpenGLContext(displayLink, cglContext, cglPixelFormat);
}

- (void)BASceneView_common_init {
    
    if(nil != self) {
        
        GLint swapInt = 1;
        [[self openGLContext] setValues:&swapInt forParameter:NSOpenGLCPSwapInterval];
        
		self.nearZ = 2;
		self.farZ = 1024;
		self.movementRate = 5;
        self.drawInBackground = YES;
        
		Class cameraClass = [[self class] cameraClass];
		
		if(!cameraClass)
			cameraClass = [BACamera classForGLContext:[self openGLContext]];
		
		[self setCamera:[[[cameraClass alloc] init] autorelease]];
        
        [[self openGLContext] makeCurrentContext];
        [camera setup];
	}
}

- (void)captureScene {
    
    CGLContextObj cglContext = [[self openGLContext] CGLContextObj];
    
    CGLLockContext(cglContext);
    CGLSetCurrentContext(cglContext);

//    BOOL oldBlurOn = self.camera.blurOn;
//
//    if([self inLiveResize])
//        self.camera.blurOn=NO;
    [camera capture];
//    self.camera.blurOn=oldBlurOn;
    
    CGLFlushDrawable(cglContext);
    CGLUnlockContext(cglContext);
}

- (void)startDrawTimer {
	if(drawTimer || displayLink)
		return;
	drawTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
	dispatch_source_set_timer(drawTimer, dispatch_time(DISPATCH_TIME_NOW, 0), NSEC_PER_SEC/30.f, NSEC_PER_USEC/10000);
	dispatch_source_set_event_handler(drawTimer, ^{
		[self setNeedsDisplay:YES];
	});
	dispatch_resume(drawTimer);
}

- (void)cancelDrawTimer {
	if(!drawTimer)
		return;
	dispatch_source_cancel(drawTimer);
	dispatch_release(drawTimer);
	drawTimer = NULL;
}


#pragma mark - Accessors

- (void)setMovementRate:(GLfloat)rate {
    movementRate = rate;
    diagRate = movementRate*M_SQRT1_2;
}


#pragma mark - NSObject

- (void)dealloc {
    [self disableDisplayLink];
    self.camera = nil;
    [super dealloc];
}

#pragma mark - NSView

- (void)display {
    if(!displayLink) {
        [super display];
    }
}

#pragma mark - NSResponder

- (BOOL)acceptsFirstResponder {
	return YES;
}

- (void)keyDown:(NSEvent *)theEvent {
	if([theEvent isARepeat])
		return;
	[self processKeys:[theEvent characters] up:NO];
	if(self.camera.moving)
		[self startDrawTimer];
}

- (void)keyUp:(NSEvent *)theEvent {
    [self processKeys:[theEvent characters] up:YES];
	if(!self.camera.moving)
		[self cancelDrawTimer];
}

-(void)mouseDown:(NSEvent *)theEvent {
	[self mouseLook];
}

-(void)rightMouseDown:(NSEvent *)theEvent {
    
    BOOL dragging = YES;
	
    while(dragging) {
		theEvent = [[self window] nextEventMatchingMask:NSRightMouseUpMask | NSRightMouseDraggedMask];
        if ([theEvent type] == NSEventTypeRightMouseDragged) {
            [self.camera translateX:[theEvent deltaX]*0.1f y:0.0f z:[theEvent deltaY]*0.1f];
            [self display];
        }
        else {
            dragging = NO;
        }
    }
}

-(void)otherMouseDown:(NSEvent *)theEvent {
    
    BOOL dragging = YES;

    while(dragging) {
		theEvent = [[self window] nextEventMatchingMask:NSOtherMouseUpMask | NSOtherMouseDraggedMask];
        if ([theEvent type] == NSOtherMouseDragged) {
            [self.camera translateX:[theEvent deltaX]*0.1f y:-[theEvent deltaY]*0.1f z:0.0f];
            [self display];
        }
        else {
			dragging = NO;
        }
    }
}

//-(void)mouseUp:(NSEvent *)theEvent {
//}

- (void)mouseMoved:(NSEvent *)theEvent {
    
    if(trackMouse) {
        NSPoint loc = [self convertPointFromBacking:[theEvent locationInWindow]];
//        if(fabs(mouseLocation.x - loc.x)>2 && fabs(mouseLocation.y-loc.y)>2) {
//            NSLog(@"Mouse at %@", NSStringFromPoint(loc));
//        }
        mouseLocation = loc;
        [self display];
    }
}

- (BOOL)resignFirstResponder {
	[self.camera stop];
	return YES;
}


#pragma mark - NSView

- (id)initWithFrame:(NSRect)frame {

	NSOpenGLPixelFormatAttribute pixelAttributes[] = {
		NSOpenGLPFADoubleBuffer,
		NSOpenGLPFAAccelerated,
		NSOpenGLPFAColorSize, 32,
		NSOpenGLPFADepthSize, 32,
		NSOpenGLPFASampleBuffers, 1,
		NSOpenGLPFASamples, 4,
		NSOpenGLPFAAccumSize, 16,
		0
	};		

	return [self initWithFrame:frame
                   pixelFormat:[[[NSOpenGLPixelFormat alloc] initWithAttributes:pixelAttributes] autorelease]];
}

- (void)drawRect:(NSRect)rect {
    if(!displayLink)
        [self captureScene];
}

- (void)reshape {
	   
    CGLContextObj cglContext = [[self openGLContext] CGLContextObj];
    
    CGLLockContext(cglContext);
    CGLSetCurrentContext(cglContext);
    
	NSRect bounds = [self bounds];
    GLfloat aspectRatio = bounds.size.width/bounds.size.height;
	GLfloat length = nearZ * 2.0f/3.0f;

    glViewport( 0, 0, bounds.size.width, bounds.size.height );
    
    glMatrixMode( GL_PROJECTION );
    glLoadIdentity();
	glFrustum( -length*aspectRatio, length*aspectRatio, -length, length, nearZ, farZ );
	
    CGLUpdateContext(cglContext);
    CGLUnlockContext(cglContext);
}

- (void)viewWillMoveToWindow:(NSWindow *)window {
    
	if(window) {
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(windowDidBecomeMain:)
													 name:NSWindowDidBecomeMainNotification
												   object:window];
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(windowDidResignMain:)
													 name:NSWindowDidResignMainNotification
												   object:window];		
	}
	else
		[[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:[self window]];
}


#pragma mark - NSOpenGLView
- (id)initWithFrame:(NSRect)frameRect pixelFormat:(NSOpenGLPixelFormat *)format {
    self = [super initWithFrame:frameRect pixelFormat:format];
    if(self)
        [self BASceneView_common_init];
    return self;
}


#pragma mark NSNibAwaking
- (void)awakeFromNib {
	[[self window] setAcceptsMouseMovedEvents:YES];
}


#pragma mark - NSCoding
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self)
        [self BASceneView_common_init];
    return self;
}


#pragma mark - Input Handlers

- (void)processKeys:(NSString *)characters up:(BOOL)up {
	
    NSUInteger len = [characters length];
	BOOL forward = NO;
	BOOL back = NO;
	BOOL left = NO;
	BOOL right = NO;
	
	for(NSUInteger i=0; i<len; ++i) {
		switch ([characters characterAtIndex:i]) {
			case 's':
				back = YES;
				forward = NO;
				break;
			case 'w':
				forward = YES;
				back = NO;
				break;
			case 'a':
				left = YES;
				right = NO;
				break;
			case 'd':
				right = YES;
				left = NO;
				break;
			default:
				break;
		}
	}
	if(up) {
		if(forward || back)
			[camera setZRate:0];
		 if(left || right)
			[camera setXRate:0];
	}
	else {
		if(forward) {
			if(left) {
				[camera setZRate:-diagRate];
				[camera setXRate:-diagRate];
			}
			else if(right) {
				[camera setZRate:-diagRate];
				[camera setXRate:diagRate];
			}
			else {
				[camera setZRate:-movementRate];
			}
		}
		else if(back) {
			if(left) {
				[camera setZRate:diagRate];
				[camera setXRate:-diagRate];
			}
			else if(right) {
				[camera setZRate:diagRate];
				[camera setXRate:diagRate];
			}
			else {
				[camera setZRate:movementRate];
			}
		}
		else if(left)
			[camera setXRate:-movementRate];
		else if(right)
			[camera setXRate:movementRate];
	}
}

- (void)mouseLook {
	
    BOOL dragging = YES;
	NSWindow *window = [self window];
    
    while(dragging) {
		static NSUInteger eventMask = NSLeftMouseUpMask | NSLeftMouseDraggedMask | NSKeyDownMask | NSKeyUpMask;
		NSEvent *event = [window nextEventMatchingMask:eventMask];
		
		switch ([event type]) {
			case NSKeyDown:
				[self keyDown:event];
				break;
			case NSKeyUp:
				[self keyUp:event];
				break;
			case NSLeftMouseUp:
				dragging = NO;
				break;
			case NSEventTypeLeftMouseDragged:
				[self.camera rotateX:[event deltaY]*0.4 y:[event deltaX]*0.3];
                [self display];
				break;
            default:
                break;
		}
    }
}


#pragma mark - Notifications

- (void)windowDidBecomeMain:(NSNotification *)notif {
    if(!_drawInBackground && displayLink)
        CVDisplayLinkStart(displayLink);
}

- (void)windowDidResignMain:(NSNotification *)notif {
    if(!_drawInBackground && displayLink)
        CVDisplayLinkStop(displayLink);
}

- (void)windowChangedScreen:(NSNotification*)inNotification {
    [self updateDisplayLinkScreen];
}


#pragma mark - New Facilities

- (void)enableDisplayLink {
    if(displayLink)
        return;
    CVDisplayLinkCreateWithActiveCGDisplays(&displayLink);
    CVDisplayLinkSetOutputCallback(displayLink, BASceneViewDisplayLink, self);
    [self updateDisplayLinkScreen];
    CVDisplayLinkStart(displayLink);
}

- (void)disableDisplayLink {
    if(!displayLink)
        return;
    CVDisplayLinkRelease(displayLink), displayLink = NULL;
}

static Class gCameraClass = nil;

+ (void)setCameraClass:(Class)cameraClass {
	gCameraClass = cameraClass;
}

+ (Class)cameraClass {
	return gCameraClass;
}

@end
