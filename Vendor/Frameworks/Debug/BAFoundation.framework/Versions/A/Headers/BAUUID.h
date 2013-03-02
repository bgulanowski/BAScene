//
//  BAUUID.h
//  Cavebot
//
//  Created by Brent Gulanowski on 12-07-27.
//  Copyright (c) 2012 Lichen Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAUUID : NSObject<NSCoding, NSCopying> {
    CFUUIDBytes _bytes;
}

@property (nonatomic) CFUUIDBytes bytes;
@property (nonatomic, readonly) CFUUIDRef CFUUIDRef;
@property (nonatomic, readonly) NSData *data;

- (id)initWithCFUUIDBytes:(CFUUIDBytes)bytes;
- (id)initWithCFUUID:(CFUUIDRef)uuidRef;
- (id)initWithData:(NSData *)data;

- (id)initWithString:(NSString *)string;

- (NSComparisonResult)compare:(BAUUID *)otherUuid;

+ (BAUUID *)UUID;
+ (BAUUID *)UUIDWithCFUUID:(CFUUIDRef)uuidRef;
+ (BAUUID *)UUIDWithData:(NSData *)data;

@end


extern NSString *kBAUUIDValueTransformerName;

@interface BAUUIDDataTransformer : NSValueTransformer

@end
