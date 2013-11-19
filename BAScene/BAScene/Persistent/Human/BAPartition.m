//
//  BAPartition.h
//  BAScene
//
//  Created by Brent Gulanowski on 01/06/09.
//  Copyright 2009 Bored Astronaut. All rights reserved.
//

#import "BAPartition.h"

#import "BACamera.h"
#import "BAMesh.h"
#import "BATuple.h"


static NSString *kBARootPartitionName = @"BAScene:RootPartition";
//static NSString *kBARootPartitionVolumeName = @"BAScene:RootPartitionVolume";


@interface BAPartition ()
@property (nonatomic, readwrite) BARegionf region;
@end

@implementation BAPartition

@synthesize region, userData;

- (void)dealloc {
    self.userData = nil;
    [super dealloc];
}

- (void)awakeFromFetch {
	double d = self.dimensionValue;
	region.origin.p = [self.location point4f];
	region.volume.s = BAMakeSizef(d, d, d);
    self.userData = [NSMutableDictionary dictionary];
}

+ (BAPartition *)partitionWithDimension:(GLfloat)dim location:(BALocationf)loc parent:(BAPartition *)parent {
    BAAssertActiveContext();
    return [BAActiveContext partitionWithDimension:dim location:loc parent:parent];
}

+ (BAPartition *)rootPartitionWithDimension:(GLfloat)dim {
    BAAssertActiveContext();
    return [BAActiveContext rootPartitionWithDimension:dim];
}

+ (BAPartition *)rootPartition {
    BAAssertActiveContext();
    return [BAActiveContext rootPartition];
}

- (void)subdivide {
	
	if([self.subgroups count] > 0)
		return;
	
	double dim = region.volume.s.d * 0.5f, dim_2 = dim * 0.5f;
	
	if(dim < (double)(1<<4))
		return;
	
	NSMutableSet *children = [NSMutableSet setWithCapacity:8];
	
	double x[2], y[2], z[2];
	
	x[0] = BAMinXf(region), x[1] = x[0]+dim, y[0] = BAMinYf(region), y[1] = y[0]+dim, z[0] = BAMinZf(region), z[1] = z[0]+dim;
	for(unsigned i=0; i<2; ++i)
		for(unsigned j=0; j<2; ++j)
			for(unsigned k=0; k<2; ++k)
				[children addObject:[BAPartition partitionWithDimension:dim location:BAMakeLocationf(x[i]+dim_2, y[j]+dim_2, z[k]+dim_2, 1.0f) parent:self]];
	
	[self addSubgroups:children];
}

- (void)addProp:(BAProp *)aProp {
	// TODO: find descendant leaf which contains prop's location point
	[self addPropsObject:aProp];
}

- (void)removeProp:(BAProp *)aProp {
	// TODO: find descendant leaf which contains prop's location point
	[self removePropsObject:aProp];
}

- (BOOL)containsPointX:(double)x y:(double)y z:(double)z {
	return BARegionContainsPointf(region, BAMakePoint4f(x, y, z, 1.0f));
}

- (BAPartition *)partitionForPointX:(double)x y:(double)y z:(double)z {
	
	if(! [self containsPointX:x y:y z:z])
		return nil;
	
	for(BAPartition *child in self.subgroups)
		if([child containsPointX:x y:y z:z])
			return [child partitionForPointX:x y:y z:z];
	
	return self;
}

- (BOOL)intersectsLine:(BALine)line {
    return NO;
}

- (BOOL)containsCamera:(BACamera *)camera {
    BAPoint4f l = [camera location];
	return [self containsPointX:l.x y:l.y z:l.z];
}

- (BAPartition *)partitionForCamera:(BACamera *)camera {
    BAPoint4f l = [camera location];
	return [self partitionForPointX:l.x y:l.y z:l.z];
}

@end


@implementation NSManagedObjectContext (BAPartitionCreating)

- (BAPartition *)partitionWithDimension:(GLfloat)dim location:(BALocationf)loc parent:(BAPartition *)parent {
    
	BAPartition *partition = [self insertBAPartition];
	
	double d_2 = dim * 0.5f;
	
	partition.supergroup = parent;
	partition.dimensionValue = dim;
	partition.location = [self tupleWithPoint4f:loc.p];
	partition.region = BAMakeRegionf(loc.p.x - d_2, loc.p.y - d_2, loc.p.z - d_2, dim, dim, dim);
	
	return partition;
}

- (BAPartition *)rootPartitionWithDimension:(GLfloat)dim {
    
	BAPartition *root = [BAActiveContext objectForEntityNamed:[BAPartition entityName] matchingValue:kBARootPartitionName forKey:@"name"];
	
	if(!root) {
		root = [self partitionWithDimension:dim location:BAMakeLocationf(0, 0, 0, 1.0f) parent:nil];
        root.name = kBARootPartitionName;
    }
	
	return root;
}

- (BAPartition *)rootPartition {
	return [self rootPartitionWithDimension:(GLfloat)(1<<8)];
}

@end
