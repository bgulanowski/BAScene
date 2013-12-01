//
//  BAPref.h
//  BAScene
//
//  Created by Brent Gulanowski on 25/06/08.
//  Copyright 2008 Bored Astronaut. All rights reserved.
//

#import <BAScene/BAScenePref.h>


@implementation BAScenePref

+ (NSManagedObject *)objectForIdentifier:(NSString *)identifier {
	
	NSManagedObjectContext *activeContext = BAActiveContext;
	NSString *objectIDString = [[activeContext objectForEntityNamed:@"Pref"
													  matchingValue:identifier
															 forKey:@"prefKey"] valueForKey:@"prefValue"];
	
	return [activeContext objectWithIDString:objectIDString];	
}

+ (void)setObject:(NSManagedObject *)anObject forIdentifier:(NSString *)identifier {
	
	NSManagedObjectContext *activeContext = BAActiveContext;
	NSManagedObjectID *objectID = [anObject objectID];
	NSString *urlString = [[objectID URIRepresentation] absoluteString];
	
	id pref = [activeContext objectForEntityNamed:@"Pref"
									matchingValue:identifier
										   forKey:@"prefKey"];
	if(nil == pref) {
		pref = (BAScenePref *)[self insertObject];
		[pref setValue:identifier forKey:@"prefKey"];
	}
	
	[pref setValue:urlString forKey:@"prefValue"];
}

@end
