//
//  BAStage.h
//  BAScene
//
//  Created by Brent Gulanowski on 01/06/09.
//  Copyright 2009 Bored Astronaut. All rights reserved.
//

#import "BAStage.h"

#import "BAPartition.h"
#import "BAGroup.h"


@implementation BAStage

#pragma mark NSManagedObject
- (void)awakeFromInsert {
	// do stuff when you're first created
	self.partitionRoot = [self.managedObjectContext rootPartition];
	
//	NSManagedObject *light = [BALight insertObject];
}

- (void)addProp:(BAProp *)aProp {
	[self.partitionRoot addProp:aProp];
}

- (void)removeProp:(BAProp *)aProp {
	[self.partitionRoot removeProp:aProp];
}

- (void)addGroup:(BAGroup *)aGroup {
	[self.partitionRoot addSubgroupsObject:aGroup];
}

- (void)removeGroup:(BAGroup *)aGroup {
	[self.partitionRoot removeSubgroupsObject:aGroup];
}


#pragma mark New
+ (BAStage *)stage {
	BAAssertActiveContext();
    return [BAActiveContext stage];
}


#pragma mark BACameraDrawDelegate
- (void)paintForCamera:(BACamera *)camera {
}

- (id<BAPropContainer>)propContainer {
	return self;
}


#pragma mark BAPropContainer
- (NSArray *)sortedPropsForCamera:(BACamera *)camera {
	return [self.partitionRoot sortedPropsForCamera:camera];
}

- (void)update:(NSTimeInterval)interval {
	[self.partitionRoot updateProps:interval];
}

@end


@implementation NSManagedObjectContext (BAStageCreating)

- (BAStage *)stage {
	
	BAStage *stage = [self objectForEntityNamed:[BAStage entityName] matchingPredicate:nil];
	
	if(nil == stage)
		stage = (BAStage *)[BAStage insertInManagedObjectContext:self];
	
	return stage;
}

@end
