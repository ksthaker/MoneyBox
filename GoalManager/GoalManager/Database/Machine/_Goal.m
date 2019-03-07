// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Goal.m instead.

#import "_Goal.h"

@implementation GoalID
@end

@implementation _Goal

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Goal" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Goal";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Goal" inManagedObjectContext:moc_];
}

- (GoalID*)objectID {
	return (GoalID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic g_amount;

@dynamic g_completedstatus;

@dynamic g_contributedamount;

@dynamic g_creationdate;

@dynamic g_currency;

@dynamic g_eighty;

@dynamic g_fifty;

@dynamic g_picture;

@dynamic g_reminderdate;

@dynamic g_reminderday;

@dynamic g_remindertime;

@dynamic g_savingaccount;

@dynamic g_savingfrequency;

@dynamic g_setsavingreminder;

@dynamic g_targetdate;

@dynamic g_title;

@dynamic r_contribution;

- (NSMutableSet<Contribution*>*)r_contributionSet {
	[self willAccessValueForKey:@"r_contribution"];

	NSMutableSet<Contribution*> *result = (NSMutableSet<Contribution*>*)[self mutableSetValueForKey:@"r_contribution"];

	[self didAccessValueForKey:@"r_contribution"];
	return result;
}

@end

@implementation GoalAttributes 
+ (NSString *)g_amount {
	return @"g_amount";
}
+ (NSString *)g_completedstatus {
	return @"g_completedstatus";
}
+ (NSString *)g_contributedamount {
	return @"g_contributedamount";
}
+ (NSString *)g_creationdate {
	return @"g_creationdate";
}
+ (NSString *)g_currency {
	return @"g_currency";
}
+ (NSString *)g_eighty {
	return @"g_eighty";
}
+ (NSString *)g_fifty {
	return @"g_fifty";
}
+ (NSString *)g_picture {
	return @"g_picture";
}
+ (NSString *)g_reminderdate {
	return @"g_reminderdate";
}
+ (NSString *)g_reminderday {
	return @"g_reminderday";
}
+ (NSString *)g_remindertime {
	return @"g_remindertime";
}
+ (NSString *)g_savingaccount {
	return @"g_savingaccount";
}
+ (NSString *)g_savingfrequency {
	return @"g_savingfrequency";
}
+ (NSString *)g_setsavingreminder {
	return @"g_setsavingreminder";
}
+ (NSString *)g_targetdate {
	return @"g_targetdate";
}
+ (NSString *)g_title {
	return @"g_title";
}
@end

@implementation GoalRelationships 
+ (NSString *)r_contribution {
	return @"r_contribution";
}
@end

