// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LVCLoan.m instead.

#import "_LVCLoan.h"

const struct LVCLoanAttributes LVCLoanAttributes = {
	.activity = @"activity",
	.id = @"id",
	.imageId = @"imageId",
	.name = @"name",
	.sector = @"sector",
	.status = @"status",
};

const struct LVCLoanRelationships LVCLoanRelationships = {
	.location = @"location",
};

@implementation LVCLoanID
@end

@implementation _LVCLoan

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Loan" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Loan";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Loan" inManagedObjectContext:moc_];
}

- (LVCLoanID*)objectID {
	return (LVCLoanID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"imageIdValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"imageId"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic activity;

@dynamic id;

- (int64_t)idValue {
	NSNumber *result = [self id];
	return [result longLongValue];
}

- (void)setIdValue:(int64_t)value_ {
	[self setId:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveIdValue {
	NSNumber *result = [self primitiveId];
	return [result longLongValue];
}

- (void)setPrimitiveIdValue:(int64_t)value_ {
	[self setPrimitiveId:[NSNumber numberWithLongLong:value_]];
}

@dynamic imageId;

- (int64_t)imageIdValue {
	NSNumber *result = [self imageId];
	return [result longLongValue];
}

- (void)setImageIdValue:(int64_t)value_ {
	[self setImageId:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveImageIdValue {
	NSNumber *result = [self primitiveImageId];
	return [result longLongValue];
}

- (void)setPrimitiveImageIdValue:(int64_t)value_ {
	[self setPrimitiveImageId:[NSNumber numberWithLongLong:value_]];
}

@dynamic name;

@dynamic sector;

@dynamic status;

@dynamic location;

@end

