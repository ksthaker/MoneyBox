//
//  Currency_ViewController.h
//  GoalManager
//
//  Created by apple on 12/11/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface Currency_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,GADInterstitialDelegate>
{
    UITableView *tbl_CurrencyList;
    
    NSMutableArray *muary_CurrencyList;
    
    NSString *str_FromWhere;
    
    NSMutableArray *muary_CheckBox;
    
    BOOL isChecked;
    
    NSString *str_SelectedCurrency;
    
    UILabel *lbl_Back;
    
    UIBarButtonItem *btn_Back;
}
@property(nonatomic,retain)IBOutlet UITableView *tbl_CurrencyList;

@property(nonatomic,retain)NSMutableArray *muary_CurrencyList;
@property(nonatomic,retain)NSString *str_FromWhere;

@property(nonatomic,retain)NSMutableArray *muary_CheckBox;
@property(nonatomic,retain)NSString *str_SelectedCurrency;

@property(nonatomic,retain)IBOutlet UILabel *lbl_Back;

@property(nonatomic,retain)IBOutlet UIBarButtonItem *btn_Back;
@property(nonatomic, strong) GADInterstitial *interstitial;

@end
