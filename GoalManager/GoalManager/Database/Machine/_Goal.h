// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Goal.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class Contribution;

@interface GoalID : NSManagedObjectID {}
@end

@interface _Goal : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) GoalID *objectID;

@property (nonatomic, strong, nullable) NSString* g_amount;

@property (nonatomic, strong, nullable) NSString* g_completedstatus;

@property (nonatomic, strong, nullable) NSString* g_contributedamount;

@property (nonatomic, strong, nullable) NSString* g_creationdate;

@property (nonatomic, strong, nullable) NSString* g_currency;

@property (nonatomic, strong, nullable) NSString* g_eighty;

@property (nonatomic, strong, nullable) NSString* g_fifty;

@property (nonatomic, strong, nullable) NSData* g_picture;

@property (nonatomic, strong, nullable) NSString* g_reminderdate;

@property (nonatomic, strong, nullable) NSString* g_reminderday;

@property (nonatomic, strong, nullable) NSString* g_remindertime;

@property (nonatomic, strong, nullable) NSString* g_savingaccount;

@property (nonatomic, strong, nullable) NSString* g_savingfrequency;

@property (nonatomic, strong, nullable) NSString* g_setsavingreminder;

@property (nonatomic, strong, nullable) NSString* g_targetdate;

@property (nonatomic, strong, nullable) NSString* g_title;

@property (nonatomic, strong, nullable) NSSet<Contribution*> *r_contribution;
- (nullable NSMutableSet<Contribution*>*)r_contributionSet;

@end

@interface _Goal (R_contributionCoreDataGeneratedAccessors)
- (void)addR_contribution:(NSSet<Contribution*>*)value_;
- (void)removeR_contribution:(NSSet<Contribution*>*)value_;
- (void)addR_contributionObject:(Contribution*)value_;
- (void)removeR_contributionObject:(Contribution*)value_;

@end

@interface _Goal (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitiveG_amount;
- (void)setPrimitiveG_amount:(nullable NSString*)value;

- (nullable NSString*)primitiveG_completedstatus;
- (void)setPrimitiveG_completedstatus:(nullable NSString*)value;

- (nullable NSString*)primitiveG_contributedamount;
- (void)setPrimitiveG_contributedamount:(nullable NSString*)value;

- (nullable NSString*)primitiveG_creationdate;
- (void)setPrimitiveG_creationdate:(nullable NSString*)value;

- (nullable NSString*)primitiveG_currency;
- (void)setPrimitiveG_currency:(nullable NSString*)value;

- (nullable NSString*)primitiveG_eighty;
- (void)setPrimitiveG_eighty:(nullable NSString*)value;

- (nullable NSString*)primitiveG_fifty;
- (void)setPrimitiveG_fifty:(nullable NSString*)value;

- (nullable NSData*)primitiveG_picture;
- (void)setPrimitiveG_picture:(nullable NSData*)value;

- (nullable NSString*)primitiveG_reminderdate;
- (void)setPrimitiveG_reminderdate:(nullable NSString*)value;

- (nullable NSString*)primitiveG_reminderday;
- (void)setPrimitiveG_reminderday:(nullable NSString*)value;

- (nullable NSString*)primitiveG_remindertime;
- (void)setPrimitiveG_remindertime:(nullable NSString*)value;

- (nullable NSString*)primitiveG_savingaccount;
- (void)setPrimitiveG_savingaccount:(nullable NSString*)value;

- (nullable NSString*)primitiveG_savingfrequency;
- (void)setPrimitiveG_savingfrequency:(nullable NSString*)value;

- (nullable NSString*)primitiveG_setsavingreminder;
- (void)setPrimitiveG_setsavingreminder:(nullable NSString*)value;

- (nullable NSString*)primitiveG_targetdate;
- (void)setPrimitiveG_targetdate:(nullable NSString*)value;

- (nullable NSString*)primitiveG_title;
- (void)setPrimitiveG_title:(nullable NSString*)value;

- (NSMutableSet<Contribution*>*)primitiveR_contribution;
- (void)setPrimitiveR_contribution:(NSMutableSet<Contribution*>*)value;

@end

@interface GoalAttributes: NSObject 
+ (NSString *)g_amount;
+ (NSString *)g_completedstatus;
+ (NSString *)g_contributedamount;
+ (NSString *)g_creationdate;
+ (NSString *)g_currency;
+ (NSString *)g_eighty;
+ (NSString *)g_fifty;
+ (NSString *)g_picture;
+ (NSString *)g_reminderdate;
+ (NSString *)g_reminderday;
+ (NSString *)g_remindertime;
+ (NSString *)g_savingaccount;
+ (NSString *)g_savingfrequency;
+ (NSString *)g_setsavingreminder;
+ (NSString *)g_targetdate;
+ (NSString *)g_title;
@end

@interface GoalRelationships: NSObject
+ (NSString *)r_contribution;
@end

NS_ASSUME_NONNULL_END
