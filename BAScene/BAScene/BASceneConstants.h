/*
 *  BASceneConstants.h
 *  BAScene
 *
 *  Created by Brent Gulanowski on 10-04-14.
 *  Copyright 2010 Bored Astronaut. All rights reserved.
 *
 */


#define RAD2DEG (180.0f/M_PI)
#define DEG2RAD (M_PI/180.0f)
#define rad2Deg(_angle_in_rad_) ((_angle_in_rad_) * RAD2DEG)
#define deg2Rad(_angle_in_deg_) ((_angle_in_deg_) * DEG2RAD)

/*
 * Unit vertices between {-1,-1,-1} and {1,1,1}
 */

#define p000 {-1.0f,-1.0f,-1.0f}
#define p00h {-1.0f,-1.0f,0.0f}
#define p001 {-1.0f,-1.0f,1.0f}
#define p0h0 {-1.0f,0.0f,-1.0f}
#define p0hh {-1.0f,0.0f,0.0f}
#define p0h1 {-1.0f,0.0f,1.0f}
#define p010 {-1.0f,1.0f,-1.0f}
#define p01h {-1.0f,1.0f,0.0f}
#define p011 {-1.0f,1.0f,1.0f}

#define ph00 {0.0f,-1.0f,-1.0f}
#define ph0h {0.0f,-1.0f,0.0f}
#define ph01 {0.0f,-1.0f,1.0f}
#define phh0 {0.0f,0.0f,-1.0f}
#define phhh {0.0f,0.0f,0.0f}
#define phh1 {0.0f,0.0f,1.0f}
#define ph10 {0.0f,1.0f,-1.0f}
#define ph1h {0.0f,1.0f,0.0f}
#define ph11 {0.0f,1.0f,1.0f}

#define p100 {1.0f,-1.0f,-1.0f}
#define p10h {1.0f,-1.0f,0.0f}
#define p101 {1.0f,-1.0f,1.0f}
#define p1h0 {1.0f,0.0f,-1.0f}
#define p1hh {1.0f,0.0f,0.0f}
#define p1h1 {1.0f,0.0f,1.0f}
#define p110 {1.0f,1.0f,-1.0f}
#define p11h {1.0f,1.0f,0.0f}
#define p111 {1.0f,1.0f,1.0f}


#define phi (1.618033988749895f) // (1+√5)/2
#define ihp (1/phi)


/** The following definitions use phi = φ and ihp = 1/φ **/

/*
 Dodecahedron vertices (from mathworld and wikipedia)
 (±1, ±1, ±1)
 (0, ±1/φ, ±φ)
 (±1/φ, ±φ, 0)
 (±φ, 0, ±1/φ)
 where:
 φ = (1+√5)/2 ≈ 1.6180339875
 */

#define dv01 {  -1,  -1,  -1 }
#define dv02 {  -1,  -1,   1 }
#define dv03 {  -1,   1,  -1 }
#define dv04 {  -1,   1,   1 }
#define dv05 {   1,  -1,  -1 }
#define dv06 {   1,  -1,   1 }
#define dv07 {   1,   1,  -1 }
#define dv08 {   1,   1,   1 }
#define dv09 {   0,-phi,-ihp }
#define dv10 {   0,-phi, ihp }
#define dv11 {   0, phi,-ihp }
#define dv12 {   0, phi, ihp }
#define dv13 {-phi,-ihp,   0 }
#define dv14 {-phi, ihp,   0 }
#define dv15 { phi,-ihp,   0 }
#define dv16 { phi, ihp,   0 }
#define dv17 {-ihp,   0,-phi }
#define dv18 {-ihp,   0, phi }
#define dv19 { ihp,   0,-phi }
#define dv20 { ihp,   0, phi }


/* Icosahedron vertices:
 (0, ±1, ±φ)
 (±1, ±φ, 0)
 (±φ, 0, ±1)
 */ 

#define iv01 {   0,  -1,-phi }
#define iv02 {   0,  -1, phi }
#define iv03 {   0,   1,-phi }
#define iv04 {   0,   1, phi }
#define iv05 {  -1,-phi,   0 }
#define iv06 {  -1, phi,   0 }
#define iv07 {   1,-phi,   0 }
#define iv08 {   1, phi,   0 }
#define iv09 {-phi,   0,  -1 }
#define iv10 { phi,   0,  -1 }
#define iv11 {-phi,   0,   1 }
#define iv12 { phi,   0,   1 }


#define BAIdentityMatrix3x3f { { {1.0f, 0.0f, 0.0f}, {0.0f, 1.0f, 0.0f}, {0.0f, 0.0f, 1.0f} } }
#define BAIdentityMatrix4x4f { { {1.0f, 0.0f, 0.0f, 0.0f}, {0.0f, 1.0f, 0.0f, 0.0f}, {0.0f, 0.0f, 1.0f, 0.0f}, {0.0f, 0.0f, 0.0f, 1.0f} } }

#define BAZeroVector { 0, 0 }
#define BAZeroPointh { 0, 0, 1 }

// a notification posted every 1/60 second
extern NSString *kBASceneHeartBeatNotification;
// an NSDate object included in the notification user info
extern NSString *kBASceneLastUpdateKey;

@class BAScene;

extern const BAScene *theScene;

