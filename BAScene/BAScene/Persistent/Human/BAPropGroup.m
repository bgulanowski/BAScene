//
//  BAPropGroup.m
//  BAScene
//
//  Created by Brent Gulanowski on 30/05/09.
//  Copyright 2009 Bored Astronaut. All rights reserved.
//


#import <BAScene/BAPropGroup.h>

#import <BAScene/BAProp.h>
#import <BAScene/BAMesh.h>

#import <BAScene/BASceneUtilities.h>

@interface BAPropGroup ()

@property (nonatomic, readwrite) BAProp *mergedProp;

- (void)collectProps:(NSMutableSet *)set filterWithBlock:(BOOL(^)(BAProp *prop))block;

@end


@implementation BAPropGroup

@synthesize mergedProp=_mergedProp;
@dynamic bounds;

#pragma mark - Transient Properties
- (BARegionf)bounds {
    if(!boundsLoaded)
        [self loadBounds];
    else if(boundsDirty)
        [self recalculateBounds];
    
    return bounds;
}


#pragma mark Derived Accessors
- (BAProp *)mergedProp {
    if(!_mergedProp && self.mergedPropName)
        _mergedProp = [self.managedObjectContext findPropWithName:self.mergedPropName];
    return _mergedProp;
}


#pragma mark BAPropContainer
- (NSArray *)sortedPropsForCamera:(BACamera *)camera {
	
	if(self.flattenedValue && self.mergedProp)
		return [NSArray arrayWithObject:self.mergedProp];
	
	
	NSMutableSet *mergedProps = [NSMutableSet setWithCapacity:[self.props count]];
    BAPoint4f l = [camera location];
	BAPointf p = BAMakePointf(l.x, l.y, l.z);
	
	[self collectProps:mergedProps filterWithBlock:NULL];

	for(BAProp *prop in mergedProps)
		prop.userInfo = [NSNumber numberWithDouble:[prop distanceForCameraLocation:p]];
	
	
	NSMutableArray *sorted = [NSMutableArray arrayWithArray:[mergedProps allObjects]];
	
	[sorted sortUsingComparator:(NSComparator)^(BAProp *a, BAProp *b) {
		return -[a.userInfo compare:b.userInfo];
	}];
	
	return sorted;
}


#pragma mark Private
- (void)collectProps:(NSMutableSet *)set filterWithBlock:(BOOL(^)(BAProp *prop))block {
	
	for(BAPropGroup *subgroup in self.subgroups)
		[subgroup collectProps:set filterWithBlock:block];
	
	if(self.flattenedValue)
		[set addObject:self.mergedProp];
	else if(block)
		[set unionSet:[self.props filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^(BAProp *prop, NSDictionary *dict) {
			return block(prop);
		}]]];
	else
		[set unionSet:self.props];
}


#pragma mark New

+ (BAPropGroup *)groupWithSuperGroup:(BAPropGroup *)aSupergroup {
	BAAssertActiveContext();
    return [BAActiveContext groupWithSuperGroup:aSupergroup];
}

+ (BAPropGroup *)findGroupWithName:(NSString *)aName {
	BAAssertActiveContext();
    return [BAActiveContext findGroupWithName:aName];
}

- (void)update:(NSTimeInterval)interval {
	// TODO: do some culling here
	[BAProp setLastInterval:interval];
	[self.props makeObjectsPerformSelector:@selector(update)];
}

- (void)updateProps:(NSTimeInterval)interval {
	
	if([self.subgroups count] > 0)
		[self update:interval];
	else
		for(BAPropGroup *subgroup in [[self subgroups] objectEnumerator]) {
			[subgroup updateProps:interval];
		}
//    boundsDirty = YES;
}

- (void)compileProps {
	[self.subgroups makeObjectsPerformSelector:_cmd];
	[[self valueForKeyPath:@"props.@distinctUnionOfSets.prototype.prototypeMeshes.mesh"] makeObjectsPerformSelector:@selector(compile)];
}

- (void)mergeProps:(NSSet *)newProps {
    
    if(_mergedProp)
        self.mergedProp = nil;
	
    NSString *uuidString = self.mergedPropName;
    
    if(![uuidString length]) {

        CFUUIDRef uuid = CFUUIDCreate(NULL);
        
        uuidString = [NSMakeCollectable(CFUUIDCreateString(NULL, uuid)) autorelease];
        self.mergedPropName = uuidString;
        
        CFRelease(uuid);
    }
    
    BAProp *merged = [self.managedObjectContext propWithName:uuidString byMergingProps:newProps];
    
	merged.group = self;
}

- (void)mergeProps {

	if(nil != self.mergedProp)
		return;
	[self.subgroups makeObjectsPerformSelector:_cmd];
	
	[self mergeProps:self.props];
}

- (void)flattenPropsWithBlock:(BOOL(^)(BAProp *prop))block {

	if(self.flattenedValue && self.mergedProp)
		return;
	
	self.flattenedValue = YES;

	NSMutableSet *set = [NSMutableSet setWithCapacity:[self.props count]];
	
	[self collectProps:set filterWithBlock:block];
	[self mergeProps:set];
}

- (void)recalculateBounds {
    
    NSSet *props = self.props;
    BARegionf newBounds = [(BAProp *)[props anyObject] bounds];
    
    for(BAProp *prop in props)
        BAUnionRegionf(newBounds, [prop bounds]);
    
    boundsDirty = NO;
}

- (void)loadBounds {
    
    NSData *data = [self boundsData];
    
    if(nil != data) {
        
        NSValue *value = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        [value getValue:&bounds];
    }
    else if([self.props count])
        [self recalculateBounds];
    
    boundsLoaded = YES;
}

@end


@implementation NSManagedObjectContext (BAGroupCreating)

- (BAPropGroup *)findGroupWithName:(NSString *)aName {
	return [self objectForEntityNamed:[BAPropGroup entityName] matchingValue:aName forKey:@"name"];
}

- (BAPropGroup *)groupWithSuperGroup:(BAPropGroup *)aSupergroup {
    
	BAPropGroup *group = [self insertBAPropGroup];
	
	group.supergroup = aSupergroup;
	
	return group;
}

@end
