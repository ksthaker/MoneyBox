//
//  ShareViewController.m
//  MoneyBoxFREE
//
//  Created by apple on 7/21/17.
//  Copyright © 2017 whitelotuscorporation. All rights reserved.
//

#import "ShareViewController.h"
#import "GoalManagerAppDelegate.h"
#import "Contribution.h"
#import "GoalManager.h"
#import "Settings_ViewController.h"

//#import <TwitterKit/TwitterKit.h>
@interface ShareViewController ()

@end

@implementation ShareViewController
@synthesize lbl_date_text,lbl_goal_text,lbl_title_text,lbl_goal_amount,lbl_goal_target,lbl_goal_progress,btn_goal_amount,btn_goal_target,btn_goal_progress,goal_amount,goal_target,goal_progress,lbl_what_goal,goal_details,language,view_CompletedStage,view_CompletedStageOuter,view_bottom,str_goal_total,str_contribution_total,str_main;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.language = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSString *string = self.language;
    if ([string rangeOfString:@"zh-Hans"].location != NSNotFound) {
        NSLog(@"string contains bla!");
        self.language = @"zh-Hans";
    } else if ([string rangeOfString:@"es"].location != NSNotFound) {
        self.language = @"es";
    }
    else if ([string rangeOfString:@"ja"].location != NSNotFound){
        self.language = @"ja";
    }

    // Do any additional setup after loading the view.
    [self.btn_goal_amount setBackgroundImage:[UIImage imageNamed:@"checkbox_a.png"] forState:UIControlStateNormal];
    
    [self.btn_goal_progress setBackgroundImage:[UIImage imageNamed:@"checkbox_a.png"] forState:UIControlStateNormal];
    
    [self.btn_goal_target setBackgroundImage:[UIImage imageNamed:@"checkbox_a.png"] forState:UIControlStateNormal];
    
     self.title = NSLocalizedString(@"Share Goal", nil);
    self.goal_amount.text = NSLocalizedString(@"Goal Amount",nil);
     self.goal_target.text = NSLocalizedString(@"Target Date",nil);
     self.goal_progress.text = NSLocalizedString(@"Goal Progress",nil);
    
    self.lbl_what_goal.text = NSLocalizedString(@"WHAT INFORMATION DO YOU WANT TO SHARE",nil);
    
    UIImage* image2 = [UIImage imageNamed:@"navbar_cancel.png"];
    CGRect frameimg2 = CGRectMake(0, 0,22,22);
    UIButton *someButton2 = [[UIButton alloc] initWithFrame:frameimg2];
    [someButton2 setBackgroundImage:image2 forState:UIControlStateNormal];
    [someButton2 addTarget:self action:@selector(action_Back:)
          forControlEvents:UIControlEventTouchUpInside];
    [someButton2 setSelected:YES];
    
    UIBarButtonItem *btn_Close= [[UIBarButtonItem alloc]initWithCustomView:someButton2];
    NSArray *arr_AddFilterGoalleft= [[NSArray alloc] initWithObjects:btn_Close,nil];
    self.navigationItem.leftBarButtonItems = arr_AddFilterGoalleft;

    [self.btn_share_goal setTitle:NSLocalizedString(@"SHARE GOAL",nil) forState:UIControlStateNormal];
    self.lbl_animation_progress.hidden = false;
    self.lbl_date_text.hidden = false;
    
    self.imgView_Logo.layer.cornerRadius = 5;
    self.imgView_Logo.clipsToBounds = YES;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = false;
    [super viewWillAppear:animated];
    
    NSLog(@"%@",self.goal_details.g_contributedamount);
    
    double goalTotal = [goal_details.g_amount doubleValue];
    NSString *newtotal = [NSString stringWithFormat:@"%.2f",goalTotal];
    NSString *test=[GoalManagerAppDelegate Change_String_Formate:newtotal];
    str_goal_total = test;
    
    self.lbl_goal_amount.text = [NSString stringWithFormat:@"%@ %@",str_goal_total,goal_details.g_currency];
 
     self.lbl_goal_text.text = [NSString stringWithFormat:@"%@",goal_details.g_title];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter1 dateFromString:goal_details.g_targetdate];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd, yyyy"];
    NSString *localDateString = [dateFormatter stringFromDate:date];
    NSString *str_By = [NSString stringWithFormat:NSLocalizedString(@"By", nil)];
   
    
    if ([self.language isEqualToString:@"zh-Hans"])
    {
        NSLog(@"%@",localDateString);
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"yyyy年M月d日'"];
        NSString *localDateString = [dateFormatter stringFromDate:date];
        self.lbl_goal_target.text = [NSString stringWithFormat:@"%@",localDateString];
        self.lbl_date_text.text = [NSString stringWithFormat:@"%@",localDateString];
        NSLog(@"%@",localDateString);
    }
    else
    {
        self.lbl_goal_target.text = [NSString stringWithFormat:@"%@ %@",str_By,localDateString];
        self.lbl_date_text.text = [NSString stringWithFormat:@"%@ %@",str_By,localDateString];
    }
    
    if ([self.goal_details g_picture] == nil)
    {
        self.img_goal.image = [UIImage imageNamed:@"camera1.png"];
    }
    else
    {
        self.img_goal.image = [UIImage imageWithData:[self.goal_details g_picture]];
    }

    self.img_goal.layer.cornerRadius = self.img_goal.frame.size.width/2;
    self.img_goal.clipsToBounds = YES;
    
    id a = goal_details.objectID;
    NSPredicate *m = [NSPredicate predicateWithFormat:@"(r_goal == %@)",a];
    
    NSMutableArray *muary_TotalOfContribution = [[NSMutableArray alloc]init];
    [muary_TotalOfContribution addObjectsFromArray:[Contribution MR_findAllWithPredicate:m]];
    
    double TotalOfContribution = 0.0;
    for (int i = 0; i<muary_TotalOfContribution.count; i++)
    {
        Contribution *GoalContribution = [muary_TotalOfContribution objectAtIndex:i];
        TotalOfContribution += [GoalContribution.c_amount doubleValue];
    }

    
    NSString *newcontri = [NSString stringWithFormat:@"%.2f",TotalOfContribution];
    NSString *testcontri=[GoalManagerAppDelegate Change_String_Formate:newcontri];
    str_contribution_total = testcontri;
    
    double total=[goal_details.g_amount doubleValue];
    
    double recent=TotalOfContribution;
    
    percent=recent*100/total;
    
    self.lbl_animation_progress.text = [NSString stringWithFormat:@"%@ (%.2f%%) of %@ %@",str_contribution_total,percent,str_goal_total,goal_details.g_currency];

    self.view_CompletedStage.frame=CGRectMake(self.view_CompletedStage.frame.origin.x,self.view_CompletedStage.frame.origin.y,0, self.view_CompletedStage.frame.size.height);
    self.view_CompletedStage.layer.cornerRadius = 12;
    self.view_CompletedStage.clipsToBounds = YES;
    
    self.view_CompletedStageOuter.layer.cornerRadius = 12;
    self.view_CompletedStageOuter.clipsToBounds = YES;
    
    NSLog(@"%.2f",percent);
    
    double len = 0.0;
    
    if (isiPhone6)
    {
        len=percent*337/100;
        
        if(len > 337)
        {
            len = 337;
        }
        else if (len < 0)
        {
            len = 0;
        }
    }
    else if (isiPhone6Plus)
    {
        len=percent*374/100;
        
        if(len > 374)
        {
            len = 374;
        }
        else if (len < 0)
        {
            len = 0;
        }
    }
    else if (isiPhoneX)
    {
        len=percent*337/100;
        
        if(len > 337)
        {
            len = 337;
        }
        else if (len < 0)
        {
            len = 0;
        }
    }
    else
    {
        len=percent*280/100;
        
        if(len > 280)
        {
            len = 280;
        }
        else if (len < 0)
        {
            len = 0;
        }
    }

    
    [UIView animateWithDuration:3
                     animations:^{
                         CGRect frame = self.view_CompletedStage.frame;
                         if (isiPhone5)
                             frame.size.width = len;
                         else if (isiPhone6)
                             frame.size.width = len;
                         else if (isiPhone6Plus)
                             frame.size.width = len;
                         else if (isiPhoneX)
                             frame.size.width = len;
                         else
                             frame.size.width = len;
                         
                         self.view_CompletedStage.frame = frame;
                         
                     } completion:nil];
    
    //
    
    self.lbl_goal_progress.text = [NSString stringWithFormat:@"%.2f%%",percent];
    goal_amount_check = true;
    goal_progress_check = true;
    goal_target_date_check = true;
    
    if ([self.str_from isEqualToString:@"AddGoal"])
    {
        
        str_main =  [NSString stringWithFormat:@"I just created savings goal \"%@\" in Money Box",goal_details.g_title];
        
        NSMutableAttributedString *attributedString =[[NSMutableAttributedString alloc] initWithString:str_main];
        
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[UIColor colorWithRed:34.0/255.0 green:158.0/255.0 blue:196.0/255.0 alpha:1.0]
                                 range:[str_main rangeOfString:@"Money Box"]];
        
        self.lbl_title_text.attributedText = attributedString;

    }
    else if ([self.str_from isEqualToString:@"GoalOverview"])
    {
        NSString *string = [[NSLocale preferredLanguages] objectAtIndex:0];
        
        
        
        if ([string rangeOfString:@"zh-Hans"].location != NSNotFound)
        {
            str_main =  [NSString stringWithFormat:@"我在Money Box设定了储蓄目标 “%@”",goal_details.g_title];
        }
        else if ([string rangeOfString:@"es"].location != NSNotFound)
        {
            str_main =  [NSString stringWithFormat:@"Tengo un objetivo de ahorro \"%@\" en Money Box",goal_details.g_title];
        }
        else if ([string rangeOfString:@"ja"].location != NSNotFound)
        {
            str_main =  [NSString stringWithFormat:@"Money Boxで貯蓄目標 \"%@\" を立てています",goal_details.g_title];
        }
        else
        {
            str_main =  [NSString stringWithFormat:@"I have a savings goal \"%@\" in Money Box",goal_details.g_title];
        }

        
        NSMutableAttributedString *attributedString =[[NSMutableAttributedString alloc] initWithString:str_main];
        
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[UIColor colorWithRed:34.0/255.0 green:158.0/255.0 blue:196.0/255.0 alpha:1.0]
                                 range:[str_main rangeOfString:@"Money Box"]];
        
        self.lbl_title_text.attributedText = attributedString;
    }
    else
    {
  
        
        if (percent > 0)
        {
            
            if (percent > 100 || percent == 100 )
            {
                
                str_main =  [NSString stringWithFormat:@"I just achieved savings goal \"%@\" in Money Box",goal_details.g_title];
            }
            else if (percent > 90 || percent == 90 )
            {
                NSString *half = @"90.00%";
                str_main =  [NSString stringWithFormat:@"I just achieved %@ of my savings goal \"%@\" in Money Box",half,goal_details.g_title];
            }
            else if(percent > 50 || percent == 50 )
            {
                NSString *half = @"50.00%";
                str_main =  [NSString stringWithFormat:@"I just achieved %@ of my savings goal \"%@\" in Money Box",half,goal_details.g_title];
            }
            else
            {
                str_main =  [NSString stringWithFormat:@"I just added money to my savings goal \"%@\" in Money Box",goal_details.g_title];
            }
            
        }
        else
        {
            str_main =  [NSString stringWithFormat:@"I just created savings goal \"%@\" in Money Box",goal_details.g_title];
        }
        NSLog(@"%@",str_main);
        
        
        NSMutableAttributedString *attributedString =[[NSMutableAttributedString alloc] initWithString:str_main];
        
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[UIColor colorWithRed:34.0/255.0 green:158.0/255.0 blue:196.0/255.0 alpha:1.0]
                                 range:[str_main rangeOfString:@"Money Box"]];
        
        self.lbl_title_text.attributedText = attributedString;

    }
}

#pragma mark - All User Defined Functions

-(IBAction)action_Back:(id)sender
{
    if (![[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InAppPurchase"] isEqualToString:@"1"])
    {
        if ([[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"AdView"] == nil)
        {
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"AdView"];
        }
        else if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"AdView"] isEqualToString:@"1"])
        {
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"2" forKey:@"AdView"];
        }
        else if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"AdView"] isEqualToString:@"2"])
        {
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"3" forKey:@"AdView"];
        }
        else
        {
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"AdView"];
        }
        
        if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"AdView"]isEqualToString:@"3"])
        {
            [self createAndLoadInterstitial];
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createAndLoadInterstitial
{
    _interstitial =
    [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-5298130731078005/2952392171"];
    _interstitial.delegate=self;
    
    GADRequest *request = [GADRequest request];
    //request.testDevices = @[ @"e33953a7d4e4e4fbac2a3e08d60e4f9db7abcdfa"];
    [_interstitial loadRequest:request];
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    [_interstitial presentFromRootViewController:self];
    
    [[UIApplication sharedApplication]setStatusBarHidden:FALSE];
}


-(IBAction)action_goal_amount:(id)sender
{
    if ([[self.btn_goal_amount backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"checkbox.png"]])
    {
        [self.btn_goal_amount setBackgroundImage:[UIImage imageNamed:@"checkbox_a.png"] forState:UIControlStateNormal];
        goal_amount_check = true;
    }
    else
    {
         [self.btn_goal_amount setBackgroundImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
         goal_amount_check = false;
    }
     [self check_selection];
}

-(IBAction)action_goal_target:(id)sender
{
   if ([[self.btn_goal_target backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"checkbox.png"]])
    {
        [self.btn_goal_target setBackgroundImage:[UIImage imageNamed:@"checkbox_a.png"] forState:UIControlStateNormal];
        goal_target_date_check = true;
    }
    else
    {
          [self.btn_goal_target setBackgroundImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        goal_target_date_check = false;
    }
     [self check_selection];

}

-(IBAction)action_goal_progress:(id)sender
{
    if ([[self.btn_goal_progress backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"checkbox.png"]])
    {
       
        [self.btn_goal_progress setBackgroundImage:[UIImage imageNamed:@"checkbox_a.png"] forState:UIControlStateNormal];
        goal_progress_check = true;
    }
    else
    {
        [self.btn_goal_progress setBackgroundImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        goal_progress_check = false;
        
    }
    [self check_selection];
}

-(void)check_selection
{
    NSString *str_of_total = NSLocalizedString(@"of total goal amount", nil);
    double goalTotal = [goal_details.g_amount doubleValue];
    NSString *new = [NSString stringWithFormat:@"%.2f",goalTotal];
    NSString *test=[GoalManagerAppDelegate Change_String_Formate:new];
    str_goal_total = test;
    
    id a = goal_details.objectID;
    NSPredicate *m = [NSPredicate predicateWithFormat:@"(r_goal == %@)",a];
    
    NSMutableArray *muary_TotalOfContribution = [[NSMutableArray alloc]init];
    [muary_TotalOfContribution addObjectsFromArray:[Contribution MR_findAllWithPredicate:m]];
    
    double TotalOfContribution = 0.0;
    for (int i = 0; i<muary_TotalOfContribution.count; i++)
    {
        Contribution *GoalContribution = [muary_TotalOfContribution objectAtIndex:i];
        TotalOfContribution += [GoalContribution.c_amount doubleValue];
    }
    
    
    NSString *newcontri = [NSString stringWithFormat:@"%.2f",TotalOfContribution];
    NSString *testcontri=[GoalManagerAppDelegate Change_String_Formate:newcontri];
    str_contribution_total = testcontri;
    
    
    if (goal_amount_check == true && goal_progress_check == false && goal_target_date_check == false)
    {
        self.lbl_animation_progress.text = [NSString stringWithFormat:@"%@ %@",str_goal_total,goal_details.g_currency];
        self.lbl_date_text.hidden = true;
        self.lbl_animation_progress.hidden = false;
        self.view_CompletedStage.hidden = true;
        
    }
    else if (goal_amount_check == true && goal_progress_check == true && goal_target_date_check == false)
    {
        self.lbl_animation_progress.text = [NSString stringWithFormat:@"%@ (%.2f%%) of %@ %@",str_contribution_total,percent,str_goal_total,goal_details.g_currency];
        self.lbl_date_text.hidden = true;
        self.lbl_animation_progress.hidden = false;
        self.view_CompletedStage.hidden = false;
        
    }
    else if (goal_amount_check == true && goal_progress_check == false && goal_target_date_check == true)
    {
        self.lbl_animation_progress.text = [NSString stringWithFormat:@"%@ %@",str_goal_total,goal_details.g_currency];
        self.lbl_date_text.hidden = false;
        self.lbl_animation_progress.hidden = false;
        self.view_CompletedStage.hidden = true;
    }
    else if (goal_amount_check == false && goal_progress_check == true && goal_target_date_check == false)
    {
        self.lbl_animation_progress.text = [NSString stringWithFormat:@"%.2f%% %@",percent,str_of_total];
        self.lbl_animation_progress.hidden = false;
        self.lbl_date_text.hidden = true;
        self.view_CompletedStage.hidden = false;
    }
    else if (goal_amount_check == false && goal_progress_check == true && goal_target_date_check == true)
    {
        self.lbl_animation_progress.text = [NSString stringWithFormat:@"%.2f%% %@",percent,str_of_total];
        self.lbl_date_text.hidden = false;
        self.lbl_animation_progress.hidden = false;
        self.view_CompletedStage.hidden = false;
    }
    else if (goal_amount_check == false && goal_progress_check == false && goal_target_date_check == true)
    {
        self.lbl_animation_progress.text = [NSString stringWithFormat:@"%@ %@",str_contribution_total,str_of_total];
        self.lbl_date_text.hidden = false;
        self.lbl_animation_progress.hidden = true;
        self.view_CompletedStage.hidden = true;
    }
    else if (goal_amount_check == true && goal_progress_check == true && goal_target_date_check == true)
    {
        self.lbl_animation_progress.text = [NSString stringWithFormat:@"%@ (%.2f%%) of %@ %@",str_contribution_total,percent,str_goal_total,goal_details.g_currency];
        self.lbl_date_text.hidden = false;
        self.lbl_animation_progress.hidden = false;
        self.view_CompletedStage.hidden = false;
    }
    else if(goal_amount_check == false && goal_progress_check == false && goal_target_date_check == false)
    {
        self.lbl_animation_progress.hidden = true;
        self.lbl_date_text.hidden = true;
        self.view_CompletedStage.hidden = true;
        
    }
    
}

-(IBAction)share_goal:(id)sender
{
    [Localytics tagEvent:@"Click Share on Share Screen"];
    [Flurry logEvent:@"Click Share on Share Screen"];
    
    [FIRAnalytics logEventWithName:@"Click_Share_on_Share_Screen"
                        parameters:nil];
    
    UIGraphicsBeginImageContextWithOptions(self.view_bottom.bounds.size, self.view_bottom.opaque, 0.0f);
    [self.view_bottom drawViewHierarchyInRect:self.view_bottom.bounds afterScreenUpdates:NO];
    UIImage *snapshotImageFromMyView = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSArray* dataToShare = @[snapshotImageFromMyView];
    UIActivityViewController* activityViewController =[[UIActivityViewController alloc] initWithActivityItems:dataToShare applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[UIActivityTypeAirDrop];
    [self presentViewController:activityViewController animated:YES completion:^{}];
    
//    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Money Box" message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:@"Facebook",@"Twitter",nil];
//    alert.tag= 1111;
//
//    [alert show];
    //[self open_actionsheet];
}

-(void)open_actionsheet
{
    UIGraphicsBeginImageContextWithOptions(self.view_bottom.bounds.size, self.view_bottom.opaque, 0.0f);
    [self.view_bottom drawViewHierarchyInRect:self.view_bottom.bounds afterScreenUpdates:NO];
    UIImage *snapshotImageFromMyView = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSArray* dataToShare = @[snapshotImageFromMyView];
    UIActivityViewController* activityViewController =[[UIActivityViewController alloc] initWithActivityItems:dataToShare applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[UIActivityTypeAirDrop];

    [activityViewController setCompletionHandler:^(NSString *activityType, BOOL completed)
     {
         if([activityType isEqualToString: UIActivityTypeMail])
         {
             NSLog(@"Mail");
         }
         if([activityType isEqualToString: UIActivityTypePostToFacebook] && completed == true)
         {
             UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Money Box" message:NSLocalizedString(@"You have successfully shared your post on facebook.", nil) delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             alert.tag = 2222;
             [alert show];
         }
         if([activityType isEqualToString: UIActivityTypePostToTwitter]  && completed == true)
         {
             UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Money Box" message:NSLocalizedString(@"You have successfully shared your post on twitter.", nil) delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             
             alert.tag = 2222;
             [alert show];
         }
     }];

    [self presentViewController:activityViewController animated:YES completion:^
    {
    
    }];
}



#pragma mark - AdViewDelegates


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (alertView.tag == 1111)
    {
        
        if (buttonIndex == 1)
        {
            [Localytics tagEvent:@"click share On Share screen"];
            [Flurry logEvent:@"click share On Share screen"];
            
            [FIRAnalytics logEventWithName:@"click_share_On_Share_screen"
                                parameters:nil];
            
            [self share_fb];
        }
        else if (buttonIndex == 2)
        {
            [Localytics tagEvent:@"click share On Share screen"];
            [Flurry logEvent:@"click share On Share screen"];
            
            [FIRAnalytics logEventWithName:@"click_share_On_Share_screen"
                                parameters:nil];
            [self share_twitter];
        }
    }
    else if(alertView.tag == 11)
    {
        Settings_ViewController *obj_Settings_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"Settings_ViewController"];
        [self.navigationController pushViewController:obj_Settings_ViewController animated:YES];
    }
    else if(alertView.tag == 2222)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}



-(void)share_fb
{
//    if ([FBSDKAccessToken currentAccessToken]) {
//        // User is logged in, do work such as go to next view controller.
//        UIGraphicsBeginImageContextWithOptions(self.view_bottom.bounds.size, self.view_bottom.opaque, 0.0f);
//        [self.view_bottom drawViewHierarchyInRect:self.view_bottom.bounds afterScreenUpdates:NO];
//        UIImage *snapshotImageFromMyView = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//
//        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: UIImageJPEGRepresentation(snapshotImageFromMyView, 1.0), @"source", nil];
//        [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//        if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
//            // TODO: publish content.
//            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"/me/photos" parameters:params HTTPMethod:@"POST"]
//             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//                 [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
//                 if (!error) {
//                     NSLog(@"fetched user  and Email %@", result);
//                     UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Money Box" message:NSLocalizedString(@"You have successfully shared your post on facebook.", nil) delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                     alert.tag = 2222;
//                     [alert show];
//
//                 }
//                 else{
//                     NSLog(@"%@",error.localizedDescription);
//                     UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Money Box" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//
//                     [alert show];
//                 }
//             }];
//        } else {
//            [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//            FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
//            [loginManager logInWithPublishPermissions:@[@"publish_actions"]
//                                   fromViewController:self
//                                              handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//                                                  //TODO: process error or result.
//
//                                                  if (!error) {
//
//                                                      [[[FBSDKGraphRequest alloc] initWithGraphPath:@"/me/photos" parameters:params HTTPMethod:@"POST"]
//                                                       startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//                                                           [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
//                                                           if (!error) {
//                                                               NSLog(@"fetched user  and Email %@", result);
//                                                               UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Money Box" message:NSLocalizedString(@"You have successfully shared your post on facebook.", nil) delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                                                               alert.tag = 2222;
//                                                               [alert show];
//
//                                                           }
//                                                           else{
//                                                               NSLog(@"%@",error.localizedDescription);
//                                                               UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Money Box" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//
//                                                               [alert show];
//                                                           }
//                                                       }];
//                                                  }
//                                              }];
//        }
//    }
//    else{
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Money Box" message:NSLocalizedString(@"Please login to your facebook account from moneybox settings screen.", nil) delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//        [alert show];
//    }
    
    if ([[UIApplication sharedApplication] canOpenURL:([NSURL URLWithString:@"fb://"])]) {
        SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];

        UIGraphicsBeginImageContextWithOptions(self.view_bottom.bounds.size, self.view_bottom.opaque, 0.0f);
        [self.view_bottom drawViewHierarchyInRect:self.view_bottom.bounds afterScreenUpdates:NO];
        UIImage *snapshotImageFromMyView = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [mySLComposerSheet addImage:snapshotImageFromMyView];



        [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result)
         {
             switch (result)
             {
                 case SLComposeViewControllerResultCancelled:
                     NSLog(@"Post Cancelled");
                     break;
                 case SLComposeViewControllerResultDone:
                 {
                     UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Money Box" message:NSLocalizedString(@"You have successfully shared your post on facebook.", nil) delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                     alert.tag = 2222;
                     [alert show];
                 }
                     break;

                 default:
                     break;
             }
         }];
        [self presentViewController:mySLComposerSheet animated:YES completion:nil];

    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Money Box" message:NSLocalizedString(@"Please install facebook application", nil) delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    
    
    
    
//    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
//    {
//        NSLog(@"Connected");
//        SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
//
//        UIGraphicsBeginImageContextWithOptions(self.view_bottom.bounds.size, self.view_bottom.opaque, 0.0f);
//        [self.view_bottom drawViewHierarchyInRect:self.view_bottom.bounds afterScreenUpdates:NO];
//        UIImage *snapshotImageFromMyView = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        [mySLComposerSheet addImage:snapshotImageFromMyView];
//
//
//
//                [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result)
//        {
//            switch (result)
//                    {
//                        case SLComposeViewControllerResultCancelled:
//                            NSLog(@"Post Canceled");
//                            break;
//                        case SLComposeViewControllerResultDone:
//                        {
//                            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Money Box" message:NSLocalizedString(@"You have successfully shared your post on facebook.", nil) delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                            alert.tag = 2222;
//                            [alert show];
//
//                        }
//                            break;
//
//                        default:
//                            break;
//                    }
//                }];
//        [self presentViewController:mySLComposerSheet animated:YES completion:nil];
//    }
//    else
//    {
////        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Money Box" message:NSLocalizedString(@"Please login to your facebook account from moneybox settings screen.", nil) delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
////        alert.tag = 11;
////        [alert show];
//        if([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)
//        {
//            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"App-Prefs:root=FACEBOOK"]
//                                              options:[NSDictionary dictionary]
//                                    completionHandler:nil];
//        }
//        else
//        {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root=FACEBOOK"]];
//        }
//
//    }
}
//- (void)composerDidCancel:(TWTRComposerViewController *)controller{
//
//}
//
//- (void)composerDidSucceed:(TWTRComposerViewController *)controller withTweet:(TWTRTweet *)tweet{
//    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Money Box" message:NSLocalizedString(@"You have successfully shared your post on twitter.", nil) delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//    alert.tag = 2222;
//    [alert show];
//
//}
//- (void)composerDidFail:(TWTRComposerViewController *)controller withError:(NSError *)error{
//    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Money Box" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//
//    [alert show];
//}
-(void)share_twitter
{
//    if ([[Twitter sharedInstance].sessionStore hasLoggedInUsers]) {
//        UIGraphicsBeginImageContextWithOptions(self.view_bottom.bounds.size, self.view_bottom.opaque, 0.0f);
//        [self.view_bottom drawViewHierarchyInRect:self.view_bottom.bounds afterScreenUpdates:NO];
//        UIImage *snapshotImageFromMyView = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        TWTRComposerViewController *composer = [[TWTRComposerViewController alloc] initWithInitialText:@"" image:snapshotImageFromMyView videoURL:nil];
//        composer.delegate = self;
//        [self presentViewController:composer animated:YES completion:nil];
//    } else {
//        [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
//            if (session) {
//                UIGraphicsBeginImageContextWithOptions(self.view_bottom.bounds.size, self.view_bottom.opaque, 0.0f);
//                [self.view_bottom drawViewHierarchyInRect:self.view_bottom.bounds afterScreenUpdates:NO];
//                UIImage *snapshotImageFromMyView = UIGraphicsGetImageFromCurrentImageContext();
//                UIGraphicsEndImageContext();
//
//                TWTRComposerViewController *composer = [[TWTRComposerViewController alloc] initWithInitialText:@"" image:snapshotImageFromMyView videoURL:nil];
//                composer.delegate = self;
//                [self presentViewController:composer animated:YES completion:nil];
//
//            } else {
//
//            }
//        }];
//    }
    
//    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
//        if (session) {
//            NSLog(@"signed in as %@", [session userName]);
//
//            UIGraphicsBeginImageContextWithOptions(self.view_bottom.bounds.size, self.view_bottom.opaque, 0.0f);
//            [self.view_bottom drawViewHierarchyInRect:self.view_bottom.bounds afterScreenUpdates:NO];
//            UIImage *snapshotImageFromMyView = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
//
//            TWTRComposerViewController *composer = [[TWTRComposerViewController alloc] initWithInitialText:@"" image:snapshotImageFromMyView videoURL:nil];
//            [self presentViewController:composer animated:YES completion:nil];
//
////            TWTRComposer *composer = [[TWTRComposer alloc] init];
//
////            [composer setText:@"just setting up my Twitter Kit"];
////            [composer setImage:snapshotImageFromMyView];
//
////            // Called from a UIViewController
////            [composer showFromViewController:self completion:^(TWTRComposerResult result) {
////                if (result == TWTRComposerResultCancelled) {
////                    NSLog(@"Tweet composition cancelled");
////                }
////                else {
////                    NSLog(@"Sending Tweet!");
////                }
////            }];
//        } else {
//            NSLog(@"error: %@", [error localizedDescription]);
//        }
//    }];

    
    // Objective-C
    
    
//    if ([[UIApplication sharedApplication] canOpenURL:([NSURL URLWithString:@"twitter://"])]) {
//        SLComposeViewController *mySLComposerSheet1 = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
//
//
//        UIGraphicsBeginImageContextWithOptions(self.view_bottom.bounds.size, self.view_bottom.opaque, 0.0f);
//        [self.view_bottom drawViewHierarchyInRect:self.view_bottom.bounds afterScreenUpdates:NO];
//        UIImage *snapshotImageFromMyView = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        [mySLComposerSheet1 addImage:snapshotImageFromMyView];
//
//        [mySLComposerSheet1 addURL:[NSURL URLWithString:@"http://moneybox.mobi/"]];
//
//
//
//        [mySLComposerSheet1 setCompletionHandler:^(SLComposeViewControllerResult result)
//         {
//
//             switch (result) {
//                 case SLComposeViewControllerResultCancelled:
//                     NSLog(@"Post Canceled");
//                     break;
//                 case SLComposeViewControllerResultDone:
//                 {
//                     UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Money Box" message:NSLocalizedString(@"You have successfully shared your post on twitter.", nil) delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                     alert.tag = 2222;
//                     [alert show];
//                 }
//
//                     break;
//
//                 default:
//                     break;
//             }
//         }];
//
//        [self presentViewController:mySLComposerSheet1 animated:YES completion:nil];
//    }
//    else{
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Money Box" message:NSLocalizedString(@"Please install twitter application", nil) delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//        [alert show];
//    }
    
    
//    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
//    {
//
//
//        SLComposeViewController *mySLComposerSheet1 = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
//
//
//        UIGraphicsBeginImageContextWithOptions(self.view_bottom.bounds.size, self.view_bottom.opaque, 0.0f);
//        [self.view_bottom drawViewHierarchyInRect:self.view_bottom.bounds afterScreenUpdates:NO];
//        UIImage *snapshotImageFromMyView = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        [mySLComposerSheet1 addImage:snapshotImageFromMyView];
//
//        [mySLComposerSheet1 addURL:[NSURL URLWithString:@"http://moneybox.mobi/"]];
//
//
//
//        [mySLComposerSheet1 setCompletionHandler:^(SLComposeViewControllerResult result)
//        {
//
//            switch (result) {
//                case SLComposeViewControllerResultCancelled:
//                    NSLog(@"Post Canceled");
//                    break;
//                case SLComposeViewControllerResultDone:
//                {
//                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Money Box" message:NSLocalizedString(@"You have successfully shared your post on twitter.", nil) delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                    alert.tag = 2222;
//                    [alert show];
//                }
//
//                    break;
//
//                default:
//                    break;
//            }
//        }];
//
//        [self presentViewController:mySLComposerSheet1 animated:YES completion:nil];
//    }
//    else
//    {
////        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Money Box" message:NSLocalizedString(@"Please login to your twitter account from moneybox settings screen.", nil) delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
////         alert.tag = 11;
////        [alert show];
//
//        if([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)
//        {
//            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"App-Prefs:root=TWITTER"]
//                                              options:[NSDictionary dictionary]
//                                    completionHandler:nil];
//        }
//        else
//        {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root=TWITTER"]];
//
//        }
//
//    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
