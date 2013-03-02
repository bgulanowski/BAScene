//
//  BASceneUtilities.m
//  BAScene
//
//  Created by Brent Gulanowski on 5/4/09.
//  Copyright 2009 Bored Astronaut. All rights reserved.
//

#import "BASceneUtilities.h"


const NSUInteger BANotFound = NSNotFound;


NSUInteger BAMatrixSmallestRowOrColumn( BOOL *isRow, GLfloat *m, NSUInteger n) {
    
    NSUInteger index = 0;

    NSUInteger b = 0; // best count of zeros
    
    *isRow = NO;
    
    // check the jth row and the jth column at the same time
    for(NSUInteger j=0; j<n; ++j) {
        
        NSUInteger r = 0; // row count
        NSUInteger c = 0; // col count
        
        for(NSUInteger k=0; k<n; ++k) {
            if( BAEqualFloats(0, m[k*n+j]) ) r++; // jth row
            if( BAEqualFloats(0, m[j*n+k]) ) c++; // jth column
            if (c > b || r > b) {
                if(r > c) {
                    *isRow = YES;
                    b = r;
                    index = j;
                }
                else {
                    *isRow = NO;
                    b = c;
                    index = j;
                }
                // this row or column is already the winner; skip the rest
                continue;
            }
        }
    }
    
    return index;
}
    
GLfloat BAMatrixMinor( GLfloat *m, NSUInteger row, NSUInteger column, NSUInteger n ) {
    
    assert(n > 2);

    GLfloat *minorMatrix = malloc(sizeof(GLfloat)*(n-1)*(n-1));

    // copy elements
    for(NSUInteger i=0; i<n-1; ++i) {     // columns
        NSUInteger skip = i >= column;
        for(NSUInteger j=0; j<n-1; ++j) { // rows
            NSUInteger c = i+skip;
            NSUInteger r = j + (j>=row);
            NSUInteger index = c*n + r;
            minorMatrix[i*(n-1)+j] = m[index];
        }
    }
    
    GLfloat det = BAMatrixDeterminant(minorMatrix, n-1);

    free(minorMatrix);

    return det;
}

GLfloat BAMatrixDeterminant(GLfloat *m, NSUInteger n) {
    
    GLfloat result = 0;
    
    if(2 == n) {
        result = m[0]*m[3]-m[1]*m[2];
    }
    else {
        // find the row/column with the most zeros
        BOOL isRow = NO;
        NSUInteger rc = BAMatrixSmallestRowOrColumn(&isRow, m, n);
        NSInteger rccf = -(rc&1)*2+1;
        
        // indirect recursion
        if(isRow) {
            for(NSUInteger i=0; i<n; ++i) {
                NSUInteger index = i*n+rc;
                if(!BAEqualFloats(0, m[index])) {
                    NSInteger icf = -(i&1)*2+1;
                    GLfloat minor = BAMatrixMinor(m, rc, i, n);
                    result += icf * rccf * m[index] * minor;
                }
            }
        }
        else {
            for(NSInteger i=0; i<n; ++i) {
                NSUInteger index = rc*n+i;
                if(!BAEqualFloats(0, m[index])) {
                    NSInteger icf = -(i&1)*2+1;
                    GLfloat minor = BAMatrixMinor(m, i, rc, n);
                    result += icf * rccf * m[index] * minor;
                }
            }
        }
    }
    
    return result;
}


static GLfloat *BAMatrixInverse(GLfloat *m, NSUInteger n) {
    
    GLfloat *r = malloc(sizeof(GLfloat)*n*n);
    
    GLfloat dinv = 1.0f/BAMatrixDeterminant(m, n);
    
    for(NSUInteger i=0; i<n; ++i) {     // columns
        NSInteger rcf = -(i&1)*2+1;
        for(NSUInteger j=0; j<n; ++j) { // rows
            NSInteger ccf = -(j&1)*2+1;
            // transpose and divide as we go -- swap rows/columns
            r[i*n+j] = rcf * ccf * BAMatrixMinor(m, i, j, n) * dinv;
        }
    }
    
    return r;
}

BAMatrix3x3f BAMatrixInverse3x3f(BAMatrix3x3f m) {
    
    BAMatrix3x3f result;
    GLfloat *temp = BAMatrixInverse(m.i, 3);
    
    for(NSUInteger i=0; i<9; ++i)
        result.i[i] = temp[i];
    
    free(temp);
    
    return result;
}

BAMatrix4x4f BAMatrixInverse4x4f(BAMatrix4x4f m) {
    
    BAMatrix4x4f result;
    GLfloat *temp = BAMatrixInverse(m.i, 4);
    
    for(NSUInteger i=0; i<16; ++i)
        result.i[i] = temp[i];
    
    free(temp);
    
    return result;
}


#define BAUnionRegionT(_BARegionType_, _BAPrimitiveType_, _suffix_) {\
\
_BARegionType_ result;\
\
_BAPrimitiveType_ minXa = BAMinX ## _suffix_ (a);\
_BAPrimitiveType_ minYa = BAMinY ## _suffix_ (a);\
_BAPrimitiveType_ minZa = BAMinZ ## _suffix_ (a);\
_BAPrimitiveType_ minXb = BAMinX ## _suffix_ (b);\
_BAPrimitiveType_ minYb = BAMinY ## _suffix_ (b);\
_BAPrimitiveType_ minZb = BAMinZ ## _suffix_ (b);\
\
_BAPrimitiveType_ maxXa = BAMaxX ## _suffix_ (a);\
_BAPrimitiveType_ maxYa = BAMaxY ## _suffix_ (a);\
_BAPrimitiveType_ maxZa = BAMaxZ ## _suffix_ (a);\
_BAPrimitiveType_ maxXb = BAMaxX ## _suffix_ (b);\
_BAPrimitiveType_ maxYb = BAMaxY ## _suffix_ (b);\
_BAPrimitiveType_ maxZb = BAMaxZ ## _suffix_ (b);\
\
result.origin.p.x = (minXa < minXb ? minXa : minXb);\
result.origin.p.y = (minYa < minYb ? minYa : minYb);\
result.origin.p.z = (minZa < minZb ? minZa : minZb);\
\
result.volume.s.w = (maxXa > maxXb ? maxXa : maxXb) - result.origin.p.x;\
result.volume.s.h = (maxYa > maxYb ? maxYa : maxYb) - result.origin.p.y;\
result.volume.s.d = (maxZa > maxZb ? maxZa : maxZb) - result.origin.p.z;\
\
return result;\
}

BARegioni BAUnionRegioni(BARegioni a, BARegioni b) {
	BAUnionRegionT( BARegioni , NSInteger , i );
}

BARegionf BAUnionRegionf(BARegionf a, BARegionf b) {
	BAUnionRegionT( BARegionf, GLfloat, f );
}


BOOL BALineIntersectsRegion(BALine l, BARegionf r) {
    
    // check the line's intersection point with each plane
    // that defines one of the sides of the box defining the region
    // edges and corners don't count
    assert(!BAIsZeroPointf(l.v));
    
    BAPoint4f p;
    
#define XinR(p, r) (p.x > BAMinXf(r) && p.y < BAMaxXf(r))
#define YinR(p, r) (p.y > BAMinYf(r) && p.y < BAMaxYf(r))
#define ZinR(p, r) (p.z > BAMinZf(r) && p.z < BAMaxZf(r))
    
    // check intersection with X planes
    if(l.v.x != 0) {
        p = BALineSolutionX(l, BAMinXf(r));
        if(YinR(p, r) && ZinR(p, r))
            return YES;
        p = BALineSolutionX(l, BAMaxXf(r));
        if(YinR(p, r) && ZinR(p, r))
            return YES;
    }

    // check intersection with Y planes
    if(l.v.y != 0) {
        p = BALineSolutionY(l, BAMinYf(r));
        if(XinR(p, r) && ZinR(p, r))
            return YES;
        p = BALineSolutionY(l, BAMaxYf(r));
        if(XinR(p, r) && ZinR(p, r))
            return YES;
    }

    // check intersectino with Z planes
    if(l.v.z == 0) {
        p = BALineSolutionZ(l, BAMinZf(r));
        if(XinR(p, r) && YinR(p, r))
            return YES;
        p = BALineSolutionZ(l, BAMaxZf(r));
        if(XinR(p, r) && YinR(p, r))
            return YES;
    }
    
    return NO;
}


void BARandomSphereSurfaceLocation(GLfloat cx, GLfloat cy, GLfloat cz, GLfloat r, GLfloat *x, GLfloat *y, GLfloat *z) {
	
	// must satisfy x^2+y^2+z^2=r^2 and 0<=x^2<=r^2 and 0<=y^2<=r^2 and 0<=z^2<=r^2
	// randomly choose x^2 in range of (-r^2) to r^2, y^2 in range of x^2 to r^2 and z^2 in range of (x^2+y^2) to r^2
	// then each of x, y and z can be either positive or negative
	
	GLfloat r_2 = r*r;
	GLfloat x_2 = BARandomGLfloatInRange(0, r_2);
	GLfloat y_2 = BARandomGLfloatInRange(0, r_2-x_2);
	GLfloat z_2 = r_2-(x_2+y_2);
	
	*x = sqrtf(x_2) * BARandomSignedness();
	*y = sqrtf(y_2) * BARandomSignedness();
	*z = sqrtf(z_2) * BARandomSignedness();
}


#if ! TARGET_OS_IPHONE
void BADrawBox(GLint x1, GLint y1, GLint z1, GLint x2, GLint y2, GLint z2, GLuint r, GLuint g, GLuint b) {
	
	glPushAttrib(GL_ENABLE_BIT|GL_POLYGON_BIT);
	
	glDisable(GL_DEPTH_TEST);
	glDisable(GL_CULL_FACE);
	glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
	
	glColor3i(r, g, b);
	
	glMatrixMode(GL_MODELVIEW);
	glBegin(GL_QUADS);
	
	glVertex3i(x1, y1, z1);
	glVertex3i(x2, y1, z1);
	glVertex3i(x2, y2, z1);
	glVertex3i(x1, y2, z1);
	
	glVertex3i(x1, y1, z1);
	glVertex3i(x1, y2, z1);
	glVertex3i(x1, y2, z2);
	glVertex3i(x1, y1, z2);
	
	glVertex3i(x1, y1, z1);
	glVertex3i(x1, y1, z2);
	glVertex3i(x2, y1, z2);
	glVertex3i(x2, y1, z1);
	
	glVertex3i(x2, y2, z2);
	glVertex3i(x1, y2, z2);
	glVertex3i(x1, y1, z2);
	glVertex3i(x2, y1, z2);
	
	glVertex3i(x2, y2, z2);
	glVertex3i(x2, y2, z1);
	glVertex3i(x2, y1, z1);
	glVertex3i(x2, y1, z2);
	
	glVertex3i(x2, y2, z2);
	glVertex3i(x2, y1, z2);
	glVertex3i(x1, y1, z2);
	glVertex3i(x1, y2, z2);
	
	glEnd();

	glPopAttrib();
}

void BADrawOrigin( void ) {

	GLboolean enableLighting = NO;
	
	glGetBooleanv(GL_LIGHTING, &enableLighting);
	glDisable(GL_LIGHTING);
	
	glBegin(GL_LINES);
	glColor3f(0, 0, 1);
	glVertex3i(0, 0, 0);
	glVertex3i(1, 0, 0);
	glColor3f(0, 1, 0);
	glVertex3i(0, 0, 0);
	glVertex3i(0, 1, 0);
	glColor3f(1, 0, 0);
	glVertex3i(0, 0, 0);
	glVertex3i(0, 0, 1);
	glEnd();
	
	if(enableLighting)
		glEnable(GL_LIGHTING);
}
#endif


void BASceneLogGLInfo( void ) {
    NSLog(@"OpenGL Version: %s", glGetString (GL_VERSION));
    NSLog(@"OpenGL Extensions:\n%s", glGetString (GL_EXTENSIONS));
}



#if ! TARGET_OS_IPHONE
@implementation NSColor (BASceneColor)

- (BAColori)BAColori {
	
	CGFloat comps[4];
	
	[self getComponents:comps];
	
	return BAMakeColori((char)(comps[0]*255), (char)(comps[1]*255), (char)(comps[2]*255), (char)(comps[3]*255));
}

- (BAColorf)BAColorf {
	
	CGFloat comps[4];
	
	[self getComponents:comps];
	
	return BAMakeColorf(comps[0], comps[1], comps[2], comps[3]);
}

- (BOOL)isEqualToColor:(NSColor *)other {
    
    if(![[self colorSpaceName] isEqualToString:[other colorSpaceName]])
        return NO;
    
    NSInteger count = [self numberOfComponents];
    
    if (count != [other numberOfComponents])
        return NO;
    
    CGFloat comps[4], otherComps[4];
    
    [self getComponents:comps];
    [other getComponents:otherComps];
    
    for (NSUInteger i = 0; i < count; i++)
        if (comps[i] != otherComps[i])
            return NO;
    
    return YES;
}

+ (NSColor *)colorWithBAColori:(BAColori)color {
    
    CGFloat r = (CGFloat)color.c.r/255.f;
    CGFloat g = (CGFloat)color.c.g/255.f;
    CGFloat b = (CGFloat)color.c.b/255.f;
    CGFloat a = (CGFloat)color.c.a/255.f;

    return [NSColor colorWithDeviceRed:r green:g blue:b alpha:a];
}

+ (NSColor *)colorWithBAColorf:(BAColorf)color {
    return [NSColor colorWithDeviceRed:color.c.r green:color.c.g blue:color.c.b alpha:color.c.a];
}

+ (NSColor *)randomColor {

    CGFloat r = (CGFloat)BARandomIntegerInRange(0, 255)/255.f;
    CGFloat g = (CGFloat)BARandomIntegerInRange(0, 255)/255.f;
    CGFloat b = (CGFloat)BARandomIntegerInRange(0, 255)/255.f;
    CGFloat a = (CGFloat)BARandomIntegerInRange(0, 255)/255.f;
    
    return [self colorWithDeviceRed:r green:g blue:b alpha:a];
}

+ (NSColor *)randomOpaqueColor {
    
    CGFloat r = (CGFloat)BARandomIntegerInRange(8, 247)/255.f;
    CGFloat g = (CGFloat)BARandomIntegerInRange(8, 247)/255.f;
    CGFloat b = (CGFloat)BARandomIntegerInRange(8, 247)/255.f;
    
    return [self colorWithDeviceRed:r green:g blue:b alpha:1.f];
}

+ (NSColor *)randomDarkColor {
    
    CGFloat r = (CGFloat)BARandomIntegerInRange(8, 119)/255.f;
    CGFloat g = (CGFloat)BARandomIntegerInRange(8, 119)/255.f;
    CGFloat b = (CGFloat)BARandomIntegerInRange(8, 119)/255.f;
    
    return [self colorWithDeviceRed:r green:g blue:b alpha:1.f];
}

+ (NSColor *)randomLightColor {
    
    CGFloat r = (CGFloat)BARandomIntegerInRange(148, 247)/255.f;
    CGFloat g = (CGFloat)BARandomIntegerInRange(148, 247)/255.f;
    CGFloat b = (CGFloat)BARandomIntegerInRange(148, 247)/255.f;
    
    return [self colorWithDeviceRed:r green:g blue:b alpha:1.f];
}

@end
#endif


@implementation BASceneUtilities

#if 0
+ (void)initialize {
	if([self class] == [BASceneUtilities class]) {
		// randomness tests
		NSLog(@"size of float: %u; size of GLfloat: %u; size of GLfloat: %u", sizeof(float), sizeof(GLfloat), sizeof(GLfloat) );
		NSLog(@"size of unsigned int: %u; size of long: %u; sizeof long long: %u; UINT_MAX:%qi; LONG_MAX:%qi; LLONG_MAX:%qi", sizeof(unsigned), sizeof(long), sizeof(long long), UINT_MAX, LONG_MAX, LLONG_MAX);
		NSLog(@"10 x random():");
		for(int i=0;i<10;++i)
			NSLog(@"  %qi", random());
		NSLog(@"10 x BARandomLongLong():");
		for(int i=0;i<10;++i)
			NSLog(@"  %qi", BARandomLongLong());
		NSLog(@"10 x BARandomGLfloat():");
		for(int i=0;i<10;++i)
			NSLog(@"  %f", BARandomGLfloat());
		NSLog(@"10 x BARandomIntegerInRange() for 0-9:");
		for(int i=0;i<10;++i)
			NSLog(@"  %qu", BARandomIntegerInRange(0, 9));
		NSLog(@"10 x BARandomSignedness():");
		for(int i=0;i<10;++i)
			NSLog(@"  %d", BARandomSignedness());
		NSLog(@"10 x BARandomBool():");
		for(int i=0;i<10;++i)
			NSLog(@"  %u", BARandomBool());
	}
}
#endif

@end
