//
//  AppDelegate.m
//  GoalManager
//
//  Created by apple on 10/11/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//





#import "GoalManagerAppDelegate.h"
#import "GoalManager.h"
#import "iRate.h"
#import "Reachability.h"

@interface GoalManagerAppDelegate ()

@end

static GoalManagerAppDelegate *delegate;
static NSUserDefaults *defaultvalue;

@implementation GoalManagerAppDelegate
@synthesize initialViewController;
@synthesize view_InitialScreen;


+(NSUserDefaults*)getdefaultvalue
{
    if (defaultvalue==nil) {
        defaultvalue=[NSUserDefaults standardUserDefaults];
        return defaultvalue;
    }
    return  defaultvalue;
    
}

+ (void)initialize
{
    [iRate sharedInstance].applicationBundleID = @"com.andrey.MoneyBoxFree";
    [iRate sharedInstance].appStoreID=959555672;
    [iRate sharedInstance].onlyPromptIfLatestVersion = YES;

    [iRate sharedInstance].daysUntilPrompt = 5;
    [iRate sharedInstance].usesUntilPrompt = 3;

    [iRate sharedInstance].declinedThisVersion = YES;
}


#pragma mark - Internet Connectivity Check
+(BOOL)connectedToNetwork
{
    BOOL isInternet = FALSE;
    Reachability* reachability = [Reachability reachabilityWithHostName:@"google.com"];
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if (remoteHostStatus == ReachableViaWWAN)
    {
        isInternet = TRUE;
    }
    else if (remoteHostStatus == ReachableViaWiFi)
    {
        isInternet = TRUE;
    }
    else
    {
        isInternet =FALSE;
    }
    return isInternet;
}

+(GoalManagerAppDelegate*)sharedinstance
{
    if (delegate==nil)
    {
        delegate=(GoalManagerAppDelegate*)[[UIApplication sharedApplication]delegate];
        return delegate;
    }
    return delegate;
}

+(NSString *)Change_String_Formate:(NSString *)string
{
    BOOL isFound = FALSE;
    
    if ([string rangeOfString:@"-"].location != NSNotFound)
    {
        string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
        isFound = TRUE;
    }
    
    NSMutableString *mustr_String=[[NSMutableString alloc] initWithFormat:@"%@",string];
    
    for(int i=mustr_String.length-6 ;i>0;i--)
    {
        [mustr_String insertString:@"," atIndex:i];
        i-=2;
    }
    
    if (isFound == TRUE)
    {
        [mustr_String insertString:@"-" atIndex:0];
    }
    return mustr_String;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"AppKilled"];
    
    [GADMobileAds configureWithApplicationID:@"ca-app-pub-5298130731078005~2971133772"];

    [Flurry setCrashReportingEnabled:YES];

    [Flurry startSession:@"XJR3F589HMVTKS74BJ7S"];

    [FIRApp configure];

    [FBSDKLoginButton class];
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
//    [[Twitter sharedInstance] startWithConsumerKey:@"hHM6kGQxJTmOMlfjzgd7bVQog" consumerSecret:@"GtlaGL4J6KioIwj6JcQRQl5DBQJGvkCR5AagFRhLT6lkJyzLeF"];
    //[Flurry setDebugLogEnabled:YES];
    
//    if ([[UIApplication sharedApplication]respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
//    {
//        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
//        
//        [[UIApplication sharedApplication] registerForRemoteNotifications];
//    }
//    else
//    {
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
//    }
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DefaultPrefs" ofType:@"plist"]]];
    
    [MagicalRecord setupAutoMigratingCoreDataStack];
    
    UIStoryboard  *storyboard=nil;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
    {
        [self.window setBackgroundColor:[UIColor blackColor]];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    else
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        [self.window setBackgroundColor:[UIColor blackColor]];
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
        
        [[UINavigationBar appearance]setTintColor:NavigationColor];
    else
    {
        [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
        [[UINavigationBar appearance]setBarTintColor:NavigationColor];
    }
    
    [[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    if (isiPhone5)
        storyboard = [UIStoryboard storyboardWithName:@"IPhone5" bundle:nil];
    else if(isiPhone6)
        storyboard = [UIStoryboard storyboardWithName:@"IPhone6" bundle:nil];
    else if(isiPhone6Plus)
        storyboard = [UIStoryboard storyboardWithName:@"IPhone6Plus" bundle:nil];
    else if(isiPhoneX)
        storyboard = [UIStoryboard storyboardWithName:@"IPhoneX" bundle:nil];
    else
        storyboard = [UIStoryboard storyboardWithName:@"IPhone4" bundle:nil];
    
    self.initialViewController = [[UINavigationController alloc] init];
    self.initialViewController = [storyboard instantiateInitialViewController];
    
    self.window.rootViewController = self.initialViewController;
    initialViewController.navigationBar.translucent=NO;
    
    [Flurry logAllPageViewsForTarget:self.initialViewController];
    
    if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"MasterCurrencyCode"]length]<=0)
    {
        NSLocale *theLocale = [NSLocale currentLocale];
        NSString *currencySymbol = [theLocale objectForKey:NSLocaleCurrencySymbol];
        NSString *currencyCode = [theLocale objectForKey:NSLocaleCurrencyCode];
        
//        NSString *currencySymbol = @"руб.";
//        NSString *currencyCode = @"RUB";
        
        [[GoalManagerAppDelegate getdefaultvalue]setObject:currencySymbol forKey:@"MasterCurrencySymbol"];
        [[GoalManagerAppDelegate getdefaultvalue]setObject:currencyCode forKey:@"MasterCurrencyCode"];
        
        [[GoalManagerAppDelegate getdefaultvalue]setObject:@"ON" forKey:@"MasterCurrency"];
    }
    
    [[GoalManagerAppDelegate getdefaultvalue]setObject:@"ON" forKey:@"MasterCurrency"];
    [self.window makeKeyAndVisible];
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:[InAppRageIAPHelper sharedHelper]];
    
    if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"LocalNotif"] length] <=0 || [[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"LocalNotif"]isEqualToString:@"(null)"])
    {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"LocalNotif"];
    }
    
    
    if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"SortingType"] length] <=0 || [[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"SortingType"]isEqualToString:@"(null)"])
    {
       [[GoalManagerAppDelegate getdefaultvalue]setObject:@"Alphabetically" forKey:@"SortingType"];
    }
    
    if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InAppPurchase"] length] <=0 || [[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InAppPurchase"]isEqualToString:@"(null)"])
    {
        [[GoalManagerAppDelegate getdefaultvalue]setObject:@"0" forKey:@"InAppPurchase"];
    }
    
    if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"CrossApp"] length] <=0 || [[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"CrossApp"]isEqualToString:@"(null)"])
    {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *majorVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        [[GoalManagerAppDelegate getdefaultvalue]setObject:majorVersion forKey:@"CrossApp"];
    }
    
    //[[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"InAppPurchase"];
    //[[GoalManagerAppDelegate getdefaultvalue]setObject:@"OFF" forKey:@"ShowTotals"];
    
    //[[Twitter sharedInstance] startWithConsumerKey:@"QDggL6xzPL3nLJCbECAKV9erg" consumerSecret:@"fTJ2l2eWg4p1gxsEk3fKoVfXjOt3UytH1GxZkRyC5m7uTubDne"];
    
    [Localytics autoIntegrate:@"2491e99149246d4c6b7e050-c9d5a87e-3d24-11e6-456a-00adad38bc8d" launchOptions:launchOptions];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    NSArray *subViewArray = [self.window subviews];
    for (id obj in subViewArray)
    {
        if (obj == self.view_InitialScreen) {
            [obj removeFromSuperview];
            
            if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InitialScreen1"] length] <=0 || [[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InitialScreen1"]isEqualToString:@"(null)"])
            {
                if ([[UIApplication sharedApplication] respondsToSelector:@selector(currentUserNotificationSettings)]){ // Check it's iOS 8 and above
                    UIUserNotificationSettings *grantedSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
                    [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"InitialScreen1"];
                    
                    //[[NSNotificationCenter defaultCenter]postNotificationName:@"CrossPromotion" object:self];
                    
                    if (grantedSettings.types == UIUserNotificationTypeNone) {
                        
                        if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"LocalNotifAsked"] isEqualToString:@"1"]) {
                            NSString *str_AlertTitle = [NSString stringWithFormat:NSLocalizedString(@"Money Box", nil)];
                            NSString *str_AlertText = [NSString stringWithFormat:NSLocalizedString(@"Notification are disallowed please make it enable from iphone's settings", nil)];
                            
                            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:str_AlertTitle message:str_AlertText delegate:self cancelButtonTitle:NSLocalizedString(@"Later", nil) otherButtonTitles:NSLocalizedString(@"Yes, Please", nil),nil];
                            alert.tag = 213;
                            [alert show];
                        }
                        else{
                            
 //                           [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"LocalNotifAsked"];
                            
//                            if ([[UIApplication sharedApplication]respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
//                            {
//                                [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
//
//                                [[UIApplication sharedApplication] registerForRemoteNotifications];
//                            }
//                            else
//                            {
//                                [[UIApplication sharedApplication] registerForRemoteNotifications];
//                            }
                            
//                            [Localytics tagEvent:@"Clicked on Yes, Please Notification"];
//                            [Flurry logEvent:@"Clicked on Yes, Please Notification"];
//                            [FIRAnalytics logEventWithName:@"Clicked_On_Yes_Notifications"
//                                                parameters:nil];
                            
                            NSString *str_AlertTitle = [NSString stringWithFormat:NSLocalizedString(@"Money Box", nil)];
                            NSString *str_AlertText = [NSString stringWithFormat:NSLocalizedString(@"Money Box needs your permission to remind you about your saving goals and payments. This will help you achieve your savings goals faster. Do you want it to remind you next time?", nil)];

                            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:str_AlertTitle message:str_AlertText delegate:self cancelButtonTitle:NSLocalizedString(@"Later", nil) otherButtonTitles:NSLocalizedString(@"Yes, Please", nil),nil];
                            alert.tag = 212;
                            [alert show];
                        }
                    }
                    else if (grantedSettings.types & UIUserNotificationTypeSound & UIUserNotificationTypeAlert){
                        NSLog(@"Sound and alert permissions");
                    }
                    else if (grantedSettings.types  & UIUserNotificationTypeAlert){
                        NSLog(@"Alert Permission Granted");
                    }
                }
            }
        }
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [Localytics tagEvent:@"Session End"];
    [Flurry logEvent:@"Session End"];
    [FIRAnalytics logEventWithName:@"Session_End" parameters:nil];
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    
    NSString *str_PasscodeOnTime = [[NSString alloc]init];
    str_PasscodeOnTime = [formatter stringFromDate:[NSDate date]];
    
    NSDate *startDate = [formatter dateFromString:[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"PasscodeOnTime"]];
    NSDate *endDate = [formatter dateFromString:str_PasscodeOnTime];
    
    NSTimeInterval timeDifference = [endDate timeIntervalSinceDate:startDate];
    
    double minutes = timeDifference / 60;
    
    if (minutes >= 5) {
        
        UIStoryboard  *storyboard=nil;
        if (isiPhone5)
            storyboard = [UIStoryboard storyboardWithName:@"IPhone5" bundle:nil];
        else if(isiPhone6)
            storyboard = [UIStoryboard storyboardWithName:@"IPhone6" bundle:nil];
        else if(isiPhone6Plus)
            storyboard = [UIStoryboard storyboardWithName:@"IPhone6Plus" bundle:nil];
        else if(isiPhoneX)
            storyboard = [UIStoryboard storyboardWithName:@"IPhoneX" bundle:nil];
        else
            storyboard = [UIStoryboard storyboardWithName:@"IPhone4" bundle:nil];
        
        if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"TouchID"]isEqualToString:@"ON"] && [[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"Passcode"]isEqualToString:@"ON"]){
            
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"Open" forKey:@"Alert"];
            
            LAContext *context = [[LAContext alloc] init];
            [context setLocalizedFallbackTitle:@""];
            NSError *error = nil;
            
            self.aView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIApplication sharedApplication].keyWindow.bounds.size.width, [UIApplication sharedApplication].keyWindow.bounds.size.height)];
            if (isiPhoneX) {
                self.aView.image = [UIImage imageNamed:@"iPhone6"];
            }
            else if (isiPhone6Plus) {
                self.aView.image = [UIImage imageNamed:@"iphone6p"];
            }
            else if (isiPhone6) {
                self.aView.image = [UIImage imageNamed:@"iPhone6"];
            }
            else if (isiPhone5) {
                self.aView.image = [UIImage imageNamed:@"iPhone5"];
            }
            else{
                self.aView.image = [UIImage imageNamed:@"iphon4"];
            }
            self.aView.backgroundColor = [UIColor whiteColor];
            
            [[UIApplication sharedApplication].keyWindow addSubview:self.aView];
            
            if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
                // Authenticate User
                [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                        localizedReason:@"Please authenticate to unlock Money Box"
                                  reply:^(BOOL success, NSError *error) {
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          
                                          if (success) {
                                              //[[GoalManagerAppDelegate getdefaultvalue]setObject:@"Close" forKey:@"Alert"];
                                              [self.aView removeFromSuperview];
                                              
                                          } else {
                                              
                                              LockScreen_VC *vc = [storyboard instantiateViewControllerWithIdentifier:@"LockScreen_VC"];
                                              vc.modalPresentationStyle = UIModalPresentationCurrentContext;
                                              vc.modalPresentationStyle = UIModalPresentationCustom;
                                              vc.view.backgroundColor = [UIColor whiteColor];
                                              vc.str_FromWhere = @"";
                                              [self.initialViewController presentViewController:vc animated:FALSE completion:^{
                                                  [self.aView removeFromSuperview];
                                              }];
                                              
//                                              NSString *str_Message = [[NSString alloc]init];
//                                              str_Message = [self evaluateAuthenticationPolicyMessageForLA:error.code];
//
//                                              UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"MoneyBox" message:str_Message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//                                              [alert3 show];
                                              
                                          }
                                      });
                                  }];
                
            } else {
                
                LockScreen_VC *vc = [storyboard instantiateViewControllerWithIdentifier:@"LockScreen_VC"];
                vc.modalPresentationStyle = UIModalPresentationCurrentContext;
                vc.modalPresentationStyle = UIModalPresentationCustom;
                vc.view.backgroundColor = [UIColor whiteColor];
                vc.str_FromWhere = @"";
                [self.initialViewController presentViewController:vc animated:FALSE completion:^{
                    [self.aView removeFromSuperview];
                }];
                
//                NSLog(@"%@",[self evaluateAuthenticationPolicyMessageForLA:error.code]);
//                NSString *str_Message = [[NSString alloc]init];
//                str_Message = [self evaluateAuthenticationPolicyMessageForLA:error.code];
//
//                UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"MoneyBox" message:str_Message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//
//                [alert3 show];
            }
            
        }
        else if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"TouchID"]isEqualToString:@"ON"] && [[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"Passcode"]isEqualToString:@"OFF"]){
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"Open" forKey:@"Alert"];
            LAContext *context = [[LAContext alloc] init];
            [context setLocalizedFallbackTitle:@""];
            NSError *error = nil;
            
            self.aView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIApplication sharedApplication].keyWindow.bounds.size.width, [UIApplication sharedApplication].keyWindow.bounds.size.height)];
            if (isiPhoneX) {
                self.aView.image = [UIImage imageNamed:@"iPhone6"];
            }
            else if (isiPhone6Plus) {
                self.aView.image = [UIImage imageNamed:@"iphone6p"];
            }
            else if (isiPhone6) {
                self.aView.image = [UIImage imageNamed:@"iPhone6"];
            }
            else if (isiPhone5) {
                self.aView.image = [UIImage imageNamed:@"iPhone5"];
            }
            else{
                self.aView.image = [UIImage imageNamed:@"iphon4"];
            }
            self.aView.backgroundColor = [UIColor whiteColor];
            
            [[UIApplication sharedApplication].keyWindow addSubview:self.aView];
            
            if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
                // Authenticate User
                [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                        localizedReason:@"Please authenticate to unlock Money Box"
                                  reply:^(BOOL success, NSError *error) {
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          
                                          if (success) {
                                              //[[GoalManagerAppDelegate getdefaultvalue]setObject:@"Close" forKey:@"Alert"];
                                              [self.aView removeFromSuperview];
                                              
                                          } else {
                                              
                                              
                                              
                                              NSString *str_Message = [[NSString alloc]init];
                                              str_Message = [self evaluateAuthenticationPolicyMessageForLA:error.code];
                                              
                                              UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"Touch ID" message:str_Message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                                              alert3.tag = 1234;
                                              [alert3 show];
                                              
                                          }
                                      });
                                  }];
                
            } else {
                
                
                //NSLog(@"%@",[self evaluateAuthenticationPolicyMessageForLA:error.code]);
                NSString *str_Message = [[NSString alloc]init];
                str_Message = [self evaluateAuthenticationPolicyMessageForLA:error.code];
                
                UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"Touch ID" message:str_Message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                alert3.tag = 1234;
                [alert3 show];
            }
            
        }
        else if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"TouchID"]isEqualToString:@"OFF"] && [[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"Passcode"]isEqualToString:@"ON"]){
            LockScreen_VC *vc = [storyboard instantiateViewControllerWithIdentifier:@"LockScreen_VC"];
            vc.modalPresentationStyle = UIModalPresentationCurrentContext;
            vc.modalPresentationStyle = UIModalPresentationCustom;
            vc.view.backgroundColor = [UIColor whiteColor];
            vc.str_FromWhere = @"";
            [self.initialViewController presentViewController:vc animated:FALSE completion:^{}];
            
        }
        [[GoalManagerAppDelegate getdefaultvalue]setObject:str_PasscodeOnTime forKey:@"PasscodeOnTime"];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
//    if (application.applicationState == UIApplicationStateActive) {
//        // update the tab bar item
//        NSLog(@"Active");
//    }
//    else {
//        NSLog(@"Not Active");
//    }
//    if(![[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"Alert"]isEqualToString:@"Open"]){
//
//    }
//    else{
//        [[GoalManagerAppDelegate getdefaultvalue]setObject:@"Close" forKey:@"Alert"];
//    }
    
    
    


    
    
    //Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    

    
    [Localytics tagEvent:@"Session Start"];
    [Flurry logEvent:@"Session Start"];
    [FIRAnalytics logEventWithName:@"Session_Start"
                        parameters:nil];
    
    if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"FirstStart"] length] <=0 || [[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"FirstStart"]isEqualToString:@"(null)"])
    {
        [Localytics tagEvent:@"First Start"];
        [Flurry logEvent:@"First Start"];
        [FIRAnalytics logEventWithName:@"First_Start"
                            parameters:nil];
        [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"FirstStart"];
    }
    [FBSDKAppEvents activateApp];
    //[FBAppEvents activateApp];
}
    
- (NSString *)evaluatePolicyFailErrorMessageForLA:(NSInteger)errorCode{
    NSString *str_Message = [[NSString alloc]init];
    
    if (@available(iOS 11.0, *)) {
        switch (errorCode) {
            case LAErrorBiometryNotAvailable:
                str_Message = @"Authentication could not start because the device does not support biometric authentication.";
                break;
            case LAErrorBiometryLockout  :
                str_Message = @"Authentication could not continue because the user has been locked out of biometric authentication, due to failing authentication too many times.";
                break;
            case LAErrorBiometryNotEnrolled  :
                str_Message = @"Authentication could not start because the user has not enrolled in biometric authentication.";
                break;
            default :
                str_Message = @"Did not find error code on LAError object";
        }
    } else {
        switch (errorCode) {
            case LAErrorTouchIDLockout:
            str_Message = @"Too many failed attempts.";
            break;
            case LAErrorTouchIDNotAvailable  :
            str_Message = @"TouchID is not available on the device";
            break;
            case LAErrorTouchIDNotEnrolled  :
            str_Message = @"TouchID is not enrolled on the device";
            break;
            default :
            str_Message = @"Did not find error code on LAError object";
        }
    }
    return str_Message;
}
    
    
- (NSString *)evaluateAuthenticationPolicyMessageForLA:(NSInteger)errorCode{
    NSString *str_Message = [[NSString alloc]init];
    
    switch (errorCode) {
        case LAErrorAuthenticationFailed:
        str_Message = @"The user failed to provide valid credentials";
        break;
        case LAErrorAppCancel  :
        str_Message = @"Authentication was cancelled by application";
        break;
        case LAErrorInvalidContext  :
        str_Message = @"The context is invalid";
        break;
        case LAErrorNotInteractive  :
        str_Message = @"Not interactive";
        break;
        case LAErrorPasscodeNotSet  :
        str_Message = @"Passcode is not set on the device";
        break;
        case LAErrorSystemCancel  :
        str_Message = @"Authentication was cancelled by the system";
        break;
        case LAErrorUserFallback  :
        str_Message = @"The user chose to use the fallback";
        break;
        case LAErrorUserCancel  :
        str_Message = @"The user did cancel";
            
        break;
        default :
        str_Message = [self evaluatePolicyFailErrorMessageForLA:errorCode];
        break;
    }
    
    return str_Message;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"AppKilled"];
    
    [Localytics tagEvent:@"Session End"];
    [Flurry logEvent:@"Session End"];
    [FIRAnalytics logEventWithName:@"Session_End"
                        parameters:nil];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [MagicalRecord cleanUp];
}

//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//  sourceApplication:(NSString *)sourceApplication
//         annotation:(id)annotation
//{
//    NSLog(@"%@",url);
//    // attempt to extract a token from the url
//    // return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
//    return [[FBSDKApplicationDelegate sharedInstance] application:application
//                                                          openURL:url
//                                                sourceApplication:sourceApplication
//                                                       annotation:annotation
//            ];
//}



//- (BOOL)application:(UIApplication *)application
//            openURL:(NSURL *)url
//            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
//    if ([url.absoluteString containsString:@"twitter"]){
//        return [[Twitter sharedInstance] application:application openURL:url options:options];
//    } else{
//        // other callbacks ...
//        return NO;
//    }
//}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (alertView.tag == 212)
    {
        if (buttonIndex == 1)
        {
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"LocalNotifAsked"];
            
            if ([[UIApplication sharedApplication]respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
            {
                [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
                
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
            else
            {
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
            
            [Localytics tagEvent:@"Clicked on Yes, Please Notification"];
            [Flurry logEvent:@"Clicked on Yes, Please Notification"];
            [FIRAnalytics logEventWithName:@"Clicked_On_Yes_Notifications"
                                parameters:nil];
            
        }
        else{
            [Localytics tagEvent:@"Clicked on Later Notification"];
            [Flurry logEvent:@"Clicked on Later Notification"];
            [FIRAnalytics logEventWithName:@"Clicked_on_Later_Notification"
                                parameters:nil];
        }
    }
    else if (alertView.tag == 213){
        if (buttonIndex == 1) {
            
            if (UIApplicationOpenSettingsURLString != nil) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication] openURL:url];
            }
            [Localytics tagEvent:@"Clicked on Yes, Please Notification"];
            [Flurry logEvent:@"Clicked on Yes, Please Notification"];
            [FIRAnalytics logEventWithName:@"Clicked_On_Yes_Notifications"
                                parameters:nil];
        }
        else{
            [Localytics tagEvent:@"Clicked on Later Notification"];
            [Flurry logEvent:@"Clicked on Later Notification"];
            [FIRAnalytics logEventWithName:@"Clicked_on_Later_Notification"
                                parameters:nil];
        }
    }
    else if (alertView.tag == 1234){
        
        if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"PasscodeSet"]isEqualToString:@"Yes"]){
            if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"Passcode"]isEqualToString:@"OFF"]){
                UIStoryboard  *storyboard=nil;
                if (isiPhone5)
                    storyboard = [UIStoryboard storyboardWithName:@"IPhone5" bundle:nil];
                else if(isiPhone6)
                    storyboard = [UIStoryboard storyboardWithName:@"IPhone6" bundle:nil];
                else if(isiPhone6Plus)
                    storyboard = [UIStoryboard storyboardWithName:@"IPhone6Plus" bundle:nil];
                else if(isiPhoneX)
                    storyboard = [UIStoryboard storyboardWithName:@"IPhoneX" bundle:nil];
                else
                    storyboard = [UIStoryboard storyboardWithName:@"IPhone4" bundle:nil];
                LockScreen_VC *vc = [storyboard instantiateViewControllerWithIdentifier:@"LockScreen_VC"];
                vc.modalPresentationStyle = UIModalPresentationCurrentContext;
                vc.modalPresentationStyle = UIModalPresentationCustom;
                vc.view.backgroundColor = [UIColor whiteColor];
                vc.str_FromWhere = @"";
                [self.initialViewController presentViewController:vc animated:FALSE completion:^{
                    [self.aView removeFromSuperview];
                }];
            }
        }
        else{
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"AppKilled"];
            exit(0);
        }
    }
}

@end
