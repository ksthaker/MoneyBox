//
//  ViewController.h
//  GoalManager
//
//  Created by apple on 10/11/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Goal.h"
#import "Contribution.h"
#import "MBProgressHUD.h"
#import "InAppRageIAPHelper.h"
#import <LocalAuthentication/LocalAuthentication.h>

@import GoogleMobileAds;

@interface GoalManager_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate,GADInterstitialDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
{
    BOOL isInternet;
    
    UITableView *tbl_GoalLists;
    
    UIButton *btn_CompletedGoals;
    UIButton *btn_Settings;
    
    UIButton *btn_AddGoal;
    UIButton *btn_FilterGoal;
    
    UILabel *lbl_AddGoal;
    UILabel *lbl_Settings;
    UILabel *lbl_ArrowUp;
    UILabel *lbl_TotalForAllActiveGoals;
    UILabel *lbl_Filter;
    UILabel *lbl_MainGoal;
    
    UIView *view_Main;
    UIView *view_Totals;
    UIView *view_InnerTotalForAllActiveGoals;
    UIView *view_OuterTotalForAllActiveGoals;
    
    MBProgressHUD *hud;
    
    UIImageView *imgView_InitialScreen;
    
    UIAlertView *alert11;
    
}
@property(nonatomic,retain)IBOutlet UIButton *btn_CompletedGoals;

@property(nonatomic,retain)IBOutlet UITableView *tbl_GoalLists;

@property(nonatomic,retain)IBOutlet UIButton *btn_Settings;
@property(nonatomic,retain)IBOutlet UIButton *btn_AddGoal;
@property(nonatomic,retain)IBOutlet UIButton *btn_FilterGoal;

@property(nonatomic,retain)IBOutlet UILabel *lbl_AddGoal;
@property(nonatomic,retain)IBOutlet UILabel *lbl_Settings;
@property(nonatomic,retain)IBOutlet UILabel *lbl_ArrowUp;
@property(nonatomic,retain)IBOutlet UILabel *lbl_TotalForAllActiveGoals;
@property(nonatomic,retain)IBOutlet UILabel *lbl_Filter;
@property(nonatomic,retain)IBOutlet UILabel *lbl_MainGoal;

@property(nonatomic,retain)IBOutlet UIView *view_Totals;
@property(nonatomic,retain)IBOutlet UIView *view_Main;
@property (weak, nonatomic) IBOutlet UIView *view_Lock;
@property (weak, nonatomic) IBOutlet UIView *view_Lock2;
@property (weak, nonatomic) IBOutlet UIView *view_Lock3;

@property(nonatomic,retain)IBOutlet GADBannerView *bannerView;
@property(nonatomic, strong) GADInterstitial *interstitial;

@property(nonatomic,retain)IBOutlet UIView *view_InnerTotalForAllActiveGoals;
@property(nonatomic,retain)IBOutlet UIView *view_OuterTotalForAllActiveGoals;

@property(nonatomic,retain)IBOutlet UIImageView *imgView_InitialScreen;
@property (weak, nonatomic) IBOutlet UIImageView *imgView_Lock;

@property (strong, nonatomic)NSManagedObjectContext *editingContext;

@property (strong, nonatomic)NSFetchedResultsController *fetchedResultsController;

@property(nonatomic,weak)IBOutlet UIView *view_NoGoal;
@property(nonatomic,weak)IBOutlet UIButton *btn_AddGoalNew;

@property(nonatomic,retain)UIImageView *aView;
@property(nonatomic,weak)IBOutlet UIImageView *imgView_LockTable1;
@property(nonatomic,weak)IBOutlet UIImageView *imgView_LockTable2;

@property(nonatomic,retain)NSString * language;

@property (strong, nonatomic)Goal *goalList;

@property(nonatomic,retain)MBProgressHUD *hud;

-(IBAction)action_CompletedGoals:(id)sender;


@end

