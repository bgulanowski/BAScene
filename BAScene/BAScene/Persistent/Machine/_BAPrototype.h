// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BAPrototype.h instead.

#import <CoreData/CoreData.h>


@class BAPrototype, BAPrototypeID;

@interface NSManagedObjectContext (BAPrototypeConveniences)

- (BAPrototype *)findBAPrototypeWithID:(BAPrototypeID *)objectID;
- (BAPrototype *)insertBAPrototype;

- (NSUInteger)countOfPrototypeObjectsWithPredicate:(NSPredicate *)predicate;
- (NSUInteger)countOfPrototypeObjectsWithValue:(id)value forKey:(NSString *)key;
- (NSUInteger)countOfPrototypeObjects;

@end


@class BAProp;
@class BAPrototypeMesh;

@interface BAPrototypeID : NSManagedObjectID {}
@end


@interface _BAPrototype : NSManagedObject {}

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BAPrototypeID*)objectID;

// Attributes
@property (nonatomic, retain) NSString *name;
//- (BOOL)validateName:(id *)value_ error:(NSError **)error_;


// Relationships
@property (nonatomic, retain) NSSet *props;
- (NSMutableSet*)propsSet;

@property (nonatomic, retain) NSSet *prototypeMeshes;
- (NSMutableSet*)prototypeMeshesSet;


// Fetched Properties

// Fetch Requests

@end


@interface _BAPrototype (CoreDataGeneratedAccessors)

- (void)addProps:(NSSet *)value_;
- (void)removeProps:(NSSet *)value_;
- (void)addPropsObject:(BAProp *)value_;
- (void)removePropsObject:(BAProp *)value_;

- (void)addPrototypeMeshes:(NSSet *)value_;
- (void)removePrototypeMeshes:(NSSet *)value_;
- (void)addPrototypeMeshesObject:(BAPrototypeMesh *)value_;
- (void)removePrototypeMeshesObject:(BAPrototypeMesh *)value_;

@end


@interface _BAPrototype (CoreDataGeneratedPrimitiveAccessors)

- (NSString *)primitiveName;
- (void)setPrimitiveName:(NSString *)value;


- (NSMutableSet *)primitiveProps;
- (void)setPrimitiveProps:(NSMutableSet *)value;

- (NSMutableSet *)primitivePrototypeMeshes;
- (void)setPrimitivePrototypeMeshes:(NSMutableSet *)value;

@end
