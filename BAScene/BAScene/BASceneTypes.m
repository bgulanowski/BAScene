//
//  BASceneTypes.m
//  BAScene
//
//  Created by Brent Gulanowski on 10-03-04.
//  Copyright (c) 2010-2014 Bored Astronaut. All rights reserved.
//

#import <BAScene/BASceneUtilities.h>


#define scanGLfloat scanFloat


NSString *BAStringFromPointi(BAPointi p) {
	return [NSString stringWithFormat:@"{%d,%d,%d}", (int)p.x, (int)p.y, (int)p.z];
}

BAPointi BAPointFromStringi(NSString *string) {
	
	BAPointi result = {0,0,0};
	NSScanner *scanner = [NSScanner scannerWithString:string];
	
	[scanner scanString:@"{" intoString:nil];
	[scanner scanInteger:&(result.x)];
	[scanner scanString:@"," intoString:nil];
	[scanner scanInteger:&(result.y)];
	[scanner scanString:@"," intoString:nil];
	[scanner scanInteger:&(result.z)];	
	
	return result;
}


NSString *BAStringFromPointf(BAPointf p) {
	return [NSString stringWithFormat:@"{%.20f,%.20f,%.20f}", p.x, p.y, p.z];
}

BAPointf BAPointFromStringf(NSString *string) {
	
	BAPointf result = {0,0,0};
	NSScanner *scanner = [NSScanner scannerWithString:string];
	
	[scanner scanString:@"{" intoString:nil];
	[scanner scanGLfloat:&(result.x)];
	[scanner scanString:@"," intoString:nil];
	[scanner scanGLfloat:&(result.y)];
	[scanner scanString:@"," intoString:nil];
	[scanner scanGLfloat:&(result.z)];
	
	return result;
}


NSString *BAStringFromSizei(BASizei size) {
	
	BAPointi point;
	point.x = size.w;
	point.y = size.h;
	point.z = size.d;
	return BAStringFromPointi(point);
}

BASizei BASizeFromStringi(NSString *string) {
	BASizei size;
	BAPointi point = BAPointFromStringi(string);
	size.w = point.x;
	size.h = point.y;
	size.d = point.z;
	return size;
}


NSString *BAStringFromSizef(BASizef size) {
	
	BAPointf point;
	point.x = size.w;
	point.y = size.h;
	point.z = size.d;
	return BAStringFromPointf(point);
}

BASizef BASizeFromStringf(NSString *string) {
	BASizef size;
	BAPointf point = BAPointFromStringf(string);
	size.w = point.x;
	size.h = point.y;
	size.d = point.z;
	return size;
}


NSString *BAStringFromRegioni(BARegioni region) {
	return [NSString stringWithFormat:@"{%@},{%@}", BAStringFromPointi(region.origin.p), BAStringFromSizei(region.volume.s)];
}

BARegioni BARegionFromStringi(NSString *string) {
	
	BARegioni region = {{0,0,0},{0,0,0}};
	NSUInteger sepLoc = [string rangeOfString:@",{"].location;
	NSString *pString = [string substringWithRange:NSMakeRange(1, sepLoc)];
	NSString *sString = [string substringWithRange:NSMakeRange(sepLoc+2, [string length]-1-(sepLoc+2))];
	
	region.origin.p = BAPointFromStringi(pString);
	region.volume.s = BASizeFromStringi(sString);
	
	return region;
}


NSString *BAStringFromRegionf(BARegionf region) {
	return [NSString stringWithFormat:@"{%@:%@}", BAStringFromPoint4f(region.origin.p), BAStringFromSizef(region.volume.s)];
}

BARegionf BARegionFromStringf(NSString *string) {
	
	BARegionf region = {{0,0,0},{0,0,0}};
	NSUInteger sepLoc = [string rangeOfString:@":"].location;
	NSString *pString = [string substringWithRange:NSMakeRange(1, sepLoc)];
	NSString *sString = [string substringWithRange:NSMakeRange(sepLoc+2, [string length]-1-(sepLoc+2))];
	BAPointf point = BAPointFromStringf(pString);
	
	region.origin.p = BAMakePoint4f(point.x, point.y, point.z, 1.0f);
	region.volume.s = BASizeFromStringf(sString);
	
	return region;
}

NSString *BAStringFromColori(BAColori color) {
	return [NSString stringWithFormat:@"(%d,%d,%d,%d)", (int)color.c.r, (int)color.c.g, (int)color.c.b, (int)color.c.a];
}
			
BAColori BAColorFromStringi(NSString *string) {
	BAColori result;
	sscanf([string cStringUsingEncoding:NSASCIIStringEncoding], "(%hhd,%hhd,%hhd,%hhd)", &(result.c.r), &(result.c.g), &(result.c.b), &(result.c.a));
	return result;
}

NSString *BAStringFromColorf(BAColorf color) {
	return [NSString stringWithFormat:@"(%01.3f,%01.3f,%01.3f,%01.3f)", color.c.r, color.c.g, color.c.b, color.c.a];
}

BAColorf BAColorFromStringf(NSString *string) {
	BAColorf result;
	sscanf([string cStringUsingEncoding:NSASCIIStringEncoding],"(%f,%f,%f,%f)", &(result.c.r), &(result.c.g), &(result.c.b), &(result.c.a));
	return result;
}

NSString *BAStringFromPoint4f(BAPoint4f p) {
	return [NSString stringWithFormat:@"{%.8f,%.8f,%.8f,%.8f}", p.x, p.y, p.z, p.w];
}

BAPoint4f BAPoint4FromStringf(NSString *string) {
	BAPoint4f r;
	sscanf([string cStringUsingEncoding:NSASCIIStringEncoding],
           "{%f,%f,%f,%f}",
           &(r.x), &(r.y), &(r.z), &(r.w));
	return r;
}

NSString *BAStringFromMatrix3x3f(BAMatrix3x3f m) {
	BAMatrix3x3f t = BATransposeMatrix3x3f(m);
	return [NSString stringWithFormat:@"{%@,%@,%@}", BAStringFromPointf(t.v[0]), BAStringFromPointf(t.v[1]), BAStringFromPointf(t.v[2])];
}

BAMatrix3x3f BAMatrix3x3FromStringf(NSString *string) {
	BAMatrix3x3f r;
	sscanf([string cStringUsingEncoding:NSASCIIStringEncoding],
           "{{%f,%f,%f},{%f,%f,%f},{%f,%f,%f}}",
		   &(r.v[0].x), &(r.v[0].y), &(r.v[0].z),
		   &(r.v[1].x), &(r.v[1].y), &(r.v[1].z),
		   &(r.v[2].x), &(r.v[2].y), &(r.v[2].z));
	return r;
}

NSString *BAStringFromMatrix4x4f(BAMatrix4x4f m) {
	BAMatrix4x4f t = BATransposeMatrix4x4f(m);
	return [NSString stringWithFormat:@"{%@,%@,%@,%@}",
			BAStringFromPoint4f(t.v[0]), BAStringFromPoint4f(t.v[1]), BAStringFromPoint4f(t.v[2]), BAStringFromPoint4f(t.v[3])];
}

BAMatrix4x4f BAMatrix4x4FromStringf(NSString *string) {
	BAMatrix4x4f r;
	sscanf([string cStringUsingEncoding:NSASCIIStringEncoding],
           "{{%f,%f,%f,%f},{%f,%f,%f,%f},{%f,%f,%f,%f}}",
           &(r.v[0].x), &(r.v[0].y), &(r.v[0].z), &(r.v[0].w),
		   &(r.v[1].x), &(r.v[1].y), &(r.v[1].z), &(r.v[1].w),
		   &(r.v[2].x), &(r.v[2].y), &(r.v[2].z), &(r.v[2].w));
	return r;
}

#define BAMakeData(_type_) {\
return [NSData dataWithBytes:&value length:sizeof(_type_)];\
}

#define BAGetBytes(_type_) {\
_type_ result;\
[data getBytes:&result length:sizeof(_type_)];\
return result;\
}

NSData *BAPointDatai(BAPointi value) {
	BAMakeData(BAPointi);
}

BAPointi BAPointWithDatai(NSData *data) {
	BAGetBytes(BAPointi);
}

NSData *BAPointDataf(BAPointf value) {
	BAMakeData(BAPointf);
}

BAPointf BAPointWithDataf(NSData *data) {
	BAGetBytes(BAPointf);
}


NSData *BASizeDatai(BASizei value) {
	BAMakeData(BASizei);
}

BASizei BASizeWithDatai(NSData *data) {
	BAGetBytes(BASizei);
}

NSData *BASizeDataf(BASizef value) {
	BAMakeData(BASizef);
}

BASizef BASizeWithDataf(NSData *data) {
	BAGetBytes(BASizef);
}


NSData *BALocationDatai(BALocationi value) {
	BAMakeData(BALocationi);
}

BALocationi BALocationWithDatai(NSData *data) {
	BAGetBytes(BALocationi);
}

NSData *BALocationDataf(BALocationf value) {
	BAMakeData(BALocationf);
}

BALocationf BALocationWithDataf(NSData *data) {
	BAGetBytes(BALocationf);
}


NSData *BARegionDatai(BARegioni value) {
	BAMakeData(BARegioni);
}

BARegioni BARegionWithDatai(NSData *data) {
	BAGetBytes(BARegioni);
}

NSData *BARegionDataf(BARegionf value) {
	BAMakeData(BARegionf);
}

BARegionf BARegionWithDataf(NSData *data) {
	BAGetBytes(BARegionf);
}

NSData *BAMatrix4x4Dataf(BAMatrix4x4f value) {
	BAMakeData(BAMatrix4x4f);
}

BAMatrix4x4f BAMatrix4x4WithDataf(NSData *data) {
	BAGetBytes(BAMatrix4x4f);
}


@implementation BASceneTypes

@end
