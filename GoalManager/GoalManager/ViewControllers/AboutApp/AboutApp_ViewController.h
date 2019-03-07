//
//  AboutApp_ViewController.h
//  MoneyBoxFREE
//
//  Created by apple on 10/01/17.
//  Copyright © 2017 whitelotuscorporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
@interface AboutApp_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate,UINavigationControllerDelegate,MFMessageComposeViewControllerDelegate,GADInterstitialDelegate>

@property(nonatomic,retain)NSMutableArray *muary_AboutApp;
@property(nonatomic,retain)NSMutableArray *muary_AboutAppLink;

@property(nonatomic,weak)IBOutlet UIImageView *imgView_Logo;
@property(nonatomic,weak)IBOutlet UITableView *tbl_AboutApp;


@property(nonatomic,weak)IBOutlet UITableView *tbl_AboutAppLink;

@property(nonatomic,weak)IBOutlet UILabel *lbl_Name;
@property(nonatomic,weak)IBOutlet UIImageView *imgView_Logo_debit_app;
@property(nonatomic,weak)IBOutlet UIButton *get_debit_app;

@property(nonatomic, strong) GADInterstitial *interstitial;
@end
