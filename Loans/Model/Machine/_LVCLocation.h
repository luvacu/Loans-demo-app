// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LVCLocation.h instead.

#import <CoreData/CoreData.h>

extern const struct LVCLocationAttributes {
	__unsafe_unretained NSString *country;
	__unsafe_unretained NSString *countryCode;
	__unsafe_unretained NSString *latitude;
	__unsafe_unretained NSString *longitude;
	__unsafe_unretained NSString *town;
} LVCLocationAttributes;

extern const struct LVCLocationRelationships {
	__unsafe_unretained NSString *loan;
} LVCLocationRelationships;

@class LVCLoan;

@interface LVCLocationID : NSManagedObjectID {}
@end

@interface _LVCLocation : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LVCLocationID* objectID;

@property (nonatomic, strong) NSString* country;

//- (BOOL)validateCountry:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* countryCode;

//- (BOOL)validateCountryCode:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* latitude;

@property (atomic) double latitudeValue;
- (double)latitudeValue;
- (void)setLatitudeValue:(double)value_;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* longitude;

@property (atomic) double longitudeValue;
- (double)longitudeValue;
- (void)setLongitudeValue:(double)value_;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* town;

//- (BOOL)validateTown:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) LVCLoan *loan;

//- (BOOL)validateLoan:(id*)value_ error:(NSError**)error_;

@end

@interface _LVCLocation (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCountry;
- (void)setPrimitiveCountry:(NSString*)value;

- (NSString*)primitiveCountryCode;
- (void)setPrimitiveCountryCode:(NSString*)value;

- (NSNumber*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSNumber*)value;

- (double)primitiveLatitudeValue;
- (void)setPrimitiveLatitudeValue:(double)value_;

- (NSNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSNumber*)value;

- (double)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(double)value_;

- (NSString*)primitiveTown;
- (void)setPrimitiveTown:(NSString*)value;

- (LVCLoan*)primitiveLoan;
- (void)setPrimitiveLoan:(LVCLoan*)value;

@end
