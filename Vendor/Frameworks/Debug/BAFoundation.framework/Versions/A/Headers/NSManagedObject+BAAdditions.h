//
//  NSManagedObject+BAAdditions.h
//  Bored Astronaut Additions
//
//  Created by Brent Gulanowski on 24/02/08.
//  Copyright 2008 Bored Astronaut. All rights reserved.
//

#import <CoreData/CoreData.h>


#define RELATIONSHIP_PROPERTY_TYPE ((NSAttributeType)8000)


extern NSString *kBAIntegerTransformerName;
//extern NSString *kBADecimalTransformerName;
extern NSString *kBAFloatTransformerName;
extern NSString *kBADateTransformerName;


@interface NSManagedObject (BAAdditions)

@property (readonly) NSArray *attributeNames;
@property (readonly) NSArray *editableAttributeNames;
@property (readonly) NSArray *relationshipNames;

@property (readonly) NSString *objectIDString;
@property (readonly) NSString *objectIDAsFileName;
@property (readonly) NSString *stringRepresentation;
@property (readonly) NSString *listString;

+ (NSManagedObject *)insertObjectInManagedObjectContext:(NSManagedObjectContext *)context;
+ (NSManagedObject *)insertObject;

+ (NSString *)entityName;

+ (NSString *)defaultSortKey;
+ (BOOL)defaultSortAscending;
+ (NSArray *)defaultSortDescriptors;

- (id)valueForDataKey:(NSString *)aKey;
- (void)setValue:(id)anObj forDataKey:(NSString *)aKey;

- (int)intForKey:(NSString *)aKey;
- (void)setInt:(int)anInt forKey:(NSString *)aKey;

- (NSAttributeDescription *)attributeForName:(NSString *)name;
- (NSAttributeDescription *)attributeForKeyPath:(NSString *)keyPath;

- (NSUInteger)countOfRelationship:(NSString *)relationshipName;
- (NSRelationshipDescription *)relationshipForName:(NSString *)name;

- (NSUInteger)countOfFetchedProperty:(NSString *)propertyName;
// In the case where a fetched property is a cover for a filtered relationship, use this to find the relationship
// It only works if the entity has a single to-many relationship with destination entity
- (NSRelationshipDescription *)relationshipForFetchedProperty:(NSString *)propertyName;

- (NSArray *)relationshipProxies;
- (NSArray *)virtualRelationshipProxies; // includes fetched properties

// Subclasses should override for performance
- (NSAttributeType)attributeTypeForProperty:(NSString **)ioName owner:(NSManagedObject **)oOwner;
- (NSAttributeType)attributeTypeForProperty:(NSString *)propertyName;

+ (NSString *)stringForValue:(id)value attributeType:(NSAttributeType)type;
+ (id)transformedValueForString:(NSString *)value attributeType:(NSAttributeType)type;

- (NSString *)stringValueForAttribute:(NSString *)attrName;
- (void)setStringValue:(NSString *)value forAttribute:(NSString *)attribute;

- (NSString *)stringValueForProperty:(NSString *)propertyName;
- (void)setStringValue:(NSString *)value forProperty:(NSString *)propertyName;

- (void)setValuesForAttributesWithDictionary:(NSDictionary *)keyedValues safe:(BOOL)safe;
- (void)setValuesForRelationshipsWithDictionary:(NSDictionary *)keyedValues safe:(BOOL)safe;
- (void)setValuesWithPropertyList:(NSDictionary *)plist;

- (NSArray *)sortDescriptorsForRelationship:(NSString *)relName;
- (id)objectInRelationship:(NSString *)relName atIndex:(NSUInteger)index;

- (NSManagedObject *)insertNewObjectForProperty:(NSString *)relName;
 // relies on -objectInRelationship:atIndex:
- (void)removeObjectFromRelationship:(NSString *)relName atIndex:(NSUInteger)index;

@end
