// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Contribution.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class Goal;

@interface ContributionID : NSManagedObjectID {}
@end

@interface _Contribution : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ContributionID *objectID;

@property (nonatomic, strong, nullable) NSString* c_amount;

@property (nonatomic, strong, nullable) NSString* c_date;

@property (nonatomic, strong, nullable) NSString* c_notes;

@property (nonatomic, strong, nullable) Goal *r_goal;

@end

@interface _Contribution (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitiveC_amount;
- (void)setPrimitiveC_amount:(nullable NSString*)value;

- (nullable NSString*)primitiveC_date;
- (void)setPrimitiveC_date:(nullable NSString*)value;

- (nullable NSString*)primitiveC_notes;
- (void)setPrimitiveC_notes:(nullable NSString*)value;

- (Goal*)primitiveR_goal;
- (void)setPrimitiveR_goal:(Goal*)value;

@end

@interface ContributionAttributes: NSObject 
+ (NSString *)c_amount;
+ (NSString *)c_date;
+ (NSString *)c_notes;
@end

@interface ContributionRelationships: NSObject
+ (NSString *)r_goal;
@end

NS_ASSUME_NONNULL_END
