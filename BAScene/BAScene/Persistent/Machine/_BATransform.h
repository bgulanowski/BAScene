// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BATransform.h instead.

#import <CoreData/CoreData.h>


@class BAProp;
@class BAPrototypeMesh;











@interface BATransformID : NSManagedObjectID {}
@end

@interface _BATransform : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BATransformID*)objectID;




@property (nonatomic, retain) NSNumber *lx;


@property double lxValue;
- (double)lxValue;
- (void)setLxValue:(double)value_;

//- (BOOL)validateLx:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *ly;


@property double lyValue;
- (double)lyValue;
- (void)setLyValue:(double)value_;

//- (BOOL)validateLy:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *lz;


@property double lzValue;
- (double)lzValue;
- (void)setLzValue:(double)value_;

//- (BOOL)validateLz:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *rx;


@property double rxValue;
- (double)rxValue;
- (void)setRxValue:(double)value_;

//- (BOOL)validateRx:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *ry;


@property double ryValue;
- (double)ryValue;
- (void)setRyValue:(double)value_;

//- (BOOL)validateRy:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *rz;


@property double rzValue;
- (double)rzValue;
- (void)setRzValue:(double)value_;

//- (BOOL)validateRz:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *sx;


@property double sxValue;
- (double)sxValue;
- (void)setSxValue:(double)value_;

//- (BOOL)validateSx:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *sy;


@property double syValue;
- (double)syValue;
- (void)setSyValue:(double)value_;

//- (BOOL)validateSy:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *sz;


@property double szValue;
- (double)szValue;
- (void)setSzValue:(double)value_;

//- (BOOL)validateSz:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) BAProp* prop;

//- (BOOL)validateProp:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) BAPrototypeMesh* protypeMesh;

//- (BOOL)validateProtypeMesh:(id*)value_ error:(NSError**)error_;




@end

@interface _BATransform (CoreDataGeneratedAccessors)

@end

@interface _BATransform (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveLx;
- (void)setPrimitiveLx:(NSNumber*)value;

- (double)primitiveLxValue;
- (void)setPrimitiveLxValue:(double)value_;




- (NSNumber*)primitiveLy;
- (void)setPrimitiveLy:(NSNumber*)value;

- (double)primitiveLyValue;
- (void)setPrimitiveLyValue:(double)value_;




- (NSNumber*)primitiveLz;
- (void)setPrimitiveLz:(NSNumber*)value;

- (double)primitiveLzValue;
- (void)setPrimitiveLzValue:(double)value_;




- (NSNumber*)primitiveRx;
- (void)setPrimitiveRx:(NSNumber*)value;

- (double)primitiveRxValue;
- (void)setPrimitiveRxValue:(double)value_;




- (NSNumber*)primitiveRy;
- (void)setPrimitiveRy:(NSNumber*)value;

- (double)primitiveRyValue;
- (void)setPrimitiveRyValue:(double)value_;




- (NSNumber*)primitiveRz;
- (void)setPrimitiveRz:(NSNumber*)value;

- (double)primitiveRzValue;
- (void)setPrimitiveRzValue:(double)value_;




- (NSNumber*)primitiveSx;
- (void)setPrimitiveSx:(NSNumber*)value;

- (double)primitiveSxValue;
- (void)setPrimitiveSxValue:(double)value_;




- (NSNumber*)primitiveSy;
- (void)setPrimitiveSy:(NSNumber*)value;

- (double)primitiveSyValue;
- (void)setPrimitiveSyValue:(double)value_;




- (NSNumber*)primitiveSz;
- (void)setPrimitiveSz:(NSNumber*)value;

- (double)primitiveSzValue;
- (void)setPrimitiveSzValue:(double)value_;





- (BAProp*)primitiveProp;
- (void)setPrimitiveProp:(BAProp*)value;



- (BAPrototypeMesh*)primitiveProtypeMesh;
- (void)setPrimitiveProtypeMesh:(BAPrototypeMesh*)value;


@end
