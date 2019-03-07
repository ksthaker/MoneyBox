//
//  ShareViewController.h
//  MoneyBoxFREE
//
//  Created by apple on 7/21/17.
//  Copyright © 2017 whitelotuscorporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goal.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
//#import <Twitter/Twitter.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
//#import <TwitterKit/TwitterKit.h>

@interface ShareViewController : UIViewController<GADInterstitialDelegate>
{
    BOOL goal_amount_check;
    BOOL goal_progress_check;
    BOOL goal_target_date_check;
    double percent;
    
}



@property(nonatomic,weak)IBOutlet UIButton *btn_goal_amount;
@property(nonatomic,weak)IBOutlet UIButton *btn_goal_progress;
@property(nonatomic,weak)IBOutlet UIButton *btn_goal_target;
@property(nonatomic,weak)IBOutlet UIImageView *img_goal;
@property(nonatomic,weak)IBOutlet UIImageView *imgView_Logo;

@property(nonatomic,weak)IBOutlet UIButton *btn_share_goal;

@property(nonatomic,weak)IBOutlet UILabel *lbl_goal_amount;
@property(nonatomic,weak)IBOutlet UILabel *lbl_goal_progress;
@property(nonatomic,weak)IBOutlet UILabel *lbl_goal_target;

@property(nonatomic,weak)IBOutlet UILabel *lbl_title_text;
@property(nonatomic,weak)IBOutlet UILabel *lbl_goal_text;
@property(nonatomic,weak)IBOutlet UILabel *lbl_date_text;

@property(nonatomic,weak)IBOutlet UILabel *goal_amount;
@property(nonatomic,weak)IBOutlet UILabel *goal_target;
@property(nonatomic,weak)IBOutlet UILabel *goal_progress;
@property(nonatomic,weak)IBOutlet UILabel *lbl_animation_progress;

@property(nonatomic,weak)IBOutlet UILabel *lbl_what_goal;
@property(nonatomic,weak) Goal *goal_details;
@property(nonatomic,weak) NSString *language;
@property(nonatomic,weak)IBOutlet UIView *view_CompletedStage;
@property(nonatomic,weak)IBOutlet UIView *view_CompletedStageOuter;
@property(nonatomic,weak)IBOutlet UIView *view_bottom;
@property(nonatomic,weak) NSString *str_from;
@property(nonatomic,weak) NSString *str_contribution_total;
@property(nonatomic,weak) NSString *str_goal_total;
@property(nonatomic,weak) NSString *str_main;
@property(nonatomic, strong) GADInterstitial *interstitial;



@end
