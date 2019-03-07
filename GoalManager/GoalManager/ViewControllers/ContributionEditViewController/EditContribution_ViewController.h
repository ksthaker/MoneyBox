//
//  EditContribution_ViewController.h
//  GoalManager
//
//  Created by apple on 11/11/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Contribution.h"
#import "Goal.h"
#import "CoreData+MagicalRecord.h"
#import <FacebookSDK/FacebookSDK.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface EditContribution_ViewController : UIViewController<UITextFieldDelegate,GADInterstitialDelegate>
{
    UILabel *lbl_Back;
    
    UIBarButtonItem *btn_Back;
    UIBarButtonItem *btn_SaveContribution;
    
    UITextField *txt_Amount;
    UITextField *txt_Notes;
    
    BOOL isInternet;
    BOOL alert_achive;
    BOOL alert_milestone;
    
    UIDatePicker *datePicker_ContributionDate;
    
    UIView *view_DatePicker;
    UIView *view_Amount;
    UIView *view_Notes;
    
    NSString *str_OldAmount, *str_text_share, *str_milestone_persentage;
    
    NSString *str_ContributionAddedDate;
    
    NSInteger integer_SelectedReminderDay;
}
@property(nonatomic,retain)IBOutlet UILabel *lbl_Back;

@property(nonatomic,retain)IBOutlet UIBarButtonItem *btn_Back;
@property(nonatomic,retain)IBOutlet UIBarButtonItem *btn_SaveContribution;

@property(nonatomic,retain)IBOutlet UITextField *txt_Amount;
@property(nonatomic,retain)IBOutlet UITextField *txt_Notes;

@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker_ContributionDate;

@property(nonatomic,retain)IBOutlet UIView *view_DatePicker;
@property(nonatomic,retain)IBOutlet UIView *view_Amount;
@property(nonatomic,retain)IBOutlet UIView *view_Notes;

@property(nonatomic,retain)NSString *str_ContributionAddedDate;

@property(nonatomic,retain)NSString * language;

@property (strong, nonatomic)Contribution *contributionEdit;
@property (strong, nonatomic)Goal *selectedGoal;

@property(nonatomic,retain)NSString *str_OldAmount;

@property (strong, nonatomic)NSManagedObjectContext *editingContext;
@property(readonly, strong, nonatomic)NSArray *goal;



@property(nonatomic,weak)IBOutlet UILabel *lbl_Date;
@property(nonatomic,weak)IBOutlet UILabel *lbl_DateArrow;

@property(nonatomic,weak)IBOutlet UIButton *btn_Date;
@property(nonatomic,weak)IBOutlet UIButton *btn_DoneDate;
@property(nonatomic,weak)IBOutlet UIButton *btn_CancelDate;


@property(nonatomic,retain)IBOutlet UIView *view_Shadow;
@property(nonatomic, strong) GADInterstitial *interstitial;

@end
