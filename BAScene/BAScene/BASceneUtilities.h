//
//  BASceneUtilities.h
//  BAScene
//
//  Created by Brent Gulanowski on 5/4/09.
//  Copyright 2009 Bored Astronaut. All rights reserved.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
#import <CoreGraphics/CGGeometry.h>
#endif

#import <BAScene/BASceneConstants.h>
#import <BAScene/BASceneTypes.h>


//#if CGFLOAT_IS_DOUBLE
//#define sine sin
//#define cosine cos
//#define absolute fabs
//#define BAInt long long
//#define BAUInt unsigned long long
//#define NAN_OFFSET LLONG_MAX+1 // -1 in signed long long
//#define ULPS_DELTA 0x3fffffff
//#define EPSILON DBL_EPSILON
//#else
#define sine sinf
#define cosine cosf
#define absolute fabsf
#define BAInt long
#define BAUInt unsigned long
#define NAN_OFFSET LONG_MAX+1  // -1 signed long
#define ULPS_DELTA 0x0fff
#define EPSILON FLT_EPSILON
//#endif


// http://www.cygnus-software.com/papers/comparingfloats/comparingfloats.htm
// updated:
// https://randomascii.wordpress.com/2012/02/25/comparing-floating-point-numbers-2012-edition/


// This stuff is probably not reliable :-(
#define ULPDiffs(_r_, _f1_, _f2_) do {\
\
BAInt a = *(BAInt*)&_f1_;\
BAInt b = *(BAInt*)&_f2_;\
\
if (a < 0) a = (BAInt)(NAN_OFFSET - (BAUInt)a);\
if (b < 0) b = (BAInt)(NAN_OFFSET - (BAUInt)b);\
\
_r_ = absolute(a - b);\
} while(0)


static inline BAUInt BAULPDiffFloats(GLfloat f1, GLfloat f2) {
	BAUInt r;
	ULPDiffs(r, f1, f2);
	return r;
}

static inline BOOL BAEqualFloatsULP(GLfloat f1, GLfloat f2) {
	BAUInt r;
	ULPDiffs(r, f1, f2);
    return r <= ULPS_DELTA;
}

#define BAEqualFloats(_f1_, _f2_) (absolute(_f1_-_f2_) <= EPSILON)
#define BAEqualElements(_e1_, _e2_) (absolute(_e1_-_e2_) <= 1.0f/(1<<16))

//#define BAmod(_dend_,_dvsr_) ((_dend_)%(_dvsr_)+((_dend_)<0?(_dvsr_):0))
static inline NSInteger BAmod(NSInteger dend, NSInteger div) {
	NSInteger m = dend%div;
	if(dend < 0 && m != 0)
		m += div;
	return m;
}


#pragma mark -
#pragma mark Randomness

#define BARandomLongLong()             (((long long)random() << 32) | (long long)random())
#define BARandomFloat()                ((float)random()/(float)INT_MAX)
#define BARandomGLfloat()              ((GLfloat)random()/(GLfloat)INT_MAX)
#if CGFLOAT_IS_DOUBLE
#define BARandomCGFloat()              ((GLfloat)BARandomLongLong()/(GLfloat)LLONG_MAX)
#else
#define BARandomCGFloat                BARandomFloat
#endif
#define BARandomBool()                 (random() & 1)
#define BARandomSignedness()           (BARandomBool() * 2 - 1)
#define BARandomCGFloatInRange(_a, _b) (BARandomCGFloat() * fabs(_b - _a) + MIN(_a,_b))
#define BARandomGLfloatInRange(_a, _b) (BARandomGLfloat() * fabs(_b - _a) + MIN(_a,_b))

static inline NSUInteger BARandomIntegerInRange(NSUInteger min, NSUInteger max) {
	
	NSUInteger result = (NSUInteger)BARandomCGFloatInRange(min, max+1);
	
	return result > max ? max : result;
}

extern void BARandomSphereSurfaceLocation(GLfloat cx, GLfloat cy, GLfloat cz, GLfloat r, GLfloat *x, GLfloat *y, GLfloat *z);


//// Geometric Structure operations

#pragma mark -
#pragma mark Ranges
static inline BARangef BAMakeRangef(GLfloat p, GLfloat d) {
	BARangef r;
	r.p = p;
	r.d = d;
	return r;
}

#pragma mark -
#pragma mark Points and Vectors with 3 elements

//#if TARGET_OS_IPHONE
#define BAMakeVector CGPointMake
//#else
//#define BAMakeVector NSMakePoint
//#endif

static inline BAPointi BAMakePointi(NSInteger x, NSInteger y, NSInteger z) {	
	BAPointi point;
	point.x = x;
	point.y = y;
	point.z = z;
	return point;
}

static inline BAPointf BAMakePointf(GLfloat x, GLfloat y, GLfloat z) {	
	BAPointf point;
	point.x = x;
	point.y = y;
	point.z = z;
	return point;
}

static inline BOOL BAEqualPointsi(BAPointi p1, BAPointi p2) {
	return p1.x == p2.x && p1.y == p2.y && p1.z == p2.z;
}

static inline BOOL BAEqualPointsf(BAPointf p1, BAPointf p2) {
	return BAEqualElements(p1.x, p2.x) && BAEqualElements(p1.y, p2.y) && BAEqualElements(p1.z, p2.z);
}

static inline BAPointi BATranslatePointi(BAPointi p, NSInteger dx, NSInteger dy, NSInteger dz) {
	BAPointi p1;
	p1.x = p.x+dx;
	p1.y = p.y+dy;
	p1.z = p.z+dz;
	return p1;
}

static inline BAPointf BATranslatePointf(BAPointf p, GLfloat dx, GLfloat dy, GLfloat dz) {
	BAPointf p1;
	p1.x = p.x+dx;
	p1.y = p.y+dy;
	p1.z = p.z+dz;
	return p1;
}

#define BAMakeVectori      BAMakePointi
#define BAMakeVector3      BAMakePointf
#define BAEqualVectorsi    BAEqualPointsi
#define BAEqualVectors3    BAEqualPointsf
#define BATranslateVectori BATranslatePointi
#define BATranslateVector3 BATranslatePointf

#define BAIsZeroPointf(_p_) (BAEqualFloats(0,_p_.x) && BAEqualFloats(0, _p_.y) && BAEqualFloats(0, _p_.z))

#define BAIsXAlignedVector3(_v_) (BAEqualFloats(0, _v_.y) && BAEqualFloats(0, _v_.z))
#define BAIsYAlignedVector3(_v_) (BAEqualFloats(0, _v_.z) && BAEqualFloats(0, _v_.x))
#define BAIsZAlignedVector3(_v_) (BAEqualFloats(0, _v_.x) && BAEqualFloats(0, _v_.y))

#define BAIsNormalizedVector3(_v_) (BAEqualFloats(1.0f, _v_.x*_v_.x + _v_.y*_v_.y + _v_.z*_v_.z))


static inline BAPointh BAMakePointh(GLfloat x, GLfloat y, GLfloat w) {
	BAPointh p;
	p.x = x, p.y = y, p.w = w;
	return p;
}

static inline BAVector BASubtractPointsh(BAPointh a, BAPointh b) {
	if(!BAEqualFloats(1, a.w))
		a = BAMakePointh(a.x/a.w, a.y/a.w, 1);
	if(!BAEqualFloats(1, b.w))
		b = BAMakePointh(b.x/b.w, b.y/b.w, 1);
	return BAMakeVector(a.x - b.x, a.y - b.y);
}

#define BAIsZeroPointh(_p_) (BAEqualFloats(0, _p_.x) && BAEqualFloats(0, _p_.y) && !BAEqualFloats(0, _p_.w))


static inline BAPointi BAScalePointi(BAPointi a, NSInteger factor) {
	BAPointi v;
	v.x = a.x*factor, v.y = a.y*factor, v.z = a.z*factor;
	return v;
}

static inline BAPointf BAScalePointf(BAPointf a, GLfloat factor) {
	BAPointf v;
	v.x = a.x*factor, v.y = a.y*factor, v.z = a.z*factor;
	return v;
}

static inline BAVector BAInverseVector(BAVector v) {
	return BAMakeVector(-v.x, -v.y);
}

static inline BAVector3 BAInverseVector3(BAVector3 v) {
	return BAMakeVector3(-v.x, -v.y, -v.z);
}

static inline BAVector3 BAAddVectors3(BAVector3 a, BAVector3 b) {
	BAVector3 v;
	v.x = a.x+b.x, v.y = a.y+b.y, v.z = a.z+b.z;
	return v;
}

static inline BAVector3 BASubtractVectors3(BAVector3 a, BAVector3 b) {
	BAVector3 v;
	v.x = a.x-b.x;
	v.y = a.y-b.y;
	v.z = a.z-b.z;
	return v;
}

static inline GLfloat BALengthVector3(BAVector3 v) {
    return sqrtf(v.x*v.x + v.y*v.y + v.z*v.z);
}

static inline BAVector3 BANormalizeVector3(BAVector3 a) {
	
	BAVector3 v = {};
	GLfloat length = BALengthVector3(a);
    
    if(length)
        v.x = a.x/length, v.y = a.y/length, v.z = a.z/length;
	
	return v;
}

static inline BAVector3 BACrossProductVectors3(BAVector3 a, BAVector3 b) {
	BAVector3 v;
	v.x = a.y*b.z - a.z*b.y;
	v.y = a.z*b.x - a.x*b.z;
	v.z = a.x*b.y - a.y*b.x;
	return v;
}

static inline GLfloat BADotProductVectors3(BAVector3 a, BAVector3 b) {
	return a.x*b.x + a.y*b.y + a.z*b.z;
}

static inline GLfloat BAInteriorAngleVector3(BAVector3 a, BAVector3 b) {
    
    a = BANormalizeVector3(a);
    b = BANormalizeVector3(b);
    
    return acosf( BADotProductVectors3(a, b) );
}


#pragma mark - Homogeneous Points in R3

#define BAIsNormalizedVector4f BAIsNormalizedVector3

static inline BAPoint4f BAMakePoint4f(GLfloat x, GLfloat y, GLfloat z, GLfloat w) {
	BAPoint4f v;
	v.x = x, v.y = y, v.z = z, v.w = w;
	return v;
}

static inline BOOL BAEqualPoints4f(BAPoint4f v1, BAPoint4f v2) {
	
#ifdef INF_SUPPORT
	BOOL v1AtINF = BAEqualElements(v1.w, 0), v2AtINF = BAEqualElements(v2.w, 0);
	
	if(v1AtINF)
		return v2AtINF;
	else if(v2AtINF)
		return NO;
	
	if(!BAEqualElements(v1.w, v2.w)) {
		GLfloat factor = v1.w/v2.w;
		return BAEqualElements(v1.x, v2.x*factor) && BAEqualElements(v1.y, v2.y*factor) && BAEqualElements(v1.z, v2.z*factor);
	}
#endif
	return BAEqualElements(v1.x, v2.x) && BAEqualElements(v1.y, v2.y) && BAEqualElements(v1.z, v2.z);
}

static inline BOOL BAPointIsOrigin(BAPoint4f p) {
	return BAEqualElements(p.x, 0) && BAEqualElements(p.y, 0) && BAEqualElements(p.z, 0); 
}

static inline BAPoint4f BATranslatePoint4f(BAPoint4f v, GLfloat x, GLfloat y, GLfloat z) {
	BAPoint4f r;
	r.x = v.x+x, r.y = v.y+y, r.z = v.z+z, r.w = 1;
	return r;
}


static inline BAPoint4f BAScalePoint4f(BAPoint4f a, GLfloat factor) {
	BAPoint4f v;
	v.x = a.x*factor, v.y = a.y*factor, v.z = a.z*factor, v.w = 1;
	return v;
}


#pragma mark - Intersections and Collisions
static inline BAPoint4f BALineSolutionX(BALine l, GLfloat x) {
    
    BAPoint4f r = BAMakePoint4f(x, 0, 0, 1.0f);
    
    if(l.v.x != 0) {
        GLfloat ratio = (l.v.x-l.p.x)/(x-l.v.x);
        r.y = (l.v.y - l.p.y)*ratio + l.v.y;
        r.z = (l.v.z - l.p.z)*ratio + l.v.z;
    }
    else if(l.p.x != x) {
        r.w = 0;
    }
    
    return r;
}

static inline BAPoint4f BALineSolutionY(BALine l, GLfloat y) {
    
    BAPoint4f r = BAMakePoint4f(0, y, 0, 1.0f);
    
    if(l.v.y != 0) {
        
        GLfloat ratio = (l.v.y-l.p.y)/(y-l.v.y);
        
        r.x = (l.v.x - l.p.x)*ratio + l.v.x;
        r.z = (l.v.z - l.p.z)*ratio + l.v.z;
    }
    else if(l.p.y != y) {
        r.w = 0;
    }
    
    return r;
}

static inline BAPoint4f BALineSolutionZ(BALine l, GLfloat z) {

    BAPoint4f r = BAMakePoint4f(0, 0, z, 1.0f);
    
    if(l.v.z != 0) {
        GLfloat ratio = (l.v.z-l.p.z)/(z-l.v.z);
        r.x = (l.v.x - l.p.x)*ratio + l.v.x;
        r.y = (l.v.y - l.p.y)*ratio + l.v.y;
    }
    else if(l.p.z != z) {
        r.w = 0;
    }
    
    return r;
}


extern BOOL BALineIntersectsRegion(BALine line, BARegionf region);


#pragma mark - Affine Matrice and Transformations

/*
 All matrices are stored in column-order; including those created with "MakeRowMatrix". "MakeRowMatrix" _accepts_ entries in row order.
 */

static inline BAMatrix3x3f BAMakeColMatrix3x3f(GLfloat a00, GLfloat a01, GLfloat a02,
											   GLfloat a10, GLfloat a11, GLfloat a12,
											   GLfloat a20, GLfloat a21, GLfloat a22) {
	BAMatrix3x3f m;
	m.v[0].x = a00; m.v[0].y = a01; m.v[0].z = a02;
	m.v[1].x = a10; m.v[1].y = a11; m.v[1].z = a12;
	m.v[2].x = a20; m.v[2].y = a21; m.v[2].z = a22;
	return m;
}

static inline BAMatrix3x3f BAMakeRowMatrix3x3f(GLfloat a00, GLfloat a01, GLfloat a02,
											   GLfloat a10, GLfloat a11, GLfloat a12,
											   GLfloat a20, GLfloat a21, GLfloat a22) {
	BAMatrix3x3f m;
	m.v[0].x = a00; m.v[0].y = a10; m.v[0].z = a20;
	m.v[1].x = a01; m.v[1].y = a11; m.v[1].z = a21;
	m.v[2].x = a02; m.v[2].y = a12; m.v[2].z = a22;
	return m;
}

static inline BAMatrix4x4f BAMakeColMatrix4x4f(GLfloat a00, GLfloat a01, GLfloat a02, GLfloat a03,
											   GLfloat a10, GLfloat a11, GLfloat a12, GLfloat a13,
											   GLfloat a20, GLfloat a21, GLfloat a22, GLfloat a23,
											   GLfloat a30, GLfloat a31, GLfloat a32, GLfloat a33) {
	BAMatrix4x4f m;
	m.v[0].x = a00; m.v[0].y = a01; m.v[0].z = a02; m.v[0].w = a03;
	m.v[1].x = a10; m.v[1].y = a11; m.v[1].z = a12; m.v[1].w = a13;
	m.v[2].x = a20; m.v[2].y = a21; m.v[2].z = a22; m.v[2].w = a23;
	m.v[3].x = a30; m.v[3].y = a31; m.v[3].z = a32; m.v[3].w = a33;
	return m;
}

static inline BAMatrix4x4f BAMakeRowMatrix4x4f(GLfloat a00, GLfloat a01, GLfloat a02, GLfloat a03,
											   GLfloat a10, GLfloat a11, GLfloat a12, GLfloat a13,
											   GLfloat a20, GLfloat a21, GLfloat a22, GLfloat a23,
											   GLfloat a30, GLfloat a31, GLfloat a32, GLfloat a33) {
	BAMatrix4x4f m;
	m.v[0].x = a00; m.v[0].y = a10; m.v[0].z = a20; m.v[0].w = a30;
	m.v[1].x = a01; m.v[1].y = a11; m.v[1].z = a21; m.v[1].w = a31;
	m.v[2].x = a02; m.v[2].y = a12; m.v[2].z = a22; m.v[2].w = a32;
	m.v[3].x = a03; m.v[3].y = a13; m.v[3].z = a23; m.v[3].w = a33;
	return m;
}


#define BAMakeIdentityMatrix( _a_, _d_ ) do {\
for(int _i_=0; _i_<_d_; ++_i_)\
for(int _j_=0; _j_<_d_; ++_j_)\
_a_.i[_d_*_i_+_j_] = _i_ == _j_ ? 1.0f : 0.0f;\
}while(0)

static inline BAMatrix3x3f BAMakeIdentityMatrix3x3f( void ) {
	
	BAMatrix3x3f matrix;
	
	BAMakeIdentityMatrix(matrix, 3);
	
	return matrix;
}

static inline BAMatrix4x4f BAMakeIdentityMatrix4x4f( void ) {
	
	BAMatrix4x4f matrix;
	
	BAMakeIdentityMatrix(matrix, 4);
	
	return matrix;
}


#define BAEqualMatrices( _a_, _b_, _c_ ) do {\
	for(int _i_=0; _i_<_c_; ++_i_)\
		for(int _j_=0; _j_<_c_; ++_j_)\
			if(!BAEqualElements(_a_.i[_c_*_i_+_j_], _b_.i[_c_*_i_+_j_]))\
				return NO;\
} while(0)


#define BAUnequalMatrixElement( _a_, _b_, _c_, _e_ ) do {\
    _e_ = NSNotFound;\
    NSUInteger _i_, _j_, _index_=0;\
    for(_i_=0; _i_<_c_; ++_i_) {\
        for(_j_=0; _j_<_c_; ++_j_)\
            if(!BAEqualElements(_a_.i[_index_], _b_.i[_index_])) {\
                _e_=_index_;\
                break;\
            }\
            else {\
                ++_index_;\
            }\
        if(_e_ != NSNotFound)\
            break;\
    }\
} while(0)

extern const NSUInteger BANotFound;

static inline BOOL BAEqualMatrices3x3f( BAMatrix3x3f a, BAMatrix3x3f b) {
#ifdef DEBUG
    NSUInteger index;
    BAUnequalMatrixElement(a, b, 3, index);
    return index == BANotFound;
#else
	BAEqualMatrices(a, b, 3);
	return YES;
#endif
}

static inline BOOL BAEqualMatrices4x4f( BAMatrix4x4f a, BAMatrix4x4f b) {
#ifdef DEBUG
    NSUInteger index;
    BAUnequalMatrixElement(a, b, 4, index);
    return index == BANotFound;
#else
	BAEqualMatrices(a, b, 4);
	return YES;
#endif
}



#define BAMatrixTranspose( _mt_, _m_, _c_ ) do {\
	for(unsigned _i_=0; _i_<_c_; ++_i_)\
		for(unsigned _j_=0; _j_<_c_; ++_j_)\
			_mt_.i[_c_*_i_+_j_] = _m_.i[_c_*_j_+_i_];\
} while(0)

static inline BAMatrix3x3f BATransposeMatrix3x3f(BAMatrix3x3f a) {
	BAMatrix3x3f m;
	BAMatrixTranspose(m, a, 3);
	return m;
}

static inline BAMatrix4x4f BATransposeMatrix4x4f(BAMatrix4x4f a) {
	BAMatrix4x4f m;
	BAMatrixTranspose(m, a, 4);
	return m;
}


extern NSUInteger BAMatrixSmallestRowOrColumn( BOOL *isRow, GLfloat *m, NSUInteger n);
extern GLfloat BAMatrixMinor( GLfloat *m, NSUInteger row, NSUInteger column, NSUInteger n );
extern GLfloat BAMatrixDeterminant(GLfloat *m, NSUInteger n);


static inline GLfloat BAMatrixDeterminant3x3f(BAMatrix3x3f m) {
    return BAMatrixDeterminant(m.i, 3);
}

static inline GLfloat BAMatrixDeterminant4x4f(BAMatrix4x4f m) {
    return BAMatrixDeterminant(m.i, 4);
}

extern BAMatrix3x3f BAMatrixInverse3x3f(BAMatrix3x3f m);
extern BAMatrix4x4f BAMatrixInverse4x4f(BAMatrix4x4f m);

#define BAVectorTransform( _v_, _a_, _m_, _c_ ) do {\
	GLfloat *_pv_ = (GLfloat *)&_v_;\
	GLfloat *_pa_ = (GLfloat *)&_a_;\
	for(unsigned _i_=0; _i_<_c_; ++_i_)\
		for(unsigned _j_=0; _j_<_c_; ++_j_)\
			_pv_[_i_] += _pa_[_j_]*_m_.i[_c_*_j_+_i_];\
} while(0)

static inline BAPointf BATransformPointf(BAPointf a, BAMatrix3x3f m) {
	BAPointf v = {};
	BAVectorTransform(v, a, m, 3);
	return v;
}

static inline BAPoint4f BATransformPoint4f(BAPoint4f a, BAMatrix4x4f m) {
	BAPoint4f v = {};
	BAVectorTransform(v, a, m, 4);
	return v;
}

static inline BAMatrix3x3f BATranslationMatrix3x3f(BAVector v) {
	BAMatrix3x3f m = BAIdentityMatrix3x3f;
	m.v[2].x = v.x, m.v[2].y = v.y;
	return m;
}

static inline BAMatrix4x4f BATranslationMatrix4x4f(BAVector3 v) {
	BAMatrix4x4f m = BAIdentityMatrix4x4f;
	m.v[3] = BAMakePoint4f(v.x, v.y, v.z, 1);
	return m;
}

// see http://www.euclideanspace.com/maths/geometry/affine/aroundPoint/index.htm

static inline BAMatrix3x3f BARotationMatrix3x3f(GLfloat angle) {

	GLfloat cosa = cosine(angle), sina = sine(angle);
	
	return BAMakeRowMatrix3x3f(cosa, -sina, 0,
							   sina,  cosa, 0,
							      0,     0, 1);
}

static inline BAMatrix3x3f BAArbitraryRotationMatrix3x3f(BAPointh p, GLfloat angle) {
	
	if(BAIsZeroPointh(p))
		return BARotationMatrix3x3f(angle);
	
	GLfloat cosa = cosine(angle), sina = sine(angle), x = p.x, y = p.y;
	
	return BAMakeRowMatrix3x3f(cosa, -sina, x - cosa*x + sina*y,
							   sina,  cosa, y - sina*x - cosa*y,
							      0,     0,                   1);
}


static inline BAMatrix4x4f BAXAxisRotationMatrix4x4f(GLfloat angle) {
	GLfloat cosa = cosine(angle), sina = sine(angle);
	return BAMakeRowMatrix4x4f(1.0f,    0,    0,    0,
							      0, cosa, -sina,   0,
							      0, sina,  cosa,   0,
							      0,    0,    0, 1.0f);
}

static inline BAMatrix4x4f BAYAxisRotationMatrix4x4f(GLfloat angle) {
	GLfloat cosa = cosine(angle), sina = sine(angle);
	return BAMakeRowMatrix4x4f( cosa,    0, sina,    0,
							       0, 1.0f,    0,    0,
							   -sina,    0, cosa,    0,
							       0,    0,    0, 1.0f);
}

static inline BAMatrix4x4f BAZAxisRotationMatrix4x4f(GLfloat angle) {
	GLfloat cosa = cosine(angle), sina = sine(angle);
	return BAMakeRowMatrix4x4f(cosa, -sina,    0,    0,
							   sina,  cosa,    0,    0,
								  0,     0, 1.0f,    0,
							      0,     0,    0, 1.0f);
}

static inline BAMatrix4x4f BAYZRotationMatrix4x4f(BAPoint4f p, GLfloat angle) {
	
	if(BAPointIsOrigin(p)) return BAXAxisRotationMatrix4x4f(angle);
	
	GLfloat b = p.y, c = p.z;
	GLfloat cosa = cosine(angle), ccosa = 1-cosa, sina = sine(angle);
	
/*	return BAMakeRowMatrix4x4f(1 + 0*cosa,      0 - 0,      0 + 0, (a*0 - 1*(0 + 0))*ccosa + (0 - 0)*sina,
							        0 + 0, 0 + 1*cosa,   0 - sina, (b*1 - 0*(a + 0))*ccosa + (c - 0)*sina,
							        0 - 0,   0 + sina, 0 + 1*cosa, (c*1 - 0*(a + 0))*ccosa + (b - 0)*sina,
							            0,          0,          0,                                      1);*/

	return BAMakeRowMatrix4x4f(1,    0,     0,                0,
							   0, cosa, -sina, b*ccosa + c*sina,
							   0, sina,  cosa, c*ccosa + b*sina,
							   0,    0,     0,                1);
}

static inline BAMatrix4x4f BAXZRotationMatrix4x4f(BAPoint4f p, GLfloat angle) {
	
	if(BAPointIsOrigin(p)) return BAYAxisRotationMatrix4x4f(angle);
	
	GLfloat a = p.x, c = p.z;
	GLfloat cosa = cosine(angle), ccosa = 1-cosa, sina = sine(angle);
	
	/*	return BAMakeRowMatrix4x4f(0 + 1*cosa,      0 - 0,   0 + sina, (a*1 - 0*(1 + 0))*ccosa + (0 - c)*sina,
										0 + 0, 1 + 0*cosa,      0 - 0, (b*0 - 1*(0 + 0))*ccosa + (0 - 0)*sina,
							         0 - sina,      0 + 0, 0 + 1*cosa, (c*1 - 0*(0 + 1))*ccosa + (0 - a)*sina,
							                0,          0,          0,                                      1);*/
	
	return BAMakeRowMatrix4x4f( cosa, 0, sina, a*ccosa - c*sina,
							       0, 1,    0,                0,
							   -sina, 0, cosa, c*ccosa - a*sina,
							       0, 0,    0,              1);
}

static inline BAMatrix4x4f BAXYRotationMatrix4x4f(BAPoint4f p, GLfloat angle) {
	
	if(BAPointIsOrigin(p)) return BAZAxisRotationMatrix4x4f(angle);
	
	GLfloat a = p.x, b = p.y;
	GLfloat cosa = cosine(angle), ccosa = 1-cosa, sina = sine(angle);
	
/*	return BAMakeRowMatrix4x4f(0 + 1*cosa,   0 - sina,      0 + 0, (a*1 - 0*(0 + c))*ccosa + (b - 0)*sina,
							     0 + sina, 0 + 1*cosa,      0 - 0, (b*1 - 0*(0 + c))*ccosa + (0 - a)*sina,
							        0 - 0,      0 + 0, 1 + 0*cosa, (c*0 - 1*(0 + 0))*ccosa + (0 - 0)*sina,
										0,          0,          0,                                      1);*/
	
	return BAMakeRowMatrix4x4f(cosa, -sina, 0, a*ccosa + b*sina,
							   sina,  cosa, 0, b*ccosa - a*sina,
							      0,     0, 1,                0,
							      0,     0, 0,                1);
}

static inline BAMatrix4x4f BAOriginRotationMatrix4x4f(BAVector3 vector, GLfloat angle) {

	BAVector3 nv = BANormalizeVector3(vector);

	GLfloat u = nv.x, v = nv.y, w = nv.z;
	GLfloat uu = u*u, vv = v*v, ww = w*w, uv = u*v, uw = u*w, vw = v*w;
	GLfloat cosa = cosine(angle), ccosa = 1-cosa, sina = sine(angle);
	GLfloat usina = u*sina, vsina = v*sina, wsina = w*sina, uvccosa = uv*ccosa, uwccosa = uw*ccosa, vwccosa = vw*ccosa;
	
/*	return BAMakeRowMatrix4x4f(uu + vv_ww*cosa, uvccosa - wsina, uwccosa + vsina,       (0 - u*(0 + 0))*ccosa + (0 - 0)*sina,
							   uvccosa + wsina, vv + uu_ww*cosa, vwccosa - usina, (0*uu_ww - v*(0 + 0))*ccosa + (0 - 0)*sina,
							   uwccosa - vsina, vwccosa + usina, ww + uu_vv*cosa, (0*uu_vv - w*(0 + 0))*ccosa + (0 - 0)*sina,
							                 0,               0,               0,                                          1);*/
/*	return BAMakeRowMatrix4x4f(uu + vv_ww*cosa, uvccosa - wsina, uwccosa + vsina, 0,
	 uvccosa + wsina, vv + uu_ww*cosa, vwccosa - usina, 0,
	 uwccosa - vsina, vwccosa + usina, ww + uu_vv*cosa, 0,
	               0,               0,               0, 1);*/
/*	uu + vv_ww*cosa => uu + (1-uu)*cosa => uu + cosa - uu*cosa => cosa + uu - uu*cosa => cosa + uu*(1-cosa) => cosa + uu*ccosa */
	
	return BAMakeRowMatrix4x4f(cosa + uu*ccosa, uvccosa - wsina, uwccosa + vsina, 0,
							   uvccosa + wsina, cosa + vv*ccosa, vwccosa - usina, 0,
							   uwccosa - vsina, vwccosa + usina, cosa + ww*ccosa, 0,
							                 0,               0,               0, 1);
}

static inline BAMatrix4x4f BAArbitraryRotationMatrix4x4f(BALine axis, GLfloat angle) {

	if(BAIsXAlignedVector3(axis.v)) return BAYZRotationMatrix4x4f(axis.p, angle);
	if(BAIsYAlignedVector3(axis.v)) return BAXZRotationMatrix4x4f(axis.p, angle);
	if(BAIsZAlignedVector3(axis.v)) return BAXYRotationMatrix4x4f(axis.p, angle);

	if(BAPointIsOrigin(axis.p)) return BAOriginRotationMatrix4x4f(axis.v, angle);
	
	BAVector3 nv = BANormalizeVector3(axis.v);
	
	GLfloat a = axis.p.x, b = axis.p.y, c = axis.p.z, u = nv.x, v = nv.y, w = nv.z;
	GLfloat uu = u*u, vv = v*v, ww = w*w, uv = u*v, uw = u*w, vw = v*w;
	GLfloat uu_vv = uu + vv, uu_ww = uu + ww, vv_ww = vv + ww;
	GLfloat cosa = cosine(angle), ccosa = 1-cosa, sina = sine(angle);
	GLfloat usina = u*sina, vsina = v*sina, wsina = w*sina, uvccosa = uv*ccosa, uwccosa = uw*ccosa, vwccosa = vw*ccosa;
	GLfloat au = a*u, av = a*v, aw = a*w, bu = b*u, bv = b*v, bw = b*w, cu = c*u, cv = c*v, cw = c*w;

	// See http://inside.mines.edu/~gmurray/ArbitraryAxisRotation/

	/*
	uu + vv_ww*cosa,  uvccosa - wsina,  uwccosa + vsina,  (a*vv_ww - u*(bv + cw))*ccosa + (bw - cv)*sina,
	uvccosa + wsina,  vv + uu_ww*cosa,  vwccosa - usina,  (b*uu_ww - v*(au + cw))*ccosa + (cu - aw)*sina,
	uwccosa - vsina,  vwccosa + usina,  ww + uu_vv*cosa,  (c*uu_vv - w*(au + bv))*ccosa + (bu - av)*sina,
				  0,                0,                0,                                               1
	 */
	
	return BAMakeRowMatrix4x4f(uu + vv_ww*cosa, uvccosa - wsina, uwccosa + vsina, (a*vv_ww - u*(bv + cw))*ccosa + (bw - cv)*sina,
							   uvccosa + wsina, vv + uu_ww*cosa, vwccosa - usina, (b*uu_ww - v*(au + cw))*ccosa + (cu - aw)*sina,
							   uwccosa - vsina, vwccosa + usina, ww + uu_vv*cosa, (c*uu_vv - w*(au + bv))*ccosa + (bu - av)*sina,
							                 0,               0,               0,                                              1);
}

#define BARotationDf(_angle_) BARotationMatrix3x3f(deg2Rad(_angle_))

#define BAXAxisRotationD4f(_angle_) BAXAxisRotationMatrix4x4f(deg2Rad(_angle_))
#define BAYAxisRotationD4f(_angle_) BAYAxisRotationMatrix4x4f(deg2Rad(_angle_))
#define BAZAxisRotationD4f(_angle_) BAZAxisRotationMatrix4x4f(deg2Rad(_angle_))

#define BAYZRotationD4f(_point_, _angle_) BAYZRotationMatrix4x4f(_point_, deg2Rad(_angle_))
#define BAXZRotationD4f(_point_, _angle_) BAXZRotationMatrix4x4f(_point_, deg2Rad(_angle_))
#define BAXYRotationD4f(_point_, _angle_) BAXYRotationMatrix4x4f(_point_, deg2Rad(_angle_))

#define BAOriginRotationD4f(_vector_, _angle_) BAOriginRotationMatrix4x4f(_vector_, deg2Rad(_angle_)) 

#define BAArbitraryRotationD4f(_line_, _angle_) BAArbitraryRotationMatrix4x4f(_line_, deg2Rad(_angle_))

static inline BAMatrix3x3f BAMultiplyMatrix3x3f(BAMatrix3x3f a, BAMatrix3x3f b) {
	
	BAMatrix3x3f m = {};

	for(unsigned i=0; i<3; ++i)
		BAVectorTransform(m.v[i], b.v[i], a, 3);
	
	return m;
}

static inline BAMatrix4x4f BAMultiplyMatrix4x4f(BAMatrix4x4f a, BAMatrix4x4f b) {
	
	BAMatrix4x4f m = {};
	
	for(unsigned i=0; i<4; ++i)
		BAVectorTransform(m.v[i], b.v[i], a, 4);
	
	return m;
}

static inline BAMatrix3x3f BATranslateMatrix3x3f(BAMatrix3x3f m, BAVector v) {
	return BAMultiplyMatrix3x3f(m, BATranslationMatrix3x3f(v));
}

static inline BAMatrix4x4f BATranslateMatrix4x4f(BAMatrix4x4f m, BAVector3 v) {
	return BAMultiplyMatrix4x4f(m, BATranslationMatrix4x4f(v));
}


#pragma mark -
#pragma mark Locations, Sizes, Orientations, Regions

static inline BALocationi BAMakeLocationi(NSInteger x, NSInteger y, NSInteger z) {	
	BALocationi loc;
	loc.p.x = x;
	loc.p.y = y;
	loc.p.z = z;
	return loc;
}

static inline BALocationf BAMakeLocationf(GLfloat x, GLfloat y, GLfloat z, GLfloat w) {	
	BALocationf loc;
	loc.p.x = x;
	loc.p.y = y;
	loc.p.z = z;
	loc.p.w = w;
	return loc;
}


// Orientations
static inline BAOrientationf BAMakeOrientationf(GLfloat x, GLfloat y, GLfloat z) {	
	BAOrientationf o;
	o.r.x = x;
	o.r.y = y;
	o.r.z = z;
	return o;
}


// Sizes
static inline BASizei BAMakeSizei(NSUInteger w, NSUInteger h, NSUInteger d) {
	BASizei size;
	size.w = w;
	size.h = h;
	size.d = d;
	return size;
}

static inline BOOL BAEqualSizesi(BASizei s1, BASizei s2) {
	return s1.w == s2.w && s1.h == s2.h && s1.d == s2.d;
}


static inline BASizef BAMakeSizef(GLfloat w, GLfloat h, GLfloat d) {
	BASizef size;
	size.w = w;
	size.h = h;
	size.d = d;
	return size;
}

static inline BOOL BAEqualSizesf(BASizef s1, BASizef s2) {
	return s1.w == s2.w && s1.h == s2.h && s1.d == s2.d;
}


// Regions
static inline BARegioni BAMakeRegioni(NSInteger x, NSInteger y, NSInteger z, NSUInteger w, NSUInteger h, NSUInteger d) {
	BARegioni region;
	region.origin.p = BAMakePointi(x, y, z);
	region.volume.s = BAMakeSizei(w, h, d);
	return region;
}

static inline NSInteger BAMinXi(BARegioni region) {
	return region.origin.p.x;
}

static inline NSInteger BAMinYi(BARegioni region) {
	return region.origin.p.y;
}

static inline NSInteger BAMinZi(BARegioni region) {
	return region.origin.p.z;
}

static inline NSInteger BAMaxXi(BARegioni region) {
	return region.origin.p.x + region.volume.s.w;
}

static inline NSInteger BAMaxYi(BARegioni region) {
	return region.origin.p.y + region.volume.s.h;
}

static inline NSInteger BAMaxZi(BARegioni region) {
	return region.origin.p.z + region.volume.s.d;
}

static inline BOOL BAEqualRegionsi(BARegioni r1, BARegioni r2) {
	return BAEqualPointsi(r1.origin.p, r2.origin.p) && BAEqualSizesi(r1.volume.s, r2.volume.s);
}

static inline BOOL BAIsEmptyRegioni(BARegioni region) {
	return (region.volume.s.w < 1 || region.volume.s.w > NSUIntegerMax ||
			region.volume.s.h < 1 || region.volume.s.h > NSUIntegerMax ||
			region.volume.s.d < 1 || region.volume.s.d > NSUIntegerMax);
}

static inline BARegioni BAIntersectionRegioni(BARegioni a, BARegioni b) {
	
	BARegioni result;
	NSInteger maxA[3], maxB[3];
	
	maxA[0] = BAMaxXi(a);
	maxA[1] = BAMaxYi(a);
	maxA[2] = BAMaxZi(a);
	maxB[0] = BAMaxXi(b);
	maxB[1] = BAMaxYi(b);
	maxB[2] = BAMaxZi(b);
	
	for(NSUInteger i=0;i<3;++i) {
		
		NSInteger min = a.origin.i[i] > b.origin.i[i] ? a.origin.i[i] : b.origin.i[i];
		NSInteger max = maxA[i] < maxB[i] ? maxA[i] : maxB[i], length = max - min;
		
		result.origin.i[i] = min;
		result.volume.i[i] = length > 0 ? (NSUInteger)length : 0;
	}
	
	return result;
}

extern BARegioni BAUnionRegioni(BARegioni a, BARegioni b);

static inline BARegioni BAInsetRegioni(BARegioni region, NSInteger offset) {
	BARegioni result;
	result.origin.p.x = region.origin.p.x + offset;
	result.origin.p.y = region.origin.p.y + offset;
	result.origin.p.z = region.origin.p.z + offset;
	result.volume.s.w = region.volume.s.w - 2*offset;
	result.volume.s.h = region.volume.s.h - 2*offset;
	result.volume.s.d = region.volume.s.d - 2*offset;
	return result;
}

static inline BARegionf BAMakeRegionf(GLfloat x, GLfloat y, GLfloat z, GLfloat w, GLfloat h, GLfloat d) {
	BARegionf region;
	region.origin.p = BAMakePoint4f(x, y, z, w);
	region.volume.s = BAMakeSizef(w, h, d);
	return region;
}

#define BAEmptyRegionf() BAMakeRegionf(0, 0, 0, 0, 0, 0);

static inline BOOL BAEqualRegionsf(BARegionf r1, BARegionf r2) {
	return BAEqualPoints4f(r1.origin.p, r2.origin.p) && BAEqualSizesf(r1.volume.s, r2.volume.s);
}

static inline GLfloat BAMinXf(BARegionf region) {
	return region.origin.p.x;
}

static inline GLfloat BAMinYf(BARegionf region) {
	return region.origin.p.y;
}

static inline GLfloat BAMinZf(BARegionf region) {
	return region.origin.p.z;
}

static inline GLfloat BAMaxXf(BARegionf region) {
	return region.origin.p.x + region.volume.s.w;
}

static inline GLfloat BAMaxYf(BARegionf region) {
	return region.origin.p.y + region.volume.s.h;
}

static inline GLfloat BAMaxZf(BARegionf region) {
	return region.origin.p.z + region.volume.s.d;
}

static inline BOOL BAIsEmptyRegionf(BARegionf region) {
	return (region.volume.s.w < 1 || region.volume.s.w > CGFLOAT_MAX ||
			region.volume.s.h < 1 || region.volume.s.h > CGFLOAT_MAX ||
			region.volume.s.d < 1 || region.volume.s.d > CGFLOAT_MAX);
}

static inline BARegionf BAIntersectionRegionf(BARegionf a, BARegionf b) {
	
	BARegionf result;
	GLfloat maxA[3], maxB[3];
	
	maxA[0] = BAMaxXf(a);
	maxA[1] = BAMaxYf(a);
	maxA[2] = BAMaxZf(a);
	maxB[0] = BAMaxXf(b);
	maxB[1] = BAMaxYf(b);
	maxB[2] = BAMaxZf(b);
	
	for(NSUInteger i=0;i<3;++i) {
		
		GLfloat min = a.origin.i[i] > b.origin.i[i] ? a.origin.i[i] : b.origin.i[i];
		GLfloat max = maxA[i] < maxB[i] ? maxA[i] : maxB[i], length = max - min;
		
		result.origin.i[i] = min;
		result.volume.i[i] = length > 0 ? (NSUInteger)length : 0;
	}
	
	return result;
}

extern BARegionf BAUnionRegionf(BARegionf a, BARegionf b);

static inline BARegionf BAInsetRegionf(BARegionf region, GLfloat offset) {
	BARegionf result;
	result.origin.p.x = region.origin.p.x + offset;
	result.origin.p.y = region.origin.p.y + offset;
	result.origin.p.z = region.origin.p.z + offset;
	result.volume.s.w = region.volume.s.w - 2*offset;
	result.volume.s.h = region.volume.s.h - 2*offset;
	result.volume.s.d = region.volume.s.d - 2*offset;
	return result;
}

static inline BAPointf BACentreForRegionf(BARegionf region) {
	BAPointf result;
	result.x = region.origin.p.x + (region.volume.s.w * 0.5);
	result.y = region.origin.p.y + (region.volume.s.h * 0.5);
	result.z = region.origin.p.z + (region.volume.s.d * 0.5);
	return result;
}

static inline BOOL BARegionContainsPointf(BARegionf region, BAPoint4f p) {
	return (p.x >= region.origin.p.x && p.y >= region.origin.p.y && p.z >= region.origin.p.z &&
			p.x <= BAMaxXf(region) && p.y <= BAMaxYf(region) && p.z <= BAMaxZf(region));
}

static inline BARegionf BATransformRegionf(BARegionf r, BAMatrix4x4f m) {
    
    BAPoint4f p1 = BATransformPoint4f(r.origin.p, m);
    BAPoint4f p2 = BATransformPoint4f(BAMakePoint4f(BAMaxXf(r), BAMaxYf(r), BAMaxZf(r), 1.0f), m);
    
    BARegionf result;
    
    result.origin.p = p1;
    result.volume.s = BAMakeSizef(p2.x-p1.x, p2.y-p1.y, p2.z-p1.z);
    
    return result;
}


#pragma mark -
#pragma mark Colors

static inline BAColori BAMakeColori(char r, char g, char b, char a) {
	BAColori result;
	result.c.r = r;
	result.c.g = g;
	result.c.b = b;
	result.c.a = a;
	return result;
}

static inline BAColorf BAMakeColorf(float r, float g, float b, float a) {
	BAColorf result;
	result.c.r = r;
	result.c.g = g;
	result.c.b = b;
	result.c.a = a;
	return result;
}

#define BAWhiteColorf()  BAMakeColorf(1.0f, 1.0f, 1.0f, 1.0f)
#define BARandomColorf() BAMakeColorf(BARandomFloat(), BARandomFloat(), BARandomFloat(), BARandomFloat())
#define BARandomOpaqueColorf() BAMakeColorf(BARandomFloat(), BARandomFloat(), BARandomFloat(), 1.0f)
#define BARandomLightOpaqueColorf() BAMakeColorf(BARandomFloat()*0.5f+0.5f, BARandomFloat()*0.5f+0.5f, BARandomFloat()*0.5f+0.5f, 1.0f)


#if ! TARGET_OS_IPHONE
// TODO: Add CGColor Support
@interface NSColor (BASceneColor)

- (BAColori)BAColori;
- (BAColorf)BAColorf;
- (BOOL)isEqualToColor:(NSColor *)other;

+ (NSColor *)colorWithBAColori:(BAColori)color;
+ (NSColor *)colorWithBAColorf:(BAColorf)color;
+ (NSColor *)randomColor;
+ (NSColor *)randomOpaqueColor;
+ (NSColor *)randomDarkColor; // opaque
+ (NSColor *)randomLightColor; // opaque

@end
#endif

#if ! TARGET_OS_IPHONE
extern void BADrawBox(GLint x1, GLint y1, GLint z1, GLint x2, GLint y2, GLint z2, GLuint r, GLuint g, GLuint b);
extern void BADrawOrigin( void );
#endif
extern void BASceneLogGLInfo( void );

@interface BASceneUtilities : NSObject {

}

@end
