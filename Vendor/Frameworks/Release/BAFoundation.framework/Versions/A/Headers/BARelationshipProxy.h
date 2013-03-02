//
//  BARelationshipProxy.h
//  BAFoundation
//
//  Created by Brent Gulanowski on 12-12-06.
//  Copyright (c) 2012 Bored Astronaut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BARelationshipProxy : NSObject {
    id _object;
    NSString *_relationshipName;
}

@property (nonatomic, assign) id object;
@property (nonatomic, assign) NSString *relationshipName;

- (id)initWithObject:(id)object relationshipName:(NSString *)relationshipName;

- (id)insertObject;

+ (BARelationshipProxy *)relationshipProxyWithObject:(id)object relationshipName:(NSString *)relationshipName;

@end
