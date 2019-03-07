//
//  AppDelegate.h
//  GoalManager
//
//  Created by apple on 10/11/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoreData+MagicalRecord.h"
#import <LocalAuthentication/LocalAuthentication.h>

#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import <FBSDKShareKit/FBSDKShareKit.h>
//#import <TwitterKit/TwitterKit.h>
@import Localytics;

#import "InAppRageIAPHelper.h"
#import "Flurry.h"
#import "LockScreen_VC.h"

@import GoogleMobileAds;


@import Firebase;

@interface GoalManagerAppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain)UINavigationController *initialViewController;

@property(nonatomic,retain)IBOutlet UIView *view_InitialScreen;

@property(nonatomic,retain)UIImageView *aView;

+(NSUserDefaults*)getdefaultvalue;
+(BOOL)connectedToNetwork;
+(GoalManagerAppDelegate*)sharedinstance;
+(NSString *)Change_String_Formate:(NSString *)string;



@end

