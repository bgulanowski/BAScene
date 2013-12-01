//
//  BATexture.m
//  BAScene (from Ceed)
//
//  Created by Brent Gulanowski on 10-12-30.
//  Copyright 2010 Bored Astronaut. All rights reserved.
//

#import <BAScene/BATexture.h>

#import <BAScene/BASceneUtilities.h>

@implementation BATexture

@synthesize size, minFilter, magFilter, mode, type;

- (void)dealloc {
    glDeleteTextures(1, &name);
    [super dealloc];
}

- (id)initWithWidth:(GLuint)w height:(GLuint)h depth:(GLuint)d data:(NSData *)data {

	self = [super init];
	if(self) {
		
		NSAssert(d<2, @"Cannot support 3d textures yet");
		
#if TARGET_OS_IPHONE
        type = GL_TEXTURE_2D;
        magFilter = minFilter = GL_LINEAR_MIPMAP_LINEAR;

#else
		BOOL isPowerOfTwo = YES;
		NSUInteger i;
		
		for(i=1; isPowerOfTwo && i<w; i*=2);
		isPowerOfTwo = i == w;
		for(i=1; isPowerOfTwo && i<h; i*=2);
		isPowerOfTwo = i == h;
		
		if(isPowerOfTwo) {
			type = GL_TEXTURE_2D;
			magFilter = minFilter = GL_LINEAR_MIPMAP_LINEAR;
		}
		else {
			type = GL_TEXTURE_RECTANGLE_EXT;
			magFilter = minFilter = GL_LINEAR;
		}
#endif
		
		glGenTextures(1, &name);
		glBindTexture(type, name);
		glTexImage2D(type, 0, GL_RGBA, w, h, 0, GL_RGBA, GL_UNSIGNED_BYTE, [data bytes]);
		glGenerateMipmap(type);
		
		size = BAMakeSizei(w, h, d);
		mode = GL_REPLACE;
	}
	
	return self;
}

- (id)initWithWidth:(GLuint)w height:(GLuint)h depth:(GLuint)d color:(BAColori)color {
    
    NSData *data = nil;
    size_t bufferSize = w*h*d*4;
    GLubyte *bytes = malloc(sizeof(GLubyte)*bufferSize);
    
    for (NSUInteger i=0; i<bufferSize; i+=4) {
        bytes[i]   = color.i[0];
        bytes[i+1] = color.i[1];
        bytes[i+2] = color.i[2];
        bytes[i+3] = color.i[3];
    }
    
    data = [NSData dataWithBytesNoCopy:bytes length:bufferSize freeWhenDone:YES];

    return [self initWithWidth:w height:h depth:d data:data];
}

- (void)configureParameters {
	glBindTexture(type, name);
    glTexParameteri(type, GL_TEXTURE_MIN_FILTER, minFilter);
    glTexParameteri(type, GL_TEXTURE_MAG_FILTER, magFilter);
	glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, mode );
}

- (void)updateWithData:(NSData *)data region:(BARegioni)region {
    glTexSubImage2D(type, 0, (GLint)region.origin.p.x, (GLint)region.origin.p.y, (GLsizei)region.volume.s.w, (GLsizei)region.volume.s.h,
                    GL_RGBA, GL_UNSIGNED_BYTE, [data bytes]);
}

- (void)updateWithSubImage:(NSImage *)image location:(BALocationi)location {
    
    NSBitmapImageRep *bitmap = [image textureBitmap];
    NSData *data = [NSData dataWithBytesNoCopy:[bitmap bitmapData] length:[bitmap bytesPerRow] * [bitmap pixelsHigh] freeWhenDone:NO];
    BARegioni region;
    
    region.origin = location;
    region.volume.s = BAMakeSizei(image.size.width, image.size.height, 1);
    
    [self updateWithData:data region:region];
}

- (void)updateTexelAtX:(GLuint)x y:(GLuint)y color:(BAColori)color {
    glTexSubImage2D(type, 0, x, y, 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, (GLvoid *)&color);
}


+ (BATexture *)textureWithWidth:(GLuint)w height:(GLuint)h depth:(GLuint)d data:(NSData *)data {
	return [[[self alloc] initWithWidth:w height:h depth:d data:data] autorelease];
}

+ (BATexture *)textureWithWidth:(GLuint)w height:(GLuint)h depth:(GLuint)d color:(BAColori)color {
    return [[[self alloc] initWithWidth:w height:h depth:d color:color] autorelease];
}

+ (NSData *)randomTextureDataWithWidth:(GLuint)w height:(GLuint)h {
	
	GLuint arr_size = w*h*3;
	GLfloat *bytes = malloc(sizeof(GLfloat)*arr_size);
	
	const GLfloat range = 1.0f/8.0f;
	
	// noise
	bytes[0] = BARandomGLfloatInRange(range, 1-range);
	bytes[1] = BARandomGLfloatInRange(range, 1-range);
	bytes[2] = BARandomGLfloatInRange(range, 1-range);
	for(int i=3; i<arr_size; i+=3) {
		bytes[i] = bytes[0] + (BARandomSignedness() * BARandomGLfloatInRange(0.0, range));
		bytes[i+1] = bytes[1] + (BARandomSignedness() * BARandomGLfloatInRange(0.0, range));
		bytes[i+2] = bytes[2] + (BARandomSignedness() * BARandomGLfloatInRange(0.0, range));
	}
	
	return [[[NSData alloc] initWithBytesNoCopy:bytes length:arr_size freeWhenDone:YES] autorelease];
}

+ (NSData *)gradientTextureDataWithWidth:(GLuint)w height:(GLuint)h {
	
	GLuint arr_size = w*h*3;
	GLfloat *bytes = malloc(sizeof(GLfloat)*arr_size);
	GLfloat inc = 1.0f/(arr_size-1);
	
	// gradient
	for(int i=0; i<arr_size-1; ++i)
		bytes[i*3]=bytes[i*3+1]=bytes[i*3+2]=(GLfloat)i*inc;
	bytes[arr_size-3]=bytes[arr_size-2]=bytes[arr_size-1]=1.0f;

	return [[[NSData alloc] initWithBytesNoCopy:bytes length:arr_size freeWhenDone:YES] autorelease];
}

+ (BATexture *)randomTextureWithWidth:(GLuint)w height:(GLuint)h {
	return [self textureWithWidth:w height:h depth:0 data:[self randomTextureDataWithWidth:w height:h]];
}

+ (BATexture *)gradientTextureWithWidth:(GLuint)w height:(GLuint)h {
	return [self textureWithWidth:w height:h depth:0 data:[self gradientTextureDataWithWidth:w height:h]];
}

#if ! TARGET_OS_IPHONE
+ (BATexture *)textureWithBitmap:(NSBitmapImageRep *)bitmap {
	
	NSData *data = [NSData dataWithBytesNoCopy:[bitmap bitmapData] length:[bitmap bytesPerRow] * [bitmap pixelsHigh] freeWhenDone:NO];
	
	return [[[self alloc] initWithWidth:(GLuint)[bitmap pixelsWide] height:(GLuint)[bitmap pixelsHigh] depth:0 data:data] autorelease];
}

+ (BATexture *)textureWithImage:(NSImage *)image {
	return [self textureWithBitmap:[image textureBitmap]];
}

+ (BATexture *)textureWithFile:(NSString *)path {
	return [self textureWithImage:[[[NSImage alloc] initWithContentsOfFile:path] autorelease]];
}

+ (BATexture *)textureNamed:(NSString *)imageName {
	return [self textureWithImage:[NSImage imageNamed:imageName]];
}
#endif

@end

#if ! TARGET_OS_IPHONE
@implementation NSImage (BATextureCreation)

- (NSBitmapImageRep *)textureBitmap {
	
	NSBitmapImageRep* bitmap = nil;
    CGSize imgSize = NSSizeToCGSize([self size]);
	
	[self setFlipped:YES];
    [self lockFocus];
	bitmap = [[[NSBitmapImageRep alloc] initWithFocusedViewRect:NSMakeRect(0.0, 0.0, imgSize.width, imgSize.height)] autorelease];
	[self unlockFocus];
	
	return bitmap;
}

@end
#endif
