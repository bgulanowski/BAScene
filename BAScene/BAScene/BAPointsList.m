//
//  BAPointsList.m
//  BAScene
//
//  Created by Brent Gulanowski on 09-11-03.
//  Copyright (c) 2009-2014 Bored Astronaut. All rights reserved.
//

#import "BAPointsList.h"


@implementation BAPointsList

@dynamic editable;

- (id)init {
	return [self initWithNibName:[self className] bundle:[NSBundle bundleForClass:[self class]]];
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

- (BOOL)editable {
	return [addButton isEnabled];
}

- (void)setEditable:(BOOL)flag {
	[addButton setEnabled:flag];
	[removeButton setEnabled:flag];
}

- (NSManagedObjectContext *)context {
	return BAActiveContext;
}
@end
