// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BAColor.h instead.

#import <CoreData/CoreData.h>


@class BAColor, BAColorID;

@interface NSManagedObjectContext (BAColorConveniences)

- (BAColor *)findBAColorWithID:(BAColorID *)objectID;
- (BAColor *)insertBAColor;

- (NSUInteger)countOfColorObjectsWithPredicate:(NSPredicate *)predicate;
- (NSUInteger)countOfColorObjectsWithValue:(id)value forKey:(NSString *)key;
- (NSUInteger)countOfColorObjects;

@end


@class BAPoint;
@class BAProp;
@class BAPrototypeMesh;

@interface BAColorID : NSManagedObjectID {}
@end


@interface _BAColor : NSManagedObject {}

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BAColorID*)objectID;

// Attributes
@property (nonatomic, retain) NSNumber *a;
@property float aValue;
- (float)aValue;
- (void)setAValue:(float)value_;
//- (BOOL)validateA:(id *)value_ error:(NSError **)error_;

@property (nonatomic, retain) NSNumber *b;
@property float bValue;
- (float)bValue;
- (void)setBValue:(float)value_;
//- (BOOL)validateB:(id *)value_ error:(NSError **)error_;

@property (nonatomic, retain) NSNumber *g;
@property float gValue;
- (float)gValue;
- (void)setGValue:(float)value_;
//- (BOOL)validateG:(id *)value_ error:(NSError **)error_;

@property (nonatomic, retain) NSNumber *r;
@property float rValue;
- (float)rValue;
- (void)setRValue:(float)value_;
//- (BOOL)validateR:(id *)value_ error:(NSError **)error_;


// Relationships
@property (nonatomic, retain) NSSet *points;
- (NSMutableSet*)pointsSet;

@property (nonatomic, retain) NSSet *props;
- (NSMutableSet*)propsSet;

@property (nonatomic, retain) NSSet *prototypeMeshes;
- (NSMutableSet*)prototypeMeshesSet;


// Fetched Properties

// Fetch Requests

@end


@interface _BAColor (CoreDataGeneratedAccessors)

- (void)addPoints:(NSSet *)value_;
- (void)removePoints:(NSSet *)value_;
- (void)addPointsObject:(BAPoint *)value_;
- (void)removePointsObject:(BAPoint *)value_;

- (void)addProps:(NSSet *)value_;
- (void)removeProps:(NSSet *)value_;
- (void)addPropsObject:(BAProp *)value_;
- (void)removePropsObject:(BAProp *)value_;

- (void)addPrototypeMeshes:(NSSet *)value_;
- (void)removePrototypeMeshes:(NSSet *)value_;
- (void)addPrototypeMeshesObject:(BAPrototypeMesh *)value_;
- (void)removePrototypeMeshesObject:(BAPrototypeMesh *)value_;

@end


@interface _BAColor (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber *)primitiveA;
- (void)setPrimitiveA:(NSNumber *)value;

- (float)primitiveAValue;
- (void)setPrimitiveAValue:(float)value_;

- (NSNumber *)primitiveB;
- (void)setPrimitiveB:(NSNumber *)value;

- (float)primitiveBValue;
- (void)setPrimitiveBValue:(float)value_;

- (NSNumber *)primitiveG;
- (void)setPrimitiveG:(NSNumber *)value;

- (float)primitiveGValue;
- (void)setPrimitiveGValue:(float)value_;

- (NSNumber *)primitiveR;
- (void)setPrimitiveR:(NSNumber *)value;

- (float)primitiveRValue;
- (void)setPrimitiveRValue:(float)value_;


- (NSMutableSet *)primitivePoints;
- (void)setPrimitivePoints:(NSMutableSet *)value;

- (NSMutableSet *)primitiveProps;
- (void)setPrimitiveProps:(NSMutableSet *)value;

- (NSMutableSet *)primitivePrototypeMeshes;
- (void)setPrimitivePrototypeMeshes:(NSMutableSet *)value;

@end
