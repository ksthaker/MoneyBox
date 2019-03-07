//
//  Scheduale_Event.h
//  LIAAM
//
//  Created by sunil on 8/5/14.
//  Copyright (c) 2014 sunil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Scheduale_Event : NSObject


+(void)CancelExistingNotification:(NSString *)notification_ID;
+(void)scheduleLocalNotificationWithDate:(NSDate *)fireDate atIndex:(NSString *)notification_ID Description:(NSString *)string repeat:(NSString *)repeatInterval;
@end
