//
//  NSData+GZip.h
//  Dungineer
//
//  Created by Brent Gulanowski on 13-03-07.
//  Copyright (c) 2013 Lichen Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (GZip)

- (NSData *)gzipInflate;
- (NSData *)gzipDeflate;

@end
