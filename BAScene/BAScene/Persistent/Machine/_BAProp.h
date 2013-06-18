// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BAProp.h instead.

#import <CoreData/CoreData.h>


@class BAProp, BAPropID;

@interface NSManagedObjectContext (BAPropConveniences)

- (BAProp *)findBAPropWithID:(BAPropID *)objectID;
- (BAProp *)insertBAProp;

- (NSUInteger)countOfPropObjectsWithPredicate:(NSPredicate *)predicate;
- (NSUInteger)countOfPropObjectsWithValue:(id)value forKey:(NSString *)key;
- (NSUInteger)countOfPropObjects;

@end


@class BAColor;
@class BAPropGroup;
@class BAPrototype;
@class BATransform;

@interface BAPropID : NSManagedObjectID {}
@end


@interface _BAProp : NSManagedObject {}

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BAPropID*)objectID;

// Attributes

@property (nonatomic, retain) NSData *boundsData;
//- (BOOL)validateBoundsData:(id *)value_ error:(NSError **)error_;

@property (nonatomic, retain) NSString *name;
//- (BOOL)validateName:(id *)value_ error:(NSError **)error_;


// Relationships
@property (nonatomic, retain) BAColor *color;
//- (BOOL)validateColor:(id *)value_ error:(NSError **)error_;

@property (nonatomic, retain) BAPropGroup *group;
//- (BOOL)validateGroup:(id *)value_ error:(NSError **)error_;

@property (nonatomic, retain) BAPrototype *prototype;
//- (BOOL)validatePrototype:(id *)value_ error:(NSError **)error_;

@property (nonatomic, retain) BATransform *transform;
//- (BOOL)validateTransform:(id *)value_ error:(NSError **)error_;


// Fetched Properties

// Fetch Requests

@end


@interface _BAProp (CoreDataGeneratedAccessors)

@end


@interface _BAProp (CoreDataGeneratedPrimitiveAccessors)

- (NSData *)primitiveBoundsData;
- (void)setPrimitiveBoundsData:(NSData *)value;

- (NSString *)primitiveName;
- (void)setPrimitiveName:(NSString *)value;

- (BAColor *)primitiveColor;
- (void)setPrimitiveColor:(BAColor *)value;
- (BAPropGroup *)primitiveGroup;
- (void)setPrimitiveGroup:(BAPropGroup *)value;
- (BAPrototype *)primitivePrototype;
- (void)setPrimitivePrototype:(BAPrototype *)value;
- (BATransform *)primitiveTransform;
- (void)setPrimitiveTransform:(BATransform *)value;

@end
