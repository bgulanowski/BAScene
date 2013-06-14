//
//  BAResourceStorage.h
//  BAScene
//
//  Created by Brent Gulanowski on 10-12-31.
//  Copyright 2010 Bored Astronaut. All rights reserved.
//


@class BAResourceStorage, BASceneResource;

extern BAResourceStorage *ResourceStorage;


@interface BAResourceStorage : NSObject {
	NSString *rootPath;
}

@property (copy) NSString *rootPath;

// designated initializer; -init creates a defaut root in the App Support folder
- (id)initWitRoot:(NSString *)path;

- (void)storeData:(NSData *)data type:(int)type uniqueID:(NSString *)uuid;
- (void)storeDataForResource:(BASceneResource *)aResource;
- (NSData *)retrieveDataWithType:(int)type uniqueID:(NSString *)uuid;

@end
