//
//  Settings_ViewController.h
//  GoalManager
//
//  Created by apple on 11/11/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMobileAds;
#import "MBProgressHUD.h"
#import "InAppRageIAPHelper.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

#import "ChangePin_VC.h"
#import "NewPin_VC.h"
#import "ConfirmPin_VC.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface Settings_ViewController : UIViewController<UIScrollViewDelegate,MBProgressHUDDelegate,SKPaymentTransactionObserver,GADInterstitialDelegate,UIAlertViewDelegate>
{
    MBProgressHUD *hud;
    
    UIAlertView *alert1;
    
    BOOL isOnMasteCurrency;
    BOOL isOnShowTotals;
    
    BOOL isOnTouchID;
    BOOL isOnPasscode;
    
}

@property(nonatomic,retain)IBOutlet UIScrollView *scroll_Settings;
@property(nonatomic,retain)MBProgressHUD *hud;

@property(nonatomic,weak)IBOutlet UIView *view_InApp;
@property(nonatomic,weak)IBOutlet UIView *view_Main;

@property(nonatomic,weak)IBOutlet UIView *view_Notification;

@property(nonatomic,retain)IBOutlet GADBannerView *view_AD;
@property(nonatomic,retain)IBOutlet GADInterstitial *interstitial;
@property (weak, nonatomic) IBOutlet UILabel *lbl_LineOther;

@property(nonatomic,retain)IBOutlet NSString *str_OpenTouchID;

@property(nonatomic,weak)IBOutlet UILabel *lbl_Thanks;
@property(nonatomic,weak)IBOutlet UILabel *lbl_MasterCurrency;
@property(nonatomic,weak)IBOutlet UILabel *lbl_ArrowDown;
@property(nonatomic,weak)IBOutlet UISwitch *switch_ShowTotals;
@property(nonatomic,weak)IBOutlet UILabel *lbl_fb_connection;
@property(nonatomic,weak)IBOutlet UILabel *lbl_tw_connection;
@property(nonatomic,weak)IBOutlet UILabel *lbl_PRO;
@property (weak, nonatomic) IBOutlet UISwitch *switch_Reminder;
    @property (weak, nonatomic) IBOutlet UILabel *lbl_ShowAppGuide;
    @property (weak, nonatomic) IBOutlet UILabel *lbl_NotificationSetting;
    
@property (weak, nonatomic) IBOutlet UIButton *btn_ShowAppGuide;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Notification;
@property (weak, nonatomic) IBOutlet UIButton *btn_Notification;

@property(nonatomic,weak)IBOutlet UIButton *btn_MasterCurrency;
@property(nonatomic,weak)IBOutlet UIButton *btn_AboutApp;
@property(nonatomic,weak)IBOutlet UIButton *btn_Purchse;
@property(nonatomic,weak)IBOutlet UIButton *btn_Restore;
@property(nonatomic,weak)IBOutlet UIButton *btn_PRO;
    @property (weak, nonatomic) IBOutlet UILabel *lbl_Pro_TouchID;
    @property (weak, nonatomic) IBOutlet UISwitch *switch_TouchID;
    @property (weak, nonatomic) IBOutlet UIButton *btn_TouchID;
    
@property(nonatomic,weak)IBOutlet UIButton *btn_facebook;
@property(nonatomic,weak)IBOutlet UIButton *btn_twitter;
    @property (weak, nonatomic) IBOutlet UILabel *lbl_SecuritySettings;
    @property (weak, nonatomic) IBOutlet UILabel *lbl_TouchID;
    @property (weak, nonatomic) IBOutlet UILabel *lbl_PasscodeLock;
    @property (weak, nonatomic) IBOutlet UILabel *lbl_Pro_PasscodeLock;
    @property (weak, nonatomic) IBOutlet UISwitch *switch_PasscodeLock;
    @property (weak, nonatomic) IBOutlet UIButton *btn_PasscodeLock;
    @property (weak, nonatomic) IBOutlet UILabel *lbl_ChangePin;
    @property (weak, nonatomic) IBOutlet UILabel *lbl_Pro_ChangePin;
    @property (weak, nonatomic) IBOutlet UIButton *btn_ChangePin;
    @property (weak, nonatomic) IBOutlet UILabel *lbl_PasscodeandTouchIDSp;

-(void)action_PasscodeOff;
    
@end
