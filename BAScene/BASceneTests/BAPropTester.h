//
//  BAPropTester.h
//  BAScene
//
//  Created by Brent Gulanowski on 5/4/09.
//  Copyright 2009 Bored Astronaut. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

#import <CoreData/CoreData.h>


@interface BAPropTester : SenTestCase {
	NSManagedObject *prop;
}

@property (retain) NSManagedObject *prop;

@end
