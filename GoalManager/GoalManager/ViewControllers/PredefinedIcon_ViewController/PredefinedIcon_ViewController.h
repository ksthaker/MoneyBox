//
//  PredefinedIcon_ViewController.h
//  GoalManager
//
//  Created by apple on 22/12/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface PredefinedIcon_ViewController : UIViewController<GADInterstitialDelegate>

{
    UILabel *lbl_ArrowDown;
    UILabel *lbl_Back;
    UIBarButtonItem *btn_Back;
    
    UITableView *tbl_predefinelist;
}

@property (nonatomic, retain) IBOutlet UITableView *tbl_predefinelist;

@property (nonatomic, retain) NSMutableArray *muary_prelist;
@property (nonatomic, retain) NSMutableArray *muary_prelist2;

@property (nonatomic, retain) UILabel *lbl_ArrowDown;
@property (nonatomic, retain) UILabel *lbl_Back;
@property(nonatomic, strong) GADInterstitial *interstitial;
@property (nonatomic, retain) UIBarButtonItem *btn_Back;

@end
