// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BAGroup.h instead.

#import <CoreData/CoreData.h>


@class BAProp;
@class BAGroup;
@class BAGroup;






@interface BAGroupID : NSManagedObjectID {}
@end

@interface _BAGroup : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BAGroupID*)objectID;




@property (nonatomic, retain) NSData *boundsData;


//- (BOOL)validateBoundsData:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *flattened;


@property BOOL flattenedValue;
- (BOOL)flattenedValue;
- (void)setFlattenedValue:(BOOL)value_;

//- (BOOL)validateFlattened:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *mergedPropName;


//- (BOOL)validateMergedPropName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSString *name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) NSSet* props;

- (NSMutableSet*)propsSet;




@property (nonatomic, retain) NSSet* subgroups;

- (NSMutableSet*)subgroupsSet;




@property (nonatomic, retain) BAGroup* supergroup;

//- (BOOL)validateSupergroup:(id*)value_ error:(NSError**)error_;




@end

@interface _BAGroup (CoreDataGeneratedAccessors)

- (void)addProps:(NSSet*)value_;
- (void)removeProps:(NSSet*)value_;
- (void)addPropsObject:(BAProp*)value_;
- (void)removePropsObject:(BAProp*)value_;

- (void)addSubgroups:(NSSet*)value_;
- (void)removeSubgroups:(NSSet*)value_;
- (void)addSubgroupsObject:(BAGroup*)value_;
- (void)removeSubgroupsObject:(BAGroup*)value_;

@end

@interface _BAGroup (CoreDataGeneratedPrimitiveAccessors)


- (NSData*)primitiveBoundsData;
- (void)setPrimitiveBoundsData:(NSData*)value;




- (NSNumber*)primitiveFlattened;
- (void)setPrimitiveFlattened:(NSNumber*)value;

- (BOOL)primitiveFlattenedValue;
- (void)setPrimitiveFlattenedValue:(BOOL)value_;




- (NSString*)primitiveMergedPropName;
- (void)setPrimitiveMergedPropName:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;





- (NSMutableSet*)primitiveProps;
- (void)setPrimitiveProps:(NSMutableSet*)value;



- (NSMutableSet*)primitiveSubgroups;
- (void)setPrimitiveSubgroups:(NSMutableSet*)value;



- (BAGroup*)primitiveSupergroup;
- (void)setPrimitiveSupergroup:(BAGroup*)value;


@end
