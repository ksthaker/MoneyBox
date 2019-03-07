//
//  ContributionsLists_ViewController.h
//  GoalManager
//
//  Created by apple on 11/11/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contribution.h"
#import "Goal.h"
#import <iAd/iAd.h>
@import GoogleMobileAds;
@interface ContributionsLists_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSFetchedResultsControllerDelegate,GADInterstitialDelegate>
{
    UITableView *tbl_ContributionLists;
    
    UILabel *lbl_Back;
    UILabel *lbl_AddContribution;
    
    UIBarButtonItem *btn_Back;
    UIBarButtonItem *btn_AddContribution;
    
    UIView *view_NoContributions;
    
    NSInteger integer_SelectedReminderDay;
    
    
}
@property(nonatomic,retain)IBOutlet UITableView *tbl_ContributionLists;

@property(nonatomic,retain)IBOutlet UILabel *lbl_Back;
@property(nonatomic,retain)IBOutlet UILabel *lbl_AddContribution;

@property(nonatomic,retain)IBOutlet UIBarButtonItem *btn_Back;
@property(nonatomic,retain)IBOutlet UIBarButtonItem *btn_AddContribution;

@property (strong, nonatomic)NSFetchedResultsController *fetchedResultsController;

@property (strong, nonatomic)Contribution *contributionList;
@property (strong, nonatomic)Goal *selectedGoal;

@property(nonatomic,retain)IBOutlet GADBannerView *view_AD;
@property(nonatomic, strong) GADInterstitial *interstitial;

@property(nonatomic,retain)NSString * language;

@property (strong, nonatomic)NSManagedObjectContext *editingContext;

@property(nonatomic,retain)IBOutlet UIView *view_NoContributions;

@end
