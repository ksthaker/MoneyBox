//
//  Settings_ViewController.m
//  GoalManager
//
//  Created by apple on 11/11/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import "Settings_ViewController.h"
#import "NSString+FontAwesome.h"
#import "GoalManagerAppDelegate.h"
#import "Currency_ViewController.h"
#import "GoalManager.h"

#import "AboutApp_ViewController.h"


@interface Settings_ViewController ()

@end

@implementation Settings_ViewController
@synthesize hud;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Settings", nil);
    UIImage* image2 = [UIImage imageNamed:@"navbar_back.png"];
    CGRect frameimg2 = CGRectMake(0, 0,22,22);
    UIButton *someButton2 = [[UIButton alloc] initWithFrame:frameimg2];
    [someButton2 setBackgroundImage:image2 forState:UIControlStateNormal];
    [someButton2 addTarget:self action:@selector(action_Back:)
          forControlEvents:UIControlEventTouchUpInside];
    [someButton2 setSelected:YES];
    
    UIBarButtonItem *btn_Back= [[UIBarButtonItem alloc]initWithCustomView:someButton2];
    
    NSArray *arr_GoalOverviewLeft= [[NSArray alloc] initWithObjects:btn_Back,nil];
    self.navigationItem.leftBarButtonItems = arr_GoalOverviewLeft;
    
    self.lbl_ArrowDown.font = [UIFont fontWithName:kFontAwesomeFamilyName size:15];
    self.lbl_ArrowDown.text = [NSString fontAwesomeIconStringForIconIdentifier:@"fa-chevron-right"];
    
    //////////////////////// UISwipeGestureRecognizer ////////////////////////
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    // Setting the swipe direction.
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.view addGestureRecognizer:swipeRight];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productsLoaded:) name:kProductsLoadedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:kProductPurchasedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(productPurchaseFailed:) name:kProductPurchaseFailedNotification object: nil];
    
    [self.btn_Restore.layer setBorderColor: [UIColor colorWithRed:59/255.0 green:195/255.0 blue:139/255.0 alpha:1.0].CGColor];
    [self.btn_Restore.layer setBorderWidth: 1.0];
    self.btn_Restore .layer.cornerRadius = 5.0;
    self.btn_Restore.clipsToBounds = YES;
    
    self.btn_Purchse.layer.cornerRadius = 5.0;
    self.btn_Purchse.clipsToBounds = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationIsActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    
  
}

- (void)applicationIsActive:(NSNotification *)notification
{
     [self Check_Social_Session];
    
    [self action_Rem];
}



#pragma mark UISwipeGestureRecognizer METHOD

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.hidden = false;
    [Localytics tagEvent:@"Settings"];
    [Flurry logEvent:@"Settings"];
    [FIRAnalytics logEventWithName:@"Settings"
                        parameters:nil];
    if (![[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InAppPurchase"] isEqualToString:@"1"])
    {
        self.view_AD.adUnitID = @"ca-app-pub-5298130731078005/7401333379";
        self.view_AD.rootViewController = self;
        GADRequest *request = [GADRequest request];
        
        //request.testDevices = @[ @"e33953a7d4e4e4fbac2a3e08d60e4f9db7abcdfa" ];
        
        [self.view_AD loadRequest:request];
        
        //[self action_Product_Receive];
        self.view_InApp.hidden = FALSE;
        self.lbl_Thanks.hidden = TRUE;
        self.view_AD.hidden = FALSE;
        
        self.btn_PRO.hidden = FALSE;
        self.lbl_PRO.hidden = FALSE;
        
        self.btn_TouchID.hidden = FALSE;
        self.lbl_Pro_TouchID.hidden = FALSE;
        
        self.btn_PasscodeLock.hidden = FALSE;
        self.lbl_Pro_PasscodeLock.hidden = FALSE;
        
//        self.btn_ChangePin.hidden = FALSE;
//        self.lbl_Pro_ChangePin.hidden = FALSE;
        
        if (isiPhone6Plus)
        {
            self.scroll_Settings.contentSize = CGSizeMake(0, self.scroll_Settings.bounds.size.height+230);

        }
        else if (isiPhone5)
        {
            self.scroll_Settings.contentSize = CGSizeMake(0, self.scroll_Settings.bounds.size.height+340);
        }
        else if (isiPhone6)
        {
            self.scroll_Settings.contentSize = CGSizeMake(0, self.scroll_Settings.bounds.size.height+300);
        }
        else if (isiPhoneX)
        {
            self.scroll_Settings.contentSize = CGSizeMake(0, self.scroll_Settings.bounds.size.height+170);
        }
        else
        {
             self.scroll_Settings.contentSize = CGSizeMake(0, self.scroll_Settings.bounds.size.height+490);
        }
//        if (isiPhone6Plus)
//        {
//            self.scroll_Settings.contentSize = CGSizeMake(0, self.scroll_Settings.bounds.size.height+130);
//
//        }
//        else if (isiPhone5)
//        {
//            self.scroll_Settings.contentSize = CGSizeMake(0, self.scroll_Settings.bounds.size.height+250);
//        }
//        else if (isiPhone6)
//        {
//            self.scroll_Settings.contentSize = CGSizeMake(0, self.scroll_Settings.bounds.size.height+200);
//        }
//        else if (isiPhoneX)
//        {
//            self.scroll_Settings.contentSize = CGSizeMake(0, self.scroll_Settings.bounds.size.height+70);
//        }
//        else
//        {
//            self.scroll_Settings.contentSize = CGSizeMake(0, self.scroll_Settings.bounds.size.height+325);
//        }
    }
    else
    {
        self.btn_TouchID.hidden = FALSE;
        self.lbl_Pro_TouchID.hidden = TRUE;
        
        self.btn_PasscodeLock.hidden = FALSE;
        self.lbl_Pro_PasscodeLock.hidden = TRUE;
        
//        self.btn_ChangePin.hidden = FALSE;
//        self.lbl_Pro_ChangePin.hidden = TRUE;
        
        self.btn_PRO.hidden = TRUE;
        self.lbl_PRO.hidden = TRUE;
        self.view_InApp.hidden = TRUE;
        self.lbl_Thanks.hidden = FALSE;
        self.view_Main.frame = CGRectMake(self.view_Main.frame.origin.x, 42, self.view_Main.bounds.size.width, self.view_Main.bounds.size.height);
        self.view_AD.hidden = TRUE;
        if (isiPhone6Plus)
        {
            self.scroll_Settings.contentSize = CGSizeMake(0, self.scroll_Settings.bounds.size.height);

        }
        else if (isiPhone5)
        {
            self.scroll_Settings.contentSize = CGSizeMake(0, self.scroll_Settings.bounds.size.height);
        }
        else if (isiPhone6)
        {
            self.scroll_Settings.contentSize = CGSizeMake(0, self.scroll_Settings.bounds.size.height);
        }
        else if (isiPhoneX)
        {
            self.scroll_Settings.contentSize = CGSizeMake(0, self.scroll_Settings.bounds.size.height);
        }
        else
        {
            self.scroll_Settings.contentSize = CGSizeMake(0, self.scroll_Settings.bounds.size.height+150);
        }
        
        if ([self.str_OpenTouchID isEqualToString:@"OpenTouchID"]) {
            NSLog(@"Got");
            [self action_TouchIDPro:self];
            self.str_OpenTouchID = @"";
        }
        else{
            NSLog(@"Dont");
        }
        
        
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.lbl_MasterCurrency.text = [[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"MasterCurrencyCode"];
    
    if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"MasterCurrency"]isEqualToString:@"ON"])
    {
        [[GoalManagerAppDelegate getdefaultvalue]setObject:@"ON" forKey:@"MasterCurrency"];
    }
    else
    {
        [[GoalManagerAppDelegate getdefaultvalue]setObject:@"ON" forKey:@"MasterCurrency"];
    }
    
    if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"ShowTotals"]isEqualToString:@"ON"])
    {
        isOnShowTotals = TRUE;
        [self.switch_ShowTotals setOn:TRUE];
        [[GoalManagerAppDelegate getdefaultvalue]setObject:@"ON" forKey:@"ShowTotals"];
    }
    else
    {
        isOnShowTotals = FALSE;
        [self.switch_ShowTotals setOn:FALSE];
        [[GoalManagerAppDelegate getdefaultvalue]setObject:@"OFF" forKey:@"ShowTotals"];
    }
    
    if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"TouchIDSet"]isEqualToString:@"Yes"]){
        if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"TouchID"]isEqualToString:@"ON"])
        {
            isOnTouchID = TRUE;
            [self.switch_TouchID setOn:TRUE];
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"ON" forKey:@"TouchID"];
        }
        else
        {
            isOnTouchID = FALSE;
            [self.switch_TouchID setOn:FALSE];
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"OFF" forKey:@"TouchID"];
        }
    }
    else{
        isOnTouchID = FALSE;
        [self.switch_TouchID setOn:FALSE];
        [[GoalManagerAppDelegate getdefaultvalue]setObject:@"OFF" forKey:@"TouchID"];
    }
    
    if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"PasscodeSet"]isEqualToString:@"Yes"]){
        if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"Passcode"]isEqualToString:@"ON"])
        {
            isOnPasscode = TRUE;
            [self.switch_PasscodeLock setOn:TRUE];
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"ON" forKey:@"Passcode"];
        }
        else
        {
            isOnPasscode = FALSE;
            [self.switch_PasscodeLock setOn:FALSE];
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"OFF" forKey:@"Passcode"];
        }
    }
    else{
        isOnPasscode = FALSE;
        [self.switch_PasscodeLock setOn:FALSE];
        [[GoalManagerAppDelegate getdefaultvalue]setObject:@"OFF" forKey:@"Passcode"];
    }
    
    
    
    
    [self Check_Social_Session];
    
    [self action_Rem];
    
    self.lbl_NotificationSetting.text = NSLocalizedString(@"NOTIFICATION SETTING", nil);
    
    self.lbl_ShowAppGuide.text = NSLocalizedString(@"Show Money Box guide again", nil);
    
    self.lbl_SecuritySettings.text = NSLocalizedString(@"SECURITY SETTINGS", nil);
    self.lbl_TouchID.text = NSLocalizedString(@"Touch ID", nil);
    
    if (isiPhone4 || isiPhone5 || isiPhone6 || isiPhone6Plus) {
        self.lbl_TouchID.text = NSLocalizedString(@"Touch ID", nil);
    }
    else{
        self.lbl_TouchID.text = NSLocalizedString(@"Face ID", nil);
    }
    
    self.lbl_PasscodeLock.text = NSLocalizedString(@"Passcode Lock", nil);
    self.lbl_ChangePin.text = NSLocalizedString(@"Change Pin", nil);
    self.lbl_Pro_TouchID.text = NSLocalizedString(@"PRO", nil);
    self.lbl_Pro_ChangePin.text = NSLocalizedString(@"PRO", nil);
    self.lbl_Pro_PasscodeLock.text = NSLocalizedString(@"PRO", nil);
    
    self.lbl_PasscodeandTouchIDSp.text = NSLocalizedString(@"Passcode and Touch ID support", nil);
    
    
    [super viewWillAppear:YES];
}
- (IBAction)action_ShowAppGuide:(id)sender {
    [[GoalManagerAppDelegate getdefaultvalue]setObject:@"" forKey:@"InitialScreen1"];
    [[GoalManagerAppDelegate getdefaultvalue]setObject:@"" forKey:@"InitialScreen2"];
    [[GoalManagerAppDelegate getdefaultvalue]setObject:@"" forKey:@"InitialScreen3"];
    [self.navigationController popViewControllerAnimated:TRUE];
}



-(IBAction)action_ReminderOnOff:(UIButton *)sender{
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(currentUserNotificationSettings)]){ // Check it's iOS 8 and above
        UIUserNotificationSettings *grantedSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
        
        if (grantedSettings.types == UIUserNotificationTypeNone) {
            if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"LocalNotifAsked"] isEqualToString:@"1"]) {
                NSString *str_AlertTitle = [NSString stringWithFormat:NSLocalizedString(@"Money Box", nil)];
                NSString *str_AlertText = [NSString stringWithFormat:NSLocalizedString(@"Notification are disallowed please make it enable from iphone's settings", nil)];
                
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:str_AlertTitle message:str_AlertText delegate:self cancelButtonTitle:NSLocalizedString(@"Later", nil) otherButtonTitles:NSLocalizedString(@"Yes, Please", nil),nil];
                alert.tag = 213;
                [alert show];
            }
            else{
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
//                NSString *str_AlertTitle = [NSString stringWithFormat:NSLocalizedString(@"Money Box", nil)];
//                NSString *str_AlertText = [NSString stringWithFormat:NSLocalizedString(@"Money Box needs your permission to remind you about your saving goals and payments. This will help you achieve your savings goals faster. Do you want it to remind you next time?", nil)];
//
//                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:str_AlertTitle message:str_AlertText delegate:self cancelButtonTitle:NSLocalizedString(@"Later", nil) otherButtonTitles:NSLocalizedString(@"Yes, Please", nil),nil];
//                alert.tag = 212;
//                [alert show];
            }
            
            
            return;
        }
        else if (grantedSettings.types & UIUserNotificationTypeSound & UIUserNotificationTypeAlert ){
            NSLog(@"Sound and alert permissions ");
            self.lbl_Notification.text = NSLocalizedString(@"Notifications Are Enabled", nil);
        }
        else if (grantedSettings.types  & UIUserNotificationTypeAlert){
            NSLog(@"Alert Permission Granted");
            self.lbl_Notification.text = NSLocalizedString(@"Notifications Are Enabled", nil);
            
        }
        
    }
}

-(void)action_Rem{
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(currentUserNotificationSettings)]){ // Check it's iOS 8 and above
        UIUserNotificationSettings *grantedSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
        
        if (grantedSettings.types == UIUserNotificationTypeNone) {
            
            
            self.lbl_Notification.text = NSLocalizedString(@"Click here to enable Notifications", nil);
            [self.lbl_LineOther setHidden:TRUE];
            [self.view_Notification setHidden:FALSE];
            return;
        }
        else if (grantedSettings.types & UIUserNotificationTypeSound & UIUserNotificationTypeAlert ){
            NSLog(@"Sound and alert permissions ");
            [self.lbl_LineOther setHidden:FALSE];
            [self.view_Notification setHidden:TRUE];
            self.lbl_Notification.text = NSLocalizedString(@"Notifications Are Enabled", nil);
            
        }
        else if (grantedSettings.types  & UIUserNotificationTypeAlert){
            NSLog(@"Alert Permission Granted");
            [self.lbl_LineOther setHidden:FALSE];
            [self.view_Notification setHidden:TRUE];
            self.lbl_Notification.text = NSLocalizedString(@"Notifications Are Enabled", nil);
            
        }
        
    }
    
}

-(void)Check_Social_Session
{
    
//    if ([[Twitter sharedInstance].sessionStore hasLoggedInUsers]) {
//        self.lbl_tw_connection.text = @"Connected";
//        self.lbl_tw_connection.textColor =  [UIColor colorWithRed:59/255.0 green:195/255.0 blue:139/255.0 alpha:1.0];
//    } else {
//
//        self.lbl_tw_connection.text = @"Not Connected";
//        self.lbl_tw_connection.textColor = [UIColor blackColor];
//    }
    
//    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
//    {
//
//        //self.btn_twitter.userInteractionEnabled = false;
//
//    }
//    else
//    {
//
//       // self.btn_twitter.userInteractionEnabled = true;
//    }
    
//    if ([FBSDKAccessToken currentAccessToken]) {
//        self.lbl_fb_connection.text = @"Connected";
//        self.lbl_fb_connection.textColor =  [UIColor colorWithRed:59/255.0 green:195/255.0 blue:139/255.0 alpha:1.0];
//    }
//    else{
//        self.lbl_fb_connection.text = @"Not Connected";
//        self.lbl_fb_connection.textColor = [UIColor blackColor];
//    }
    
//    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
//    {
//       self.lbl_fb_connection.text = @"Connected";
//         self.lbl_fb_connection.textColor =  [UIColor colorWithRed:59/255.0 green:195/255.0 blue:139/255.0 alpha:1.0];
//      //  self.btn_facebook.userInteractionEnabled = false;
//    }
//    else
//    {
//        self.lbl_fb_connection.text = @"Not Connected";
//         self.lbl_fb_connection.textColor = [UIColor blackColor];
//       // self.btn_facebook.userInteractionEnabled = true;
//
//    }
    
}

-(IBAction)goto_fb:(id)sender
{
    if ([FBSDKAccessToken currentAccessToken]) {
        
        self.lbl_fb_connection.text = @"Not Connected";
        self.lbl_fb_connection.textColor = [UIColor blackColor];
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logOut];;
        
    }
    else{
        [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login
         logInWithReadPermissions: @[@"public_profile", @"email"]
         fromViewController:self
         handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
             [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
             if (error) {
                 NSLog(@"Process error");
             } else if (result.isCancelled) {
                 NSLog(@"Cancelled");
             } else {
                 NSLog(@"Logged in");
                 self.lbl_fb_connection.text = @"Connected";
                 self.lbl_fb_connection.textColor =  [UIColor colorWithRed:59/255.0 green:195/255.0 blue:139/255.0 alpha:1.0];
             }
         }];
        
        
    }
//    if([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)
//    {
//        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"App-Prefs:root=FACEBOOK"]
//                                          options:[NSDictionary dictionary]
//                                completionHandler:nil];
//    }
//   else
//    {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root=FACEBOOK"]];
//    }
    
}

  

-(IBAction)goto_twitter:(id)sender
{
    
//    if ([[Twitter sharedInstance].sessionStore hasLoggedInUsers]){
//        TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
//        NSString *userID = store.session.userID;
//        [store logOutUserID:userID];
//
//        self.lbl_tw_connection.text = @"Not Connected";
//        self.lbl_tw_connection.textColor = [UIColor blackColor];
//
//    }
//    else{
//        [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
//            if (session) {
//                self.lbl_tw_connection.text = @"Connected";
//                self.lbl_tw_connection.textColor =  [UIColor colorWithRed:59/255.0 green:195/255.0 blue:139/255.0 alpha:1.0];
//            } else {
//                self.lbl_tw_connection.text = @"Not Connected";
//                self.lbl_tw_connection.textColor = [UIColor blackColor];
//            }
//        }];
//    }
    
    
    
//     if([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)
//     {
//
//         [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"App-Prefs:root=TWITTER"]
//                                           options:[NSDictionary dictionary]
//                                 completionHandler:nil];
//     }
//    else
//    {
//          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root=TWITTER"]];
//
//    }
    
}

- (IBAction)action_TouchIDOnOff:(UISwitch *)sender {
    
    

    
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
    
- (IBAction)action_PasscodeOnOff:(UISwitch *)sender {
}
    
- (IBAction)action_TouchIDPro:(id)sender {
    
    if (![[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InAppPurchase"] isEqualToString:@"1"])
    {
        UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"MoneyBox" message:NSLocalizedString(@"Please Upgrade to PRO version", nil)  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert3 show];
    }
    else{
        if (isOnTouchID == TRUE)
        {
            isOnTouchID = FALSE;
            [self.switch_TouchID setOn:FALSE];
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"OFF" forKey:@"TouchID"];
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"No" forKey:@"TouchIDSet"];
        }
        else
        {
            if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"PasscodeSet"]isEqualToString:@"Yes"] && [[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"Passcode"]isEqualToString:@"ON"]) {
                [[GoalManagerAppDelegate getdefaultvalue]setObject:@"Open" forKey:@"Alert"];
                LAContext *context = [[LAContext alloc] init];
                [context setLocalizedFallbackTitle:@""];
                NSError *error = nil;
                
                if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
                    // Authenticate User
                    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                            localizedReason:@"Please authenticate to unlock Money Box"
                                      reply:^(BOOL success, NSError *error) {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              
                                              if (success) {
                                                  //[[GoalManagerAppDelegate getdefaultvalue]setObject:@"Close" forKey:@"Alert"];
                                                  isOnTouchID = TRUE;
                                                  [self.switch_TouchID setOn:TRUE];
                                                  [[GoalManagerAppDelegate getdefaultvalue]setObject:@"ON" forKey:@"TouchID"];
                                                  [[GoalManagerAppDelegate getdefaultvalue]setObject:@"Yes" forKey:@"TouchIDSet"];
                                                  
                                                  NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
                                                  [dateFormatter setDateFormat:@"HH:mm:ss"];
                                                  
                                                  // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
                                                  
                                                  NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
                                                  NSString *str_PasscodeOnTime = [[NSString alloc]init];
                                                  str_PasscodeOnTime = [dateFormatter stringFromDate:[NSDate date]];
                                                  
                                                  [[GoalManagerAppDelegate getdefaultvalue]setObject:str_PasscodeOnTime forKey:@"PasscodeOnTime"];
                                                  
                                                  if (isiPhone4 || isiPhone5 || isiPhone6 || isiPhone6Plus) {
                                                      [Localytics tagEvent:@"Settings Touch ID On"];
                                                      [Flurry logEvent:@"Settings Touch ID On"];
                                                      
                                                      [FIRAnalytics logEventWithName:@"Settings_Touch_ID_On"
                                                                          parameters:nil];
                                                      
                                                      [Localytics tagEvent:@"Touch ID setup successfully"];
                                                      [Flurry logEvent:@"Touch ID setup successfully"];
                                                      
                                                      [FIRAnalytics logEventWithName:@"Touch_ID_setup_successfully"
                                                                          parameters:nil];
                                                  }
                                                  else{
                                                      [Localytics tagEvent:@"Settings Face ID On"];
                                                      [Flurry logEvent:@"Settings Face ID On"];
                                                      
                                                      [FIRAnalytics logEventWithName:@"Settings_Face_ID_On"
                                                                          parameters:nil];
                                                      
                                                      [Localytics tagEvent:@"Face ID setup successfully"];
                                                      [Flurry logEvent:@"Face ID setup successfully"];
                                                      
                                                      [FIRAnalytics logEventWithName:@"Face_ID_setup_successfully"
                                                                          parameters:nil];
                                                  }
                                                  
                                                  
                                                  
                                                  
                                                  
                                              } else {
                                                  
                                                  
                                                  if (isiPhone4 || isiPhone5 || isiPhone6 || isiPhone6Plus) {
                                                      [Localytics tagEvent:@"Touch ID setup failed"];
                                                      [Flurry logEvent:@"Touch ID setup failed"];
                                                      
                                                      [FIRAnalytics logEventWithName:@"Touch_ID_setup_failed"
                                                                          parameters:nil];
                                                  }
                                                  else{
                                                      [Localytics tagEvent:@"Face ID setup failed"];
                                                      [Flurry logEvent:@"Face ID setup failed"];
                                                      
                                                      [FIRAnalytics logEventWithName:@"Face_ID_setup_failed"
                                                                          parameters:nil];
                                                  }
                                                  
                                                  
                                                  
                                                  [self.switch_TouchID setOn:FALSE];
                                                  isOnTouchID = FALSE;
                                                  [[GoalManagerAppDelegate getdefaultvalue]setObject:@"OFF" forKey:@"TouchID"];
                                                  [[GoalManagerAppDelegate getdefaultvalue]setObject:@"No" forKey:@"TouchIDSet"];
                                                  NSString *str_Message = [[NSString alloc]init];
                                                  str_Message = [self evaluateAuthenticationPolicyMessageForLA:error.code];
                                                  
                                                  if ([str_Message isEqualToString:@"The user did cancel"]) {
                                                      return;
                                                  }
                                                  
                                                  UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"Touch ID" message:str_Message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                                                  [alert3 show];
                                                  
                                                  NSLog(@"%@",[self evaluateAuthenticationPolicyMessageForLA:error.code]);
                                                  
                                              }
                                          });
                                          
                                      }];
                } else {
                    
                    if (isiPhone4 || isiPhone5 || isiPhone6 || isiPhone6Plus) {
                        [Localytics tagEvent:@"Touch ID setup failed"];
                        [Flurry logEvent:@"Touch ID setup failed"];
                        
                        [FIRAnalytics logEventWithName:@"Touch_ID_setup_failed"
                                            parameters:nil];
                    }
                    else{
                        [Localytics tagEvent:@"Face ID setup failed"];
                        [Flurry logEvent:@"Face ID setup failed"];
                        
                        [FIRAnalytics logEventWithName:@"Face_ID_setup_failed"
                                            parameters:nil];
                    }
                    
                    //[[GoalManagerAppDelegate getdefaultvalue]setObject:@"Close" forKey:@"Alert"];
                    [self.switch_TouchID setOn:FALSE];
                    isOnTouchID = FALSE;
                    [[GoalManagerAppDelegate getdefaultvalue]setObject:@"OFF" forKey:@"TouchID"];
                    [[GoalManagerAppDelegate getdefaultvalue]setObject:@"No" forKey:@"TouchIDSet"];
                    NSLog(@"%@",[self evaluateAuthenticationPolicyMessageForLA:error.code]);
                    NSString *str_Message = [[NSString alloc]init];
                    str_Message = [self evaluateAuthenticationPolicyMessageForLA:error.code];
                    
                    UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"Touch ID" message:str_Message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                    [alert3 show];
                }
            }
            else{
                NewPin_VC *obj_NewPin_VC =[self.storyboard instantiateViewControllerWithIdentifier:@"NewPin_VC"];
                obj_NewPin_VC.str_FromWhere = @"FromTouchID";
                [self.navigationController pushViewController:obj_NewPin_VC animated:YES];
            }
        }
    }
    
    
}

-(void)action_PasscodeOff{
    isOnPasscode = FALSE;
    [self.switch_PasscodeLock setOn:FALSE];
    [[GoalManagerAppDelegate getdefaultvalue]setObject:@"OFF" forKey:@"Passcode"];
    [[GoalManagerAppDelegate getdefaultvalue]setObject:@"No" forKey:@"PasscodeSet"];
    
    isOnTouchID = FALSE;
    [self.switch_TouchID setOn:FALSE];
    [[GoalManagerAppDelegate getdefaultvalue]setObject:@"OFF" forKey:@"TouchID"];
    [[GoalManagerAppDelegate getdefaultvalue]setObject:@"No" forKey:@"TouchIDSet"];

}

- (IBAction)action_PasscodePro:(id)sender {
    
    if (![[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InAppPurchase"] isEqualToString:@"1"])
    {
        UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"MoneyBox" message:NSLocalizedString(@"Please Upgrade to PRO version", nil)  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert3 show];
    }
    else{
        if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"PasscodeSet"]isEqualToString:@"Yes"]){
            if (isOnPasscode == TRUE)
            {
//                isOnPasscode = FALSE;
//                [self.switch_PasscodeLock setOn:FALSE];
//                [[GoalManagerAppDelegate getdefaultvalue]setObject:@"OFF" forKey:@"Passcode"];
//                [[GoalManagerAppDelegate getdefaultvalue]setObject:@"No" forKey:@"PasscodeSet"];
//
//                isOnTouchID = FALSE;
//                [self.switch_TouchID setOn:FALSE];
//                [[GoalManagerAppDelegate getdefaultvalue]setObject:@"OFF" forKey:@"TouchID"];
//                [[GoalManagerAppDelegate getdefaultvalue]setObject:@"No" forKey:@"TouchIDSet"];
                
                LockScreen_VC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LockScreen_VC"];
                vc.modalPresentationStyle = UIModalPresentationCurrentContext;
                vc.modalPresentationStyle = UIModalPresentationCustom;
                vc.view.backgroundColor = [UIColor whiteColor];
                vc.str_FromWhere = @"FromSettings";
                vc.obj_Setting_VC = self;
                [self.navigationController presentViewController:vc animated:YES completion:^{}];
            }
            else
            {
                NewPin_VC *obj_NewPin_VC =[self.storyboard instantiateViewControllerWithIdentifier:@"NewPin_VC"];
                obj_NewPin_VC.str_FromWhere = @"";
                [self.navigationController pushViewController:obj_NewPin_VC animated:YES];
//                isOnPasscode = TRUE;
//                [self.switch_PasscodeLock setOn:TRUE];
//                [[GoalManagerAppDelegate getdefaultvalue]setObject:@"ON" forKey:@"Passcode"];
//
//                NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
//                [dateFormatter setDateFormat:@"HH:mm:ss"];
//
//                // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
//
//                NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
//                NSString *str_PasscodeOnTime = [[NSString alloc]init];
//                str_PasscodeOnTime = [dateFormatter stringFromDate:[NSDate date]];
//
//                [[GoalManagerAppDelegate getdefaultvalue]setObject:str_PasscodeOnTime forKey:@"PasscodeOnTime"];
            }
        }
        else{
            NewPin_VC *obj_NewPin_VC =[self.storyboard instantiateViewControllerWithIdentifier:@"NewPin_VC"];
            obj_NewPin_VC.str_FromWhere = @"";
            [self.navigationController pushViewController:obj_NewPin_VC animated:YES];
        }
    }
}
- (IBAction)action_ChangePin:(id)sender {
    if (![[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InAppPurchase"] isEqualToString:@"1"])
    {
        UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"MoneyBox" message:NSLocalizedString(@"Please Upgrade to PRO version", nil)  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert3 show];
    }
    else
    {
        if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"PasscodeSet"]isEqualToString:@"Yes"])
        {
            ChangePin_VC *obj_ChangePin_VC =[self.storyboard instantiateViewControllerWithIdentifier:@"ChangePin_VC"];
            [self.navigationController pushViewController:obj_ChangePin_VC animated:YES];
        }
        else
        {
            UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"MoneyBox" message:NSLocalizedString(@"Please set your passcode first", nil)  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert3 show];
        }
//        ChangePin_VC *obj_ChangePin_VC =[self.storyboard instantiateViewControllerWithIdentifier:@"ChangePin_VC"];
//        [self.navigationController pushViewController:obj_ChangePin_VC animated:YES];
    }
}
    
-(void) action_Product_Receive
{
    BOOL isInternet = [GoalManagerAppDelegate connectedToNetwork];
    
    if (isInternet == TRUE)
    {
        if ([InAppRageIAPHelper sharedHelper].products == nil)
        {
            [[InAppRageIAPHelper sharedHelper] requestProducts];
            
            [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            [self performSelector:@selector(timeout:) withObject:nil afterDelay:30.0];
        }
    }
    else
    {
        UIAlertView *alert2 = [[UIAlertView alloc] init];
        [alert2 setTitle:@""];
        alert2.tag=999;
        [alert2 setMessage:@"No internet connection!"];
        [alert2 setDelegate:self];
        [alert2 addButtonWithTitle:@"OK"];
        [alert2 show];
        alert2.delegate =self;
    }
}

- (void)timeout:(id)arg
{
    [self performSelector:@selector(dismissHUD:) withObject:nil afterDelay:5.0];
}

- (void)dismissHUD:(id)arg
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    self.hud = nil;
}

-(IBAction)Purchase:(id)sender
{
    [Localytics tagEvent:@"Purchase Selected"];
    [Flurry logEvent:@"Purchase Selected"];
    [FIRAnalytics logEventWithName:@"Purchase_Selected"
                        parameters:nil];
    if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InAppPurchase"] isEqualToString:@"1"])
    {
        UIAlertView *alert11=[[UIAlertView alloc] initWithTitle:nil message:@"You already purchased this" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert11 show];
    }
    else
    {
//        if ([[InAppRageIAPHelper sharedHelper].products count]==0)
//        {
//            [self performSelector:@selector(dismissHUD:) withObject:nil afterDelay:5.0];
//            [self action_Product_Receive];
//        }
//        else
//        {
//            [[InAppRageIAPHelper sharedHelper] buyProductIdentifier:@"com.andrey.MoneyBoxFullVersion"];
//            
//            hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//            hud.labelText = @"Buying...";
//            [self performSelector:@selector(timeout:) withObject:nil afterDelay:60*5];
//        }
        [[InAppRageIAPHelper sharedHelper] buyProductIdentifier:@"com.andrey.MoneyBoxFullVersion"];
        
        hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.labelText = @"Buying...";
        [self performSelector:@selector(timeout:) withObject:nil afterDelay:60*5];
    }
}

- (void)productsLoaded:(NSNotification *)notification
{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    
}
- (void)productPurchased:(NSNotification *)notification
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    NSString *productIdentifier = (NSString *) notification.object;
    NSLog(@"%@",productIdentifier);
    alert1 = [[UIAlertView alloc] init];
    [alert1 setTitle:@""];
    
    [self actionFunctionNSUSER:productIdentifier];
    
}

-(void)actionFunctionNSUSER:(NSString *)productIdentifier //This Function will cheack the NSUSER Defult and Fill with New DATA
{
    if([productIdentifier isEqualToString:@"com.andrey.MoneyBoxFullVersion"])
    {
        [self viewWillAppear:NO];
        [Localytics tagEvent:@"Purchased Successfully"];
        [Flurry logEvent:@"Purchased Successfully"];
        [FIRAnalytics logEventWithName:@"Purchased_Successfully"
                            parameters:nil];
        [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"InAppPurchase"];
        
        [self viewWillAppear:false];
    }
}

- (void)dealloc
{
    hud = nil;
}

-(void)viewDidUnload
{
    hud = nil;
}


- (void)productPurchaseFailed:(NSNotification *)notification
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    SKPaymentTransaction * transaction = (SKPaymentTransaction *) notification.object;
    
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        NSDictionary *articleParams = [NSDictionary dictionaryWithObjectsAndKeys:
                                       transaction.error.localizedDescription, @"PurchseFailed",nil];
        
        [Flurry logEvent:@"Purchase Failed" withParameters:articleParams];
        
        [Localytics tagEvent:@"Purchase Failed"
                  attributes:articleParams];
        
        [FIRAnalytics logEventWithName:@"Purchase_Failed"
                            parameters:articleParams];
        [[GoalManagerAppDelegate getdefaultvalue]setObject:@"0" forKey:@"InAppPurchase"];
        UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"Error!" message:transaction.error.localizedDescription delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert3 show];
    }
}
-(IBAction)action_Restore:(id)sender
{
    
    [Flurry logEvent:@"Click Restore Purchase"];
    [Localytics tagEvent:@"Click Restore Purchase"];
    [FIRAnalytics logEventWithName:@"Click_Restore_Purchase"
                        parameters:nil];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
}



#pragma mark - Restore Delegate

- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    
    NSLog(@"%@",queue.transactions);
    bool isDone = FALSE;
    for (SKPaymentTransaction *transaction in queue.transactions)
    {
        NSString *thisIsProductIDThatHasAlreadyBeenPurchased = transaction.payment.productIdentifier;
        NSLog(@"%@",thisIsProductIDThatHasAlreadyBeenPurchased);
        
        if ([thisIsProductIDThatHasAlreadyBeenPurchased isEqualToString:@"com.andrey.MoneyBoxFullVersion"]) {
            isDone = TRUE;
            break;
        }
        
    }
    NSString *str_Message = [[NSString alloc]init];
    if (isDone == TRUE) {
        str_Message = @"Money Box PRO purchase restored successfully.";
        [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"InAppPurchase"];
        [Flurry logEvent:@"Restore Purchase Successfully"];
        [Localytics tagEvent:@"Restore Purchase Successfully"];
        [FIRAnalytics logEventWithName:@"Restore_Purchase_Successfully"
                            parameters:nil];
    }
    else{
        [Flurry logEvent:@"Restore Purchase Failed"];
        [Localytics tagEvent:@"Restore Purchase Failed"];
        
        [FIRAnalytics logEventWithName:@"Restore_Purchase_Failed"
                            parameters:nil];
        str_Message = @"No purchase found.";
        
        [[GoalManagerAppDelegate getdefaultvalue]setObject:@"0" forKey:@"InAppPurchase"];
    }
    UIAlertView *alertRestore=[[UIAlertView alloc] initWithTitle:nil message:str_Message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertRestore show];
    
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    [self viewWillAppear:NO];
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    self.hud = nil;
}
- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    NSLog(@"%@",error);
    
    NSDictionary *articleParams = [NSDictionary dictionaryWithObjectsAndKeys:
                                   error.localizedDescription, @"RestorePurchseFailed",nil];
    
    [Flurry logEvent:@"Restore Purchase Failed" withParameters:articleParams];
    
    [Localytics tagEvent:@"Restore Purchase Failed"
              attributes:articleParams];
    
    [FIRAnalytics logEventWithName:@"Restore_Purchase_Failed"
                        parameters:articleParams];
    
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    
    UIAlertView *alertRestore=[[UIAlertView alloc] initWithTitle:nil message:@"Money Box PRO purchase restored fail." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertRestore show];
    
    [[GoalManagerAppDelegate getdefaultvalue]setObject:@"0" forKey:@"InAppPurchase"];
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    self.hud = nil;
}
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - All User Defined Functions

-(IBAction)action_Back:(id)sender
{
    if (![[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InAppPurchase"] isEqualToString:@"1"])
    {
        if ([[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"AdView"] == nil)
        {
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"AdView"];
        }
        else if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"AdView"] isEqualToString:@"1"])
        {
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"2" forKey:@"AdView"];
        }
        else if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"AdView"] isEqualToString:@"2"])
        {
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"3" forKey:@"AdView"];
        }
        else
        {
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"AdView"];
        }
        
        if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"AdView"]isEqualToString:@"3"])
        {
            [self createAndLoadInterstitial];
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createAndLoadInterstitial
{
    _interstitial =
    [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-5298130731078005/2952392171"];
    _interstitial.delegate=self;
    
    GADRequest *request = [GADRequest request];
    //request.testDevices = @[@"e33953a7d4e4e4fbac2a3e08d60e4f9db7abcdfa"];
    [_interstitial loadRequest:request];
}


- (void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    [_interstitial presentFromRootViewController:self];
    [[UIApplication sharedApplication]setStatusBarHidden:FALSE];
}

-(IBAction)action_SelectSwitch:(UISwitch*)sender
{
    if (sender.tag == 1)
    {
        if (isOnShowTotals == TRUE)
        {
            isOnShowTotals = FALSE;
            [self.switch_ShowTotals setOn:FALSE];
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"OFF" forKey:@"ShowTotals"];
        }
        else
        {
            isOnShowTotals = TRUE;
            [self.switch_ShowTotals setOn:TRUE];
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"ON" forKey:@"ShowTotals"];
        }
    }
}
-(IBAction)action_PRO:(UIButton *)sender
{
    UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"MoneyBox" message:NSLocalizedString(@"Please Upgrade to PRO version", nil)  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert3 show];
}

-(IBAction)action_SelectCurrency:(id)sender
{
    Currency_ViewController *obj_Currency_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"Currency_ViewController"];
    obj_Currency_ViewController.str_FromWhere = @"FromSetting";
    [self.navigationController pushViewController:obj_Currency_ViewController animated:YES];
}

-(IBAction)action_AboutApp:(id)sender
{
    AboutApp_ViewController *obj_AboutApp_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"AboutApp_ViewController"];
    [self.navigationController pushViewController:obj_AboutApp_ViewController animated:YES];
}


#pragma mark - AlertView Delegate
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
            [Localytics tagEvent:@"Clicked on Yes Notification"];
            [Flurry logEvent:@"Clicked on Yes Please Notification"];
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
//            if ([[UIApplication sharedApplication]respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
//            {
//                [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
//
//                [[UIApplication sharedApplication] registerForRemoteNotifications];
//            }
//            else
//            {
//                [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
//            }
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
}

@end
