//
//  Scheduale_Event.m
//  LIAAM
//
//  Created by sunil on 8/5/14.
//  Copyright (c) 2014 sunil. All rights reserved.
//

#import "Scheduale_Event.h"

@implementation Scheduale_Event


+(void)CancelExistingNotification:(NSString *)notification_ID
{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    
    for (int i=0; i<[eventArray count]; i++)
    {
        UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
        NSDictionary *userInfoCurrent = oneEvent.userInfo;
        NSString *uid=[NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:@"notificationID"]];
        if ([uid isEqualToString:notification_ID])
        {            
            [app cancelLocalNotification:oneEvent];
            break;
        }
    }
}
+(void)scheduleLocalNotificationWithDate:(NSDate *)fireDate atIndex:(NSString *)notification_ID Description:(NSString *)string repeat:(NSString *)repeatInterval
{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    if (!localNotification)
        return;
    
    [localNotification setTimeZone:[NSTimeZone defaultTimeZone]];
    // Setup alert notification
    [localNotification setFireDate:fireDate];
    [localNotification setAlertBody:string];
    [localNotification setAlertAction:@"Open App"];
    [localNotification setHasAction:YES];
    localNotification.soundName = @"Alarm_Tone123.mp3";
    
    if ([repeatInterval isEqualToString:@"Daily"])
    {
        
        //        [localNotification setFireDate:[fireDate dateByAddingTimeInterval:(60*60*24*1)]];
        localNotification.repeatInterval = NSCalendarUnitDay;
    }
    else if ([repeatInterval isEqualToString:@"Weekly"])
    {
        //        localNotification.repeatInterval = NSWeekCalendarUnit;
        //
        
        //        [localNotification setFireDate:[fireDate dateByAddingTimeInterval:(60*60*24*7)]];
        localNotification.repeatInterval = NSCalendarUnitWeekOfYear;
        NSLog(@"%lu",localNotification.repeatInterval);
    }
    else if ([repeatInterval isEqualToString:@"Bi-weekly"])
    {
        //        localNotification.repeatInterval = NSWeekCalendarUnit*2;
        //        NSLog(@"%lu",localNotification.repeatInterval);
        //        [localNotification setFireDate:[fireDate dateByAddingTimeInterval:(60*60*24*14)]];
        localNotification.repeatInterval = NSCalendarUnitWeekOfYear;
        NSLog(@"%lu",localNotification.repeatInterval);
    }
    else if ([repeatInterval isEqualToString:@"Monthly"])
    {
        //        localNotification.repeatInterval = NSMonthCalendarUnit;
        //        NSLog(@"%lu",localNotification.repeatInterval);
        //        [localNotification setFireDate:[fireDate dateByAddingTimeInterval:(60*60*24*30)]];
        localNotification.repeatInterval = NSCalendarUnitMonth;
        NSLog(@"%lu",localNotification.repeatInterval);
    }
    
//    if ([repeatInterval isEqualToString:@"Daily"])
//    {
//        localNotification.repeatInterval = NSDayCalendarUnit;
//    }
//    else if ([repeatInterval isEqualToString:@"Weekly"])
//    {
//        localNotification.repeatInterval = NSWeekCalendarUnit;
//        //NSLog(@"%lu",localNotification.repeatInterval);
//    }
//    else if ([repeatInterval isEqualToString:@"Bi-weekly"])
//    {
//        localNotification.repeatInterval = NSWeekCalendarUnit*2;
//        //NSLog(@"%lu",localNotification.repeatInterval);
//    }
//    else if ([repeatInterval isEqualToString:@"Monthly"])
//    {
//        localNotification.repeatInterval = NSMonthCalendarUnit;
//        //NSLog(@"%lu",localNotification.repeatInterval);
//    }
//
//
//    [localNotification setFireDate:fireDate];
//    [localNotification setTimeZone:[NSTimeZone defaultTimeZone]];
//    // Setup alert notification
//    [localNotification setAlertBody:string];
//    [localNotification setAlertAction:@"Open App"];
//    [localNotification setHasAction:YES];
//    localNotification.soundName = @"Alarm_Tone123.mp3";
    localNotification.applicationIconBadgeNumber = 0;
    
    //This array maps the alarms uid to the index of the alarm so that we can cancel specific local notifications
    //NSNumber* uidToStore = [NSNumber numberWithInt:indexOfObject];
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:notification_ID forKey:@"notificationID"];
    localNotification.userInfo = userInfo;
    //NSLog(@"Uid Store in userInfo %@", [localNotification.userInfo objectForKey:@"notificationID"]);
    // Schedule the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

@end
