//
//  BATexture.h
//  BAScene (from Ceed)
//
//  Created by Brent Gulanowski on 10-12-30.
//  Copyright 2010 Bored Astronaut. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <BAScene/BASceneTypes.h>

#if ! TARGET_OS_IPHONE

@interface NSImage (BATextureCreation)
- (NSBitmapImageRep *)textureBitmap;
@end

#endif


@interface BATexture : NSObject {
@private
	BASizei size;
    GLuint name;  
	GLenum minFilter;
	GLenum magFilter;
	GLenum mode;
	GLenum type;
}

@property (readonly) BASizei size;
@property (assign) GLenum minFilter;
@property (assign) GLenum magFilter;
@property (assign) GLenum mode;
@property (assign) GLenum type;

- (void)configureParameters;

- (void)updateWithData:(NSData *)data region:(BARegioni)region;
- (void)updateWithSubImage:(NSImage *)image location:(BALocationi)location;
- (void)updateTexelAtX:(GLuint)x y:(GLuint)y color:(BAColori)color;

+ (BATexture *)textureWithWidth:(GLuint)w height:(GLuint)h depth:(GLuint)d data:(NSData *)data;
+ (BATexture *)textureWithWidth:(GLuint)w height:(GLuint)h depth:(GLuint)d color:(BAColori)color;
+ (BATexture *)randomTextureWithWidth:(GLuint)w height:(GLuint)h;
+ (BATexture *)gradientTextureWithWidth:(GLuint)w height:(GLuint)h;
#if ! TARGET_OS_IPHONE
+ (BATexture *)textureWithBitmap:(NSBitmapImageRep *)bitmap;
+ (BATexture *)textureWithImage:(NSImage *)image;
+ (BATexture *)textureWithFile:(NSString *)path;
+ (BATexture *)textureNamed:(NSString *)imageName;
#endif

@end
