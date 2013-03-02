//
//  BATextIOHandler.h
//  Escape
//
//  Created by Brent Gulanowski on 11/27/05.
//  Copyright 2005 Bored Astronaut. All rights reserved.
//
//  An interface to text-based input and output; primarily for handling stdio.


#import <Foundation/Foundation.h>


@interface BATextIOHandler : NSObject {
	
	NSFileHandle *inputFH;
	NSFileHandle *outputFH;
	NSString *prompt;
	id delegate;
}

/* designated initializer */
- (id)initWithInputFile:(NSString *)inFile outputFile:(NSString *)outFile;

/* set inFile to nil for stdin, outFile to nil for stdout */
- (void)setInputFile:(NSString *)inFile;
- (void)setOutputFile:(NSString *)outFile;

- (NSString *)prompt;
- (void)setPrompt:(NSString *)newPrompt;

/* if there's no delegate, nothing happens */
- (id)delegate;
- (void)setDelegate:(id)del;
- (void)write:(NSString *)text;
- (void)writeLine:(NSString *)text;

@end

@interface NSObject (BATextIOHandlerDelegate)

- (NSString *)processInput:(NSString *)inputString;

@end

