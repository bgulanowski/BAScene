//
//  BACoreDataManager.h
//
//  Created by Brent Gulanowski on 09-10-22.
//  Copyright Bored Astronaut. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface BACoreDataManager : NSObject {

	NSManagedObjectModel *model;
	NSPersistentStoreCoordinator *coordinator;
	NSManagedObjectContext *context;
    NSManagedObjectContext *editingContext;
	
    NSTimer *scheduledSaveTimer;
	NSURL *storeURL;
    
    dispatch_once_t editorToken;
    
    NSTimeInterval saveDelay;
    NSInteger editCount;
    
	BOOL storeUnreadable;
	BOOL readOnly;
}

@property (nonatomic, strong) NSManagedObjectModel *model;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectContext *editingContext;

@property (nonatomic, strong) NSURL *storeURL;

@property (nonatomic) NSTimeInterval saveDelay; // used by scheduleSave so saves coalesce
@property (nonatomic) NSInteger editCount;
@property (nonatomic) BOOL storeUnreadable;
@property (nonatomic) BOOL readOnly;

- (id)initWithStoreURL:(NSURL *)url;

- (NSURL *)modelURL;

- (BOOL)save;
- (void)scheduleSave;

- (void)startEditing;
- (void)endEditing;
- (void)cancelEdits;
- (void)resetEditCount;

- (void)refreshObjects:(NSArray *)objects;
- (void)deleteObject:(NSManagedObject *)object;

// convenience: objectURIs must contain string URLs (Not NSURLs)
- (void)refreshObjectsWithURIs:(NSArray *)objectURIs;

+ (NSString *)defaultStoreType;      // default is "NSSQLiteStoreType"
+ (NSString *)defaultStoreExtension; // default depends on store type: either "sqlite", "coredata" (for binary stores), or "xml"
+ (NSString *)defaultStoreFileName;  // default is the value returned by [[NSProcessInfo processInfo] processName]
+ (NSString *)defaultStoreLocation;  // absolute folder path; default is "<App_support_folder>/<bundle.identifier>"
+ (NSURL *)defaultStoreURL;          // file://<location>/<fileName>.<extension>

+ (id)newCoreDataManager;

@end


#if TARGET_OS_IPHONE
@protocol BAApplicationDelegateAdditions <UIApplicationDelegate, NSObject>
- (BACoreDataManager *)modelManager;
@end


@interface UIApplication (BAAdditions)
- (BACoreDataManager *)modelManager;
+ (BACoreDataManager *)modelManager;
@end
#endif
