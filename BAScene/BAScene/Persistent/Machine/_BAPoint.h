// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BAPoint.h instead.

#import <CoreData/CoreData.h>


@class BAPoint, BAPointID;

@interface NSManagedObjectContext (BAPointConveniences)

- (BAPoint *)findBAPointWithID:(BAPointID *)objectID;
- (BAPoint *)insertBAPoint;

- (NSUInteger)countOfPointObjectsWithPredicate:(NSPredicate *)predicate;
- (NSUInteger)countOfPointObjectsWithValue:(id)value forKey:(NSString *)key;
- (NSUInteger)countOfPointObjects;

@end


@class BAColor;
@class BAMesh;
@class BAPolygon;
@class BATuple;

@interface BAPointID : NSManagedObjectID {}
@end


@interface _BAPoint : NSManagedObject {}

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BAPointID*)objectID;

// Attributes
@property (nonatomic, retain) NSNumber *index;
@property int16_t indexValue;
- (int16_t)indexValue;
- (void)setIndexValue:(int16_t)value_;
//- (BOOL)validateIndex:(id *)value_ error:(NSError **)error_;


// Relationships
@property (nonatomic, retain) BAColor *color;
//- (BOOL)validateColor:(id *)value_ error:(NSError **)error_;

@property (nonatomic, retain) BATuple *normal;
//- (BOOL)validateNormal:(id *)value_ error:(NSError **)error_;

@property (nonatomic, retain) BAPolygon *polygon;
//- (BOOL)validatePolygon:(id *)value_ error:(NSError **)error_;

@property (nonatomic, retain) BATuple *texCoord;
//- (BOOL)validateTexCoord:(id *)value_ error:(NSError **)error_;

@property (nonatomic, retain) BATuple *vertex;
//- (BOOL)validateVertex:(id *)value_ error:(NSError **)error_;


// Fetched Properties

// Fetch Requests
+ (NSArray *)fetchConnected:(NSManagedObjectContext *)moc_ sortDescriptors:(NSArray *)sortDescriptors MESH:(BAMesh *)MESH_ ;
+ (NSArray *)fetchConnected:(NSManagedObjectContext *)moc_ sortDescriptors:(NSArray *)sortDescriptors MESH:(BAMesh *)MESH_ error:(NSError **)error_;
+ (NSArray *)fetchRelated:(NSManagedObjectContext *)moc_ sortDescriptors:(NSArray *)sortDescriptors POLYGON:(BAPolygon *)POLYGON_ ;
+ (NSArray *)fetchRelated:(NSManagedObjectContext *)moc_ sortDescriptors:(NSArray *)sortDescriptors POLYGON:(BAPolygon *)POLYGON_ error:(NSError **)error_;

@end


@interface _BAPoint (CoreDataGeneratedAccessors)

@end


@interface _BAPoint (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber *)primitiveIndex;
- (void)setPrimitiveIndex:(NSNumber *)value;

- (int16_t)primitiveIndexValue;
- (void)setPrimitiveIndexValue:(int16_t)value_;

- (BAColor *)primitiveColor;
- (void)setPrimitiveColor:(BAColor *)value;
- (BATuple *)primitiveNormal;
- (void)setPrimitiveNormal:(BATuple *)value;
- (BAPolygon *)primitivePolygon;
- (void)setPrimitivePolygon:(BAPolygon *)value;
- (BATuple *)primitiveTexCoord;
- (void)setPrimitiveTexCoord:(BATuple *)value;
- (BATuple *)primitiveVertex;
- (void)setPrimitiveVertex:(BATuple *)value;

@end
