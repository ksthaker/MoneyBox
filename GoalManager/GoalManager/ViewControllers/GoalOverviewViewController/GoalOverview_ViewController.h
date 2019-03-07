//
//  GoalOverview_ViewController.h
//  GoalManager
//
//  Created by apple on 11/11/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goal.h"
#import "Contribution.h"
#import "GoalManagerAppDelegate.h"
#import "MBProgressHUD.h"

@import GoogleMobileAds;

@interface GoalOverview_ViewController : UIViewController<UIScrollViewDelegate,MBProgressHUDDelegate,GADInterstitialDelegate>
{
    UILabel *lbl_RightArrow;
    UILabel *lbl_Arrow;
    UILabel *lbl_Back;
    
    UILabel *lbl_GoalName;
    UILabel *lbl_GoalDate;
    UILabel *lbl_Amount;
    UILabel *lbl_SavingsNeeded;
    UILabel *lbl_NoImage;
    
    UIBarButtonItem *btn_Back;
    UIBarButtonItem *btn_Edit;
    UIBarButtonItem *btn_Dollar;
    
    UIButton *btn_GoalContributions;
    
    UIView *view_SavingAccount;
    UIView *view_SavingFrequency;
    UIView *view_ReminderTime;
    
    UIView *view_GoalProgress;
    UIView *view_GoalProgressOuter;
    
    UITextField *txt_SavigAccount;
    UITextField *txt_SavingFreqency;
    UITextField *txt_ReminderTime;
    
    UIImageView *imgView_GoalLogo;
    
    UIScrollView *scroll_GoalOverview;
    
    NSString *str_GoalIndex;
    NSString *str_FromWhere;
    
    MBProgressHUD *hud;
    UIAlertView *alert11;
   
    UIImageView *imgView_InitialScreen;
    
    
    UILabel *lbl_SavigAccount;
    UILabel *lbl_SavingFrequency;
    UILabel *lbl_ReminderTime;
}

@property(nonatomic,retain)IBOutlet UILabel *lbl_RightArrow;
@property(nonatomic,retain)IBOutlet UILabel *lbl_Arrow;
@property(nonatomic,retain)IBOutlet UILabel *lbl_Back;

@property(nonatomic,retain)IBOutlet UILabel *lbl_GoalName;
@property(nonatomic,retain)IBOutlet UILabel *lbl_GoalDate;
@property(nonatomic,retain)IBOutlet UILabel *lbl_Amount;
@property(nonatomic,retain)IBOutlet UILabel *lbl_SavingsNeeded;
@property(nonatomic,retain)IBOutlet UILabel *lbl_NoImage;

@property(nonatomic,retain)IBOutlet UIBarButtonItem *btn_Back;
@property(nonatomic,retain)IBOutlet UIBarButtonItem *btn_Edit;
@property(nonatomic,retain)IBOutlet UIBarButtonItem *btn_Dollar;

@property(nonatomic,retain)IBOutlet UIButton *btn_GoalContributions;

@property(nonatomic,retain)IBOutlet UIView *view_SavingAccount;
@property(nonatomic,retain)IBOutlet UIView *view_SavingFrequency;
@property(nonatomic,retain)IBOutlet UIView *view_ReminderTime;
@property(nonatomic,retain)IBOutlet UIView *view_GoalProgress;
@property(nonatomic,retain)IBOutlet UIView *view_GoalProgressOuter;

@property(nonatomic,retain)IBOutlet UIView *view_AdShowHide;

@property(nonatomic,retain)IBOutlet GADBannerView *view_AD;
@property(nonatomic, strong) GADInterstitial *interstitial;

@property(nonatomic,retain)IBOutlet UITextField *txt_SavigAccount;
@property(nonatomic,retain)IBOutlet UITextField *txt_SavingFreqency;
@property(nonatomic,retain)IBOutlet UITextField *txt_ReminderTime;

@property(nonatomic,retain)IBOutlet UIImageView *imgView_GoalLogo;

@property(nonatomic,retain)IBOutlet UIImageView *imgView_InitialScreen;

@property(nonatomic,retain)IBOutlet UIScrollView *scroll_GoalOverview;

@property(nonatomic,retain)MBProgressHUD *hud;

@property(nonatomic,retain)NSString * language;
@property(nonatomic,retain)NSString *str_GoalIndex;
@property(nonatomic,retain)NSString *str_FromWhere;
@property (strong, nonatomic)Goal *selected_Goal;

-(IBAction)action_GoalContributions:(id)sender;



@property(nonatomic,retain)IBOutlet UILabel *lbl_SavigAccount;
@property(nonatomic,retain)IBOutlet UILabel *lbl_SavingFrequency;
@property(nonatomic,retain)IBOutlet UILabel *lbl_ReminderTime;

@end
