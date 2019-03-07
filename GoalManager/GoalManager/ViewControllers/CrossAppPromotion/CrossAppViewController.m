//
//  CrossAppViewController.m
//  MoneyBoxFREE
//
//  Created by Maulik on 13/04/18.
//  Copyright © 2018 whitelotuscorporation. All rights reserved.
//

#import "CrossAppViewController.h"
#import "GoalManagerAppDelegate.h"
@interface CrossAppViewController ()

@end

@implementation CrossAppViewController

- (void)viewDidLoad {
    
    self.imgView_Logo.layer.cornerRadius = 15;
    self.imgView_Logo.clipsToBounds = YES;
    
    self.btn_Open.layer.cornerRadius = 10;
    self.btn_Open.clipsToBounds = YES;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{

    [Localytics tagEvent:@"Cross App View"];
    [Flurry logEvent:@"Cross App View"];
    
    [FIRAnalytics logEventWithName:@"Cross_App_View"
                        parameters:nil];
}

- (IBAction)action_Close:(UIButton *)sender {
    
    [Localytics tagEvent:@"Cross App Cancel Click"];
    [Flurry logEvent:@"Cross App Cancel Click"];
    
    [FIRAnalytics logEventWithName:@"Cross_App_Cancel_Click"
                        parameters:nil];
    
    [[GoalManagerAppDelegate getdefaultvalue]setObject:@"11" forKey:@"CrossAppSeeLater"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)action_Open:(UIButton *)sender {
    
    [Localytics tagEvent:@"Cross App Open Click"];
    [Flurry logEvent:@"Cross App Open Click"];
    [FIRAnalytics logEventWithName:@"Cross_App_Open_Click"
                        parameters:nil];
    
    [[GoalManagerAppDelegate getdefaultvalue]setObject:@"11" forKey:@"CrossAppSeeLater"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)
    {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/debt-free-box-snowball/id1240710873?ls=1&mt=8"] options:[NSDictionary dictionary] completionHandler:nil];
    }
    else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/debt-free-box-snowball/id1240710873?ls=1&mt=8"]];
    }
}

- (IBAction)action_SeeLater:(UIButton *)sender {
    
    [Localytics tagEvent:@"Cross App See Later Click"];
    [Flurry logEvent:@"Cross App See Later Click"];
    [FIRAnalytics logEventWithName:@"Cross_App_See_Later_Click"
                        parameters:nil];
    
    [[GoalManagerAppDelegate getdefaultvalue]setObject:@"" forKey:@"CrossAppSeeLater"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
