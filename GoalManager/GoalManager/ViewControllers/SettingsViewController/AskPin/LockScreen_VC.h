//
//  LockScreen_VC.h
//  MoneyBoxFREE
//
//  Created by Maulik on 27/07/18.
//  Copyright © 2018 whitelotuscorporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoalManagerAppDelegate.h"
#import "GoalManager.h"
#import "Settings_ViewController.h"

@interface LockScreen_VC : UIViewController
{
    UIButton *btn_1;
    UIButton *btn_2;
    UIButton *btn_3;
    UIButton *btn_4;
    UIButton *btn_5;
    UIButton *btn_6;
    UIButton *btn_7;
    UIButton *btn_8;
    UIButton *btn_9;
    UIButton *btn_0;
    UIButton *btn_delete;
    UIButton *btn_clear;
    
    UILabel *lbl_1;
    UILabel *lbl_2;
    UILabel *lbl_3;
    UILabel *lbl_4;
    
    UIView *view_Lock;
    
    NSArray *ary_label;
    
    NSString *str_PinCode;
}

@property(nonatomic,retain) IBOutlet UIButton *btn_1;
@property(nonatomic,retain) IBOutlet UIButton *btn_2;
@property(nonatomic,retain) IBOutlet UIButton *btn_3;
@property(nonatomic,retain) IBOutlet UIButton *btn_4;
@property(nonatomic,retain) IBOutlet UIButton *btn_5;
@property(nonatomic,retain) IBOutlet UIButton *btn_6;
@property(nonatomic,retain) IBOutlet UIButton *btn_7;
@property(nonatomic,retain) IBOutlet UIButton *btn_8;
@property(nonatomic,retain) IBOutlet UIButton *btn_9;
@property(nonatomic,retain) IBOutlet UIButton *btn_0;
@property(nonatomic,retain) IBOutlet UIButton *btn_delete;
@property(nonatomic,retain) IBOutlet UIButton *btn_clear;
@property (weak, nonatomic) IBOutlet UIButton *btn_Back;
    @property (weak, nonatomic) IBOutlet UILabel *lbl_Heading;
    @property (weak, nonatomic) IBOutlet UILabel *lbl_SubHeading;
    @property (weak, nonatomic) IBOutlet UIView *view_Main;
    
@property(nonatomic,retain) IBOutlet UIView *view_Lock;

@property(nonatomic,retain) IBOutlet UILabel *lbl_1;
@property(nonatomic,retain) IBOutlet UILabel *lbl_2;
@property(nonatomic,retain) IBOutlet UILabel *lbl_3;
@property(nonatomic,retain) IBOutlet UILabel *lbl_4;

@property(nonatomic,retain)NSString *str_FromWhere;

@property(nonatomic,retain)id obj_Setting_VC;

-(IBAction) action_Enter_Pin:(id)sender;
@end
