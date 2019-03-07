// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Contribution.m instead.

#import "_Contribution.h"

@implementation ContributionID
@end

@implementation _Contribution

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Contribution" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Contribution";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Contribution" inManagedObjectContext:moc_];
}

- (ContributionID*)objectID {
	return (ContributionID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic c_amount;

@dynamic c_date;

@dynamic c_notes;

@dynamic r_goal;

@end

@implementation ContributionAttributes 
+ (NSString *)c_amount {
	return @"c_amount";
}
+ (NSString *)c_date {
	return @"c_date";
}
+ (NSString *)c_notes {
	return @"c_notes";
}
@end

@implementation ContributionRelationships 
+ (NSString *)r_goal {
	return @"r_goal";
}
@end

