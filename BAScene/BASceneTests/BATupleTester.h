//
//  BAPointTester.h
//  BAScene
//
//  Created by Brent Gulanowski on 5/4/09.
//  Copyright 2009 Bored Astronaut. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

#import <CoreData/CoreData.h>

@class BATuple;

@interface BATupleTester : SenTestCase {
	BATuple *point;
}

@property (retain) BATuple *point;

@end
