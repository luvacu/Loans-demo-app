// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LVCLoan.h instead.

#import <CoreData/CoreData.h>

extern const struct LVCLoanAttributes {
	__unsafe_unretained NSString *activity;
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *sector;
	__unsafe_unretained NSString *status;
} LVCLoanAttributes;

extern const struct LVCLoanRelationships {
	__unsafe_unretained NSString *location;
} LVCLoanRelationships;

@class LVCLocation;

@interface LVCLoanID : NSManagedObjectID {}
@end

@interface _LVCLoan : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LVCLoanID* objectID;

@property (nonatomic, strong) NSString* activity;

//- (BOOL)validateActivity:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* id;

@property (atomic) int64_t idValue;
- (int64_t)idValue;
- (void)setIdValue:(int64_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* sector;

//- (BOOL)validateSector:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* status;

//- (BOOL)validateStatus:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) LVCLocation *location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;

@end

@interface _LVCLoan (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveActivity;
- (void)setPrimitiveActivity:(NSString*)value;

- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int64_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int64_t)value_;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveSector;
- (void)setPrimitiveSector:(NSString*)value;

- (NSString*)primitiveStatus;
- (void)setPrimitiveStatus:(NSString*)value;

- (LVCLocation*)primitiveLocation;
- (void)setPrimitiveLocation:(LVCLocation*)value;

@end
