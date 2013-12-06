//
//  BASceneTests.m
//  BAScene
//
//  Created by Brent Gulanowski on 5/4/09.
//  Copyright (c) 2009-2014 Bored Astronaut. All rights reserved.
//

#import "BASceneTestSupport.h"

#import <BAScene/BAScene.h>


@implementation BASceneTestSupport

NSManagedObjectModel *testModel;
NSPersistentStoreCoordinator *testCoordinator;
NSManagedObjectContext *testContext;


+ (void)initialize {
	testModel = [[BAScene sceneModel] retain];
	testCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:testModel];	
	testContext = [[NSManagedObjectContext alloc] init];
	[testContext setPersistentStoreCoordinator:testCoordinator];
	[testContext setUndoManager:nil];
}

+ (NSManagedObjectContext *)testContext {
	return testContext;
}

@end
