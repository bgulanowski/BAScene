//
//  BAPointsList.h
//  BAScene
//
//  Created by Brent Gulanowski on 09-11-03.
//  Copyright (c) 2009-2014 Bored Astronaut. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface BAPointsList : NSViewController {

	IBOutlet NSArrayController *pointsAC;
	
	IBOutlet NSButton *addButton;
	IBOutlet NSButton *removeButton;
}

@property (readwrite) BOOL editable;

@property (readonly) NSManagedObjectContext *context;

@end
