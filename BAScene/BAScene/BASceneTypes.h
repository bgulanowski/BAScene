//
//  BASceneTypes.h
//  BAScene
//
//  Created by Brent Gulanowski on 10-03-04.
//  Copyright 2010 Bored Astronaut. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef struct {
	GLfloat p; // point
	GLfloat d; // distance
} BARangef;

typedef struct {
	NSInteger x;
	NSInteger y;
	NSInteger z;
} BAPointi;

typedef struct {
	GLfloat x;
	GLfloat y;
	GLfloat z;
} BAPointf;

typedef struct {
	GLfloat x;
	GLfloat y;
	GLfloat w;
} BAPointh;


typedef CGPoint BAVector;
typedef CGPoint BARotation;

typedef BAPointf BAVector3;
typedef BAPointf BARotation3;

// A homogeneous co-ordinate in 3-space
typedef struct {
	GLfloat x;
	GLfloat y;
	GLfloat z;
	GLfloat w;
} BAPoint4f;

typedef BAPoint4f BAVector4f;

typedef struct {
	BAPoint4f p;
	BAVector3 v;
} BALine;

// A homogeneous, "column-major" matrix in 2-space
typedef union {
	BAVector3 v[3];
	GLfloat i[9];
} BAMatrix3x3f;

// A homogeneous, "column-major" matrix in 3-space
typedef union {
	BAVector4f v[4];
	GLfloat i[16];
} BAMatrix4x4f;


typedef union {
	BAPointi p;
	NSInteger i[3];
} BALocationi;

typedef union {
	BAPoint4f p;
	GLfloat i[4];
} BALocationf;

typedef union {
	BARotation3 r;
	GLfloat i[3];
} BAOrientationf;


typedef struct {
	NSUInteger w;
	NSUInteger h;
	NSUInteger d;
} BASizei;

typedef struct {
	GLfloat w;
	GLfloat h;
	GLfloat d;
} BASizef;


typedef union {
	BASizei s;
	NSUInteger i[3];
} BAVolumei;

typedef union {
	BASizef s;
	GLfloat i[3];
} BAVolumef;

typedef BAVolumef BAScalef;


typedef struct {
	BALocationi origin;
	BAVolumei volume;
} BARegioni;

typedef struct {
	BALocationf origin;
	BAVolumef volume;
} BARegionf;


typedef struct {
	BAPointf a;
	BAPointf b;
	BAPointf c;
} BATriangle;

typedef struct {
	BAPointf a;
	BAPointf b;
	BAPointf c;
	BAPointf d;
} BAQuad;

typedef struct {
	unsigned char r;
	unsigned char g;
	unsigned char b;
	unsigned char a;
} BAColorStructi;

typedef union {
	BAColorStructi c;
	unsigned char i[4];
} BAColori;

typedef struct {
	float r;
	float g;
	float b;
	float a;
} BAColorStructf;

typedef union {
	BAColorStructf c;
	float i[4];
} BAColorf;


extern NSString *BAStringFromPointi(BAPointi p);
extern BAPointi BAPointFromStringi(NSString *string);
extern NSString *BAStringFromPointf(BAPointf p);
extern BAPointf BAPointFromStringf(NSString *string);

extern NSString *BAStringFromSizei(BASizei volume);
extern BASizei BASizeFromStringi(NSString *string);
extern NSString *BAStringFromSizef(BASizef volume);
extern BASizef BASizeFromStringf(NSString *string);

extern NSString *BAStringFromRegioni(BARegioni region);
extern BARegioni BARegionFromStringi(NSString *string);
extern NSString *BAStringFromRegionf(BARegionf region);
extern BARegionf BARegionFromStringf(NSString *string);

extern NSString *BAStringFromColori(BAColori color);
extern BAColori BAColorFromStringi(NSString *string);
extern NSString *BAStringFromColorf(BAColorf color);
extern BAColorf BAColorFromStringf(NSString *string);

extern NSString *BAStringFromPoint4f(BAPoint4f p);
extern BAPoint4f BAPoint4FromStringf(NSString *string);

extern NSString *BAStringFromMatrix3x3f(BAMatrix3x3f m);
extern BAMatrix3x3f BAMatrix3x3FromStringf(NSString *string);
extern NSString *BAStringFromMatrix4x4f(BAMatrix4x4f m);
extern BAMatrix4x4f BAMatrix4x4FromStringf(NSString *string);

extern NSData *BAPointDatai(BAPointi point);
extern BAPointi BAPointWithDatai(NSData *data);
extern NSData *BAPointDataf(BAPointf point);
extern BAPointf BAPointWithDataf(NSData *data);

extern NSData *BASizeDatai(BASizei size);
extern BASizei BASizeWithDatai(NSData *data);
extern NSData *BASizeDataf(BASizef size);
extern BASizef BASizeWithDataf(NSData *data);

extern NSData *BALocationDatai(BALocationi location);
extern BALocationi BALocationWithDatai(NSData *data);
extern NSData *BALocationDataf(BALocationf location);
extern BALocationf BALocationWithDataf(NSData *data);

extern NSData *BARegionDatai(BARegioni region);
extern BARegioni BARegionWithDatai(NSData *data);
extern NSData *BARegionDataf(BARegionf region);
extern BARegionf BARegionWithDataf(NSData *data);

extern NSData *BAMatrix4x4Dataf(BAMatrix4x4f matrix);
extern BAMatrix4x4f BAMatrix4x4WithDataf(NSData *data);


@interface BASceneTypes : NSObject {

}

@end
