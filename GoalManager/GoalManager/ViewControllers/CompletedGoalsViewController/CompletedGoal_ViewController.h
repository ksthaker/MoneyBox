//
//  CompletedGoal_ViewController.h
//  GoalManager
//
//  Created by apple on 11/11/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Goal.h"
#import "CoreData+MagicalRecord.h"

@import GoogleMobileAds;

@interface CompletedGoal_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate,UIActionSheetDelegate,GADInterstitialDelegate>

{
    UITableView *tbl_CompletedGoalLists;
    
    UIBarButtonItem *btn_Settings;
    UIBarButtonItem *btn_AddGoal;
    
    UILabel *lbl_AddGoal;
    UILabel *lbl_Settings;
    UILabel *lbl_ArrowDown;
    UILabel *lbl_TotalForAllActiveGoals;
    
    UIView *view_Totals;
    UIView *view_InnerTotalForAllActiveGoals;
}

@property(nonatomic,retain)IBOutlet UITableView *tbl_CompletedGoalLists;
@property(nonatomic,retain)IBOutlet UIBarButtonItem *btn_Settings;
@property(nonatomic,retain)IBOutlet UIBarButtonItem *btn_AddGoal;

@property(nonatomic,retain)IBOutlet UILabel *lbl_AddGoal;
@property(nonatomic,retain)IBOutlet UILabel *lbl_Settings;
@property(nonatomic,retain)IBOutlet UILabel *lbl_ArrowDown;
@property(nonatomic,retain)IBOutlet UILabel *lbl_TotalForAllActiveGoals;

@property(nonatomic,retain)IBOutlet UIView *view_Totals;
@property(nonatomic,retain)IBOutlet UIView *view_InnerTotalForAllActiveGoals;

@property(strong, nonatomic)NSManagedObjectContext *editingContext;

@property(strong, nonatomic)NSFetchedResultsController *fetchedResultsController;

@property(nonatomic, strong) GADInterstitial *interstitial;

@property(strong, nonatomic)Goal *goalList;


@end
