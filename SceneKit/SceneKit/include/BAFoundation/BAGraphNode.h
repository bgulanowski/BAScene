//
//  BAGraphNode.h
//  BAKit
//
//  Created by Brent Gulanowski on 1/18/08.
//  Copyright 2008 Bored Astronaut. All rights reserved.
//


@interface BAGraphNode : NSObject<NSCoding, NSCopying> {

	NSMutableSet *connectedNodes;
	BAGraphNode *parentNode;
	id object;
}

@property(nonatomic, readwrite,retain) NSSet *connectedNodes;
@property(nonatomic, readwrite,retain) BAGraphNode *parentNode;
@property(nonatomic, readwrite,retain) id object;

- (void)addConnectedNode:(BAGraphNode *)aNode;
- (void)removeConnectedNode:(BAGraphNode *)aNode;

@end
