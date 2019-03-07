//
//  Filter_ViewController.m
//  MoneyBoxFREE
//
//  Created by apple on 29/04/15.
//  Copyright (c) 2015 whitelotuscorporation. All rights reserved.
//

#import "Filter_ViewController.h"
#import "UIViewController+KNSemiModal.h"
#import "GoalManagerAppDelegate.h"
@interface Filter_ViewController ()

@end

@implementation Filter_ViewController
@synthesize btn_Alphabetically,btn_ByDueDate;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = false;
    [Localytics tagEvent:@"Goal Sorting"];
    [Flurry logEvent:@"Goal Sorting"];
    [FIRAnalytics logEventWithName:@"Goal_Sorting"
                        parameters:nil];
    [super viewWillAppear:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self dismissSemiModalView];
}
-(IBAction)action_SelectSortingType:(UIButton *)sender{
    if (sender.tag == 1)
    {
        [[GoalManagerAppDelegate getdefaultvalue]setObject:@"DueDate" forKey:@"SortingType"];
    }
    else
    {
        [[GoalManagerAppDelegate getdefaultvalue]setObject:@"Alphabetically" forKey:@"SortingType"];
    }
    if ([self.str_FromWhere isEqualToString:@"FromCompleted"]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"CompletedGoal_ViewController" object:nil];
    }
    else{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"GoalManager_ViewController" object:nil];
    }
    [self dismissSemiModalView];
}@end
