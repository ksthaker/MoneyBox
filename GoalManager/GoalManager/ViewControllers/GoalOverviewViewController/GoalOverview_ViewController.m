//
//  GoalOverview_ViewController.m
//  GoalManager
//
//  Created by apple on 11/11/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import "GoalOverview_ViewController.h"
#import "NSString+FontAwesome.h"
#import "ContributionsLists_ViewController.h"
#import "EditGoal_ViewController.h"
#import "GoalManager.h"
#import "CoreData+MagicalRecord.h"
#import "AddContributions_ViewController.h"
#import "Settings_ViewController.h"
#import "ShareViewController.h"

@interface GoalOverview_ViewController ()

@end

@implementation GoalOverview_ViewController
@synthesize lbl_Arrow,lbl_RightArrow,lbl_Back,lbl_Amount,lbl_GoalDate,lbl_GoalName,lbl_SavingsNeeded,lbl_NoImage;
@synthesize btn_GoalContributions,btn_Back,btn_Edit,btn_Dollar;
@synthesize view_ReminderTime,view_SavingAccount,view_SavingFrequency,view_GoalProgress,view_GoalProgressOuter,lbl_SavingFrequency,lbl_ReminderTime,lbl_SavigAccount;
@synthesize scroll_GoalOverview;
@synthesize str_GoalIndex,str_FromWhere;
@synthesize selected_Goal;
@synthesize txt_ReminderTime,txt_SavigAccount,txt_SavingFreqency;
@synthesize imgView_GoalLogo;

@synthesize hud;
@synthesize imgView_InitialScreen;
#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
   NSLog(@"%f", self.view.frame.size.height);
    
    lbl_Arrow.font = [UIFont fontWithName:kFontAwesomeFamilyName size:20];
    lbl_Arrow.text = [NSString fontAwesomeIconStringForIconIdentifier:@"fa-chevron-right"];
    
    UIImage* image = [UIImage imageNamed:@"navbar_edit.png"];
    CGRect frameimg = CGRectMake(0, 0,22,22);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(action_EditGoal:) forControlEvents:UIControlEventTouchUpInside];
    [someButton setSelected:YES];
    
    UIBarButtonItem *btn_EditGoal= [[UIBarButtonItem alloc]initWithCustomView:someButton];
    
    
    UIButton *empty=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 1, 1)];
    empty.backgroundColor=[UIColor clearColor];
    
    //UIBarButtonItem *btn_empty=[[UIBarButtonItem alloc]initWithCustomView:empty];
    
    UIImage* image1 = [UIImage imageNamed:@"navbar_add_contribution.png"];
    CGRect frameimg1 = CGRectMake(0,0,22,22);
    UIButton *someButton1 = [[UIButton alloc] initWithFrame:frameimg1];
    [someButton1 setBackgroundImage:image1 forState:UIControlStateNormal];
    [someButton1 addTarget:self action:@selector(action_AddContribution:)
          forControlEvents:UIControlEventTouchUpInside];
    [someButton1 setSelected:YES];
    
    
    UIBarButtonItem *btn_AddContribution= [[UIBarButtonItem alloc]initWithCustomView:someButton1];
    
    UIImage* image3 = [UIImage imageNamed:@"ios_share2.png"];
    CGRect frameimg3 = CGRectMake(0, 0,22,22);
    UIButton *someButton3 = [[UIButton alloc] initWithFrame:frameimg3];
    [someButton3 setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton3 addTarget:self action:@selector(share_view:)
          forControlEvents:UIControlEventTouchUpInside];
    [someButton3 setSelected:YES];
    
    UIBarButtonItem *btn_goalcompleted= [[UIBarButtonItem alloc]initWithCustomView:someButton3];
    
    
    
    NSArray *arr_AddFilterGoal= [[NSArray alloc] initWithObjects:btn_EditGoal,btn_AddContribution,btn_goalcompleted,nil];
    self.navigationItem.rightBarButtonItems = arr_AddFilterGoal;
    
    UIImage* image2 = [UIImage imageNamed:@"navbar_back.png"];
    CGRect frameimg2 = CGRectMake(0, 0,22,22);
    UIButton *someButton2 = [[UIButton alloc] initWithFrame:frameimg2];
    [someButton2 setBackgroundImage:image2 forState:UIControlStateNormal];
    [someButton2 addTarget:self action:@selector(action_Back:)
          forControlEvents:UIControlEventTouchUpInside];
    [someButton2 setSelected:YES];
    
    btn_Back= [[UIBarButtonItem alloc]initWithCustomView:someButton2];
    
    NSArray *arr_AddFilterGoalleft= [[NSArray alloc] initWithObjects:btn_Back,nil];
    self.navigationItem.leftBarButtonItems = arr_AddFilterGoalleft;
    
    
   

    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.view addGestureRecognizer:swipeRight];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productsLoaded:) name:kProductsLoadedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:kProductPurchasedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(productPurchaseFailed:) name:kProductPurchaseFailedNotification object: nil];
    
    self.language = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSLog(@"%@",self.language);
    NSString *string = self.language;
    if ([string rangeOfString:@"zh-Hans"].location != NSNotFound) {
        
        self.language = @"zh-Hans";
    } else if ([string rangeOfString:@"es"].location != NSNotFound) {
        self.language = @"es";
    }
    else if ([string rangeOfString:@"ja"].location != NSNotFound){
        self.language = @"ja";
    }
    
    if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InitialScreen2"] length] <=0 || [[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InitialScreen2"]isEqualToString:@"(null)"])
    {
        [GoalManagerAppDelegate sharedinstance].view_InitialScreen = [[UIView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        imgView_InitialScreen = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        
        if ([self.language isEqualToString:@"zh-Hans"]) {
            if (isiPhone6Plus)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial2_6PlusCHI"];
            }
            else if (isiPhone6)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial2_6CHI"];
            }
            else if (isiPhone5)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial2_5CHI"];
            }
            else if (isiPhoneX)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial2_6CHI"];
            }
            else
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial2_4CHI"];
            }
        }
        else if ([self.language isEqualToString:@"es"]) {
            if (isiPhone6Plus)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial2_6PlusSPA"];
            }
            else if (isiPhone6)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial2_6SPA"];
            }
            else if (isiPhoneX)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial2_6SPA"];
            }
            else if (isiPhone5)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial2_5SPA"];
            }
            else
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial2_4SPA"];
            }
        }
        else if ([self.language isEqualToString:@"ja"]) {
            if (isiPhone6Plus)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial2_6PlusJAP"];
            }
            else if (isiPhone6)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial2_6JAP"];
            }
            else if (isiPhoneX)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial2_6JAP"];
            }
            else if (isiPhone5)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial2_5JAP"];
            }
            else
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial2_4JAP"];
            }
        }
        else{
            if (isiPhone6Plus)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial2_6PlusEN"];
            }
            else if (isiPhone6)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial2_6EN"];
            }
            else if (isiPhoneX)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial2_6EN"];
            }
            else if (isiPhone5)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial2_5EN"];
            }
            else
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial2_4EN"];
            }
        }
        
        
//        if (isiPhone6Plus)
//        {
//            imgView_InitialScreen.image = [UIImage imageNamed:@"Initial2_6Plus"];
//        }
//        else if (isiPhone6)
//        {
//            imgView_InitialScreen.image = [UIImage imageNamed:@"Initial2_6"];
//        }
//        else if (isiPhone5)
//        {
//            imgView_InitialScreen.image = [UIImage imageNamed:@"Initial2_5"];
//        }
//        else
//        {
//            imgView_InitialScreen.image = [UIImage imageNamed:@"Initial2_4"];
//        }
        
        [[GoalManagerAppDelegate sharedinstance].view_InitialScreen addSubview:imgView_InitialScreen];
        
        [[UIApplication sharedApplication].keyWindow addSubview:[GoalManagerAppDelegate sharedinstance].view_InitialScreen];
        
    }
    [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"InitialScreen2"];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
}
-(IBAction)share_view:(id)sender
{
    [Localytics tagEvent:@"Click Share on Goal view"];
    [Flurry logEvent:@"Click Share on Goal view"];
    
    [FIRAnalytics logEventWithName:@"Click_Share_on_Goal_view"
                        parameters:nil];
    ShareViewController *obj_Currency_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"ShareViewController"];
    obj_Currency_ViewController.goal_details = self.selected_Goal;
    obj_Currency_ViewController.str_from = @"GoalOverview";
    [self.navigationController pushViewController:obj_Currency_ViewController animated:YES];
}

#pragma mark UISwipeGestureRecognizer METHOD

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe
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

    if (swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    //self.navigationController.navigationBar.translucent=NO;
    self.navigationController.navigationBar.hidden = true;
    
    [Localytics tagEvent:@"Goal Overview"];
    [Flurry logEvent:@"Goal Overview"];
    
    [FIRAnalytics logEventWithName:@"Goal_Overview"
                        parameters:nil];
    
    BOOL isInternetCheck = [GoalManagerAppDelegate connectedToNetwork];
    if (isInternetCheck == TRUE)
    {
        if (![[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InAppPurchase"] isEqualToString:@"1"])
        {
            self.view_AD.adUnitID = @"ca-app-pub-5298130731078005/7401333379";
            self.view_AD.rootViewController = self;
            GADRequest *request = [GADRequest request];
            
            //request.testDevices = @[ kGADSimulatorID ];
            
            [self.view_AD loadRequest:request];
            self.view_AD.hidden = FALSE;
            self.scroll_GoalOverview.contentSize = CGSizeMake(0, scroll_GoalOverview.bounds.size.height+50);
            
            if (isiPhone6 || isiPhone6Plus)
            {
                CGRect view1 = self.view_AdShowHide.frame;
                
                NSLog(@"%f",view1.origin.y);
                NSLog(@"%f",self.view.frame.size.height);
                NSLog(@"%f",self.view.frame.size.height-view1.size.height);
                NSLog(@"%f",view1.size.height);
                if (isiPhone6) {
                    view1.origin.y = (603-view1.size.height)-50;
                }
                else if (isiPhoneX) {
                    view1.origin.y = (748-view1.size.height)-50;
                }
                else{
                    view1.origin.y = (672-view1.size.height)-50;
                }
                
                
                
                NSLog(@"%f",view1.origin.y);
                self.view_AdShowHide.frame = view1;
            }
        }
        else{
            self.view_AD.hidden = TRUE;
            self.scroll_GoalOverview.contentSize = CGSizeMake(0, 0);
            
            if (isiPhone6 || isiPhone6Plus)
            {
                CGRect view1 = self.view_AdShowHide.frame;
                
                if (isiPhone6) {
                    view1.origin.y = (603-view1.size.height);
                }
                else if (isiPhoneX) {
                    view1.origin.y = (748-view1.size.height);
                }
                else{
                    view1.origin.y = (672-view1.size.height);
                }
                
                //view1.origin.y = self.view.bounds.size.height-view1.size.height+50;
                self.view_AdShowHide.frame = view1;
            }
        }
    }
    else
    {
        self.view_AD.hidden = TRUE;
        self.scroll_GoalOverview.contentSize = CGSizeMake(0, 0);

        if (isiPhone6 || isiPhone6Plus)
        {
            CGRect view1 = self.view_AdShowHide.frame;
            
            NSLog(@"%f",view1.origin.y);
            NSLog(@"%f",self.view.frame.size.height);
            NSLog(@"%f",self.view.frame.size.height-view1.size.height);
            NSLog(@"%f",view1.size.height);
            
            if (isiPhone6) {
                view1.origin.y = (603-view1.size.height);
            }
            else if (isiPhoneX) {
                view1.origin.y = (748-view1.size.height);
            }
            else{
                view1.origin.y = (672-view1.size.height);
            }
            self.view_AdShowHide.frame = view1;
        }
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    lbl_GoalName.text = selected_Goal.g_title;
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter1 dateFromString:selected_Goal.g_targetdate];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd, yyyy"];
    NSString *localDateString = [dateFormatter stringFromDate:date];
    
    NSString *str_By = [NSString stringWithFormat:NSLocalizedString(@"By", nil)];
    
    if ([self.language isEqualToString:@"zh-Hans"]) {
        
        NSLog(@"%@",localDateString);
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"yyyy年M月d日'"];
        NSString *localDateString = [dateFormatter stringFromDate:date];
        lbl_GoalDate.text = [NSString stringWithFormat:@"%@",localDateString];
        NSLog(@"%@",localDateString);
    }
    else{
        lbl_GoalDate.text = [NSString stringWithFormat:@"%@ %@",str_By,localDateString];
    }
    
    if ([selected_Goal g_picture] == nil)
    {
        imgView_GoalLogo.image = [UIImage imageNamed:@"camera1.png"];
    }
    else
    {
        imgView_GoalLogo.image = [UIImage imageWithData:[selected_Goal g_picture]];
    }
    lbl_NoImage.hidden = TRUE;
    
    imgView_GoalLogo .layer.cornerRadius = self.imgView_GoalLogo.frame.size.width/2;
    imgView_GoalLogo.clipsToBounds = YES;
    self.lbl_SavigAccount.text = selected_Goal.g_savingaccount;
    
    if ([selected_Goal.g_savingfrequency isEqualToString:@"Not Planned"])
    {
        
        self.lbl_SavingFrequency.text = [NSString stringWithFormat:NSLocalizedString(@"Not Planned", nil)];
        
    }
    else if ([selected_Goal.g_savingfrequency isEqualToString:@"Daily"])
    {
        self.lbl_SavingFrequency.text = [NSString stringWithFormat:NSLocalizedString(@"Daily", nil)];
        
    }
    else if ([selected_Goal.g_savingfrequency isEqualToString:@"Weekly"])
    {
        self.lbl_SavingFrequency.text = [NSString stringWithFormat:NSLocalizedString(@"Weekly", nil)];
        
    }
    else if ([selected_Goal.g_savingfrequency isEqualToString:@"Bi-weekly"])
    {
        self.lbl_SavingFrequency.text = [NSString stringWithFormat:NSLocalizedString(@"Weekly", nil)];
        
    }
    else if ([selected_Goal.g_savingfrequency isEqualToString:@"Monthly"])
    {
        self.lbl_SavingFrequency.text = [NSString stringWithFormat:NSLocalizedString(@"Monthly", nil)];
    }
    
    id a = selected_Goal.objectID;
    NSPredicate *m = [NSPredicate predicateWithFormat:@"(r_goal == %@)",a];
    
    NSMutableArray *muary_TotalOfContribution = [[NSMutableArray alloc]init];
    [muary_TotalOfContribution addObjectsFromArray:[Contribution MR_findAllWithPredicate:m]];
    double ContributionTotal = 0.0;
    for (int i = 0; i<muary_TotalOfContribution.count; i++)
    {
        Contribution *GoalContribution = [muary_TotalOfContribution objectAtIndex:i];
        ContributionTotal += [GoalContribution.c_amount doubleValue];
    }
    
    NSString *str_ContributionTotal = [NSString stringWithFormat:@"%.2f",ContributionTotal];
    str_ContributionTotal=[GoalManagerAppDelegate Change_String_Formate:str_ContributionTotal];
    
    double goalTotal = [selected_Goal.g_amount doubleValue];
    NSString *str_GoalTotal = [NSString stringWithFormat:@"%.2f",goalTotal];
    str_GoalTotal=[GoalManagerAppDelegate Change_String_Formate:str_GoalTotal];
    
    lbl_Amount.text = [NSString stringWithFormat:@"%@ / %@",str_ContributionTotal,str_GoalTotal];
    
    double total=[selected_Goal.g_amount doubleValue];
    
    double recent=ContributionTotal;
    
    double per=recent*100/total;
    
    NSString *str_Of = [NSString stringWithFormat:NSLocalizedString(@"of", nil)];
    lbl_Amount.text = [NSString stringWithFormat:@"%@ (%.2f%%) %@ %@ %@",str_ContributionTotal,per,str_Of,str_GoalTotal,selected_Goal.g_currency];
    
    double len = 0.0;
    
    if (isiPhone6)
    {
        len=per*337/100;
        
        if(len > 337)
        {
            len = 337;
        }
        else if (len < 0)
        {
            len = 0;
        }
    }
    else if (isiPhoneX)
    {
        len=per*337/100;
        
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
        len=per*374/100;
        
        if(len > 374)
        {
            len = 374;
        }
        else if (len < 0)
        {
            len = 0;
        }
    }
    else
    {
        len=per*280/100;
        
        if(len > 280)
        {
            len = 280;
        }
        else if (len < 0)
        {
            len = 0;
        }
    }
    
    view_GoalProgress.frame=CGRectMake(view_GoalProgress.frame.origin.x,view_GoalProgress.frame.origin.y,0,view_GoalProgress.frame.size.height);
    self.view_GoalProgress.layer.cornerRadius = 12;
    self.view_GoalProgress.clipsToBounds = YES;
    
    self.view_GoalProgressOuter.layer.cornerRadius = 12;
    self.view_GoalProgressOuter.clipsToBounds = YES;
    
    [UIView animateWithDuration:3
                     animations:^{
                         CGRect frame = view_GoalProgress.frame;
                         if (isiPhone5)
                             frame.size.width = len;
                         else if (isiPhone6)
                             frame.size.width = len;
                         else if (isiPhoneX)
                             frame.size.width = len;
                         else if (isiPhone6Plus)
                             frame.size.width = len;
                         else
                             frame.size.width = len;
                         
                         
                         
                         view_GoalProgress.frame = frame;
                         
                         
                         
                     } completion:nil];
    
    NSString *str_ReminderNotSet = [NSString stringWithFormat:NSLocalizedString(@"Reminder not set", nil)];
    if ([selected_Goal.g_setsavingreminder isEqualToString:@"YES"])
    {
        if ([selected_Goal.g_savingfrequency isEqualToString:@"Daily"])
        {
            NSString *str_Everyday = [NSString stringWithFormat:NSLocalizedString(@"Everyday At", nil)];
            
            self.lbl_ReminderTime.text = [NSString stringWithFormat:@"%@ %@",str_Everyday,selected_Goal.g_remindertime];
        }
        else if ([selected_Goal.g_savingfrequency isEqualToString:@"Weekly"] || [selected_Goal.g_savingfrequency isEqualToString:@"Bi-weekly"])
        {
            NSString *str_At = [NSString stringWithFormat:NSLocalizedString(@"At", nil)];
            if ([self.language isEqualToString:@"zh-Hans"]) {
                self.lbl_ReminderTime.text = [NSString stringWithFormat:@"%@ %@",selected_Goal.g_reminderday,selected_Goal.g_remindertime];
            }
            else{
                self.lbl_ReminderTime.text = [NSString stringWithFormat:@"%@ %@ %@",selected_Goal.g_reminderday,str_At,selected_Goal.g_remindertime];
            }
        }
        else if ([selected_Goal.g_savingfrequency isEqualToString:@"Monthly"])
        {
            if([selected_Goal.g_reminderdate isEqualToString:@"01"] || [selected_Goal.g_reminderdate isEqualToString:@"21"] || [selected_Goal.g_reminderdate isEqualToString:@"31"])
            {
                NSString *str_DayofMonth = [NSString stringWithFormat:NSLocalizedString(@"st day of month at", nil)];
                self.lbl_ReminderTime.text = [NSString stringWithFormat:@"%@%@ %@",selected_Goal.g_reminderdate,str_DayofMonth,selected_Goal.g_remindertime];
            }
            else if ([selected_Goal.g_reminderdate isEqualToString:@"02"] || [selected_Goal.g_reminderdate isEqualToString:@"22"])
            {
                NSString *str_DayofMonth = [NSString stringWithFormat:NSLocalizedString(@"nd day of month at", nil)];
                self.lbl_ReminderTime.text = [NSString stringWithFormat:@"%@%@ %@",selected_Goal.g_reminderdate,str_DayofMonth,selected_Goal.g_remindertime];
            }
            else if ([selected_Goal.g_reminderdate isEqualToString:@"03"] || [selected_Goal.g_reminderdate isEqualToString:@"23"])
            {
                NSString *str_DayofMonth = [NSString stringWithFormat:NSLocalizedString(@"rd day of month at", nil)];
                self.lbl_ReminderTime.text = [NSString stringWithFormat:@"%@%@ %@",selected_Goal.g_reminderdate,str_DayofMonth,selected_Goal.g_remindertime];
            }
            else
            {
                NSString *str_DayofMonth = [NSString stringWithFormat:NSLocalizedString(@"th day of month at", nil)];
                self.lbl_ReminderTime.text = [NSString stringWithFormat:@"%@%@ %@",selected_Goal.g_reminderdate,str_DayofMonth,selected_Goal.g_remindertime];
            }
            
        }
        else
        {
            
            self.lbl_ReminderTime.text = str_ReminderNotSet;
        }
    }
    else
    {
        self.lbl_ReminderTime.text = str_ReminderNotSet;
    }
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd"];
    [f setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate *SatrtDate = [NSDate date];
    
    NSString *str_GoalStartDate = [NSString stringWithFormat:@"%@",[f stringFromDate:SatrtDate]];
    
    NSString *str_GoalEndDate = [NSString stringWithFormat:@"%@",selected_Goal.g_targetdate];
    NSDate *endDate = [f dateFromString:str_GoalEndDate];
    NSDate *startDate = [f dateFromString:str_GoalStartDate];
    NSComparisonResult result = [endDate compare:startDate];
    if (result == NSOrderedDescending || result == NSOrderedSame)
    {
        NSCalendar *gregorian = [[NSCalendar alloc]
                                 initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSUInteger unitFlags = 0;
        if ([selected_Goal.g_savingfrequency isEqualToString:@"Weekly"])
        {
            unitFlags = NSCalendarUnitWeekOfYear ;
        }
        else if ([selected_Goal.g_savingfrequency isEqualToString:@"Daily"])
        {
            unitFlags = NSCalendarUnitDay ;
        }
        else if ([selected_Goal.g_savingfrequency isEqualToString:@"Monthly"])
        {
            unitFlags = NSCalendarUnitMonth ;
        }
        else if ([selected_Goal.g_savingfrequency isEqualToString:@"Bi-weekly"])
        {
            unitFlags = NSCalendarUnitWeekOfYear ;
        }
        
        NSDateComponents *components = [gregorian components:unitFlags
                                                    fromDate:startDate
                                                      toDate:endDate options:0];
        
        
        double Amount = 0.0;
        Amount = [selected_Goal.g_amount doubleValue] - ContributionTotal ;
        
        if ([selected_Goal.g_savingfrequency isEqualToString:@"Weekly"])
        {
            if (Amount == 0) {
                lbl_SavingsNeeded.text = [NSString stringWithFormat:NSLocalizedString(@"Goal Completed",nil)];
            }
            else{
                if ([components weekOfYear] == 0)
                {
                    Amount = Amount / ([components weekOfYear]+1);
                }
                else
                {
                    Amount = Amount / ([components weekOfYear]);
                }
                
                //NSLog(@"%.2f",Amount);
                
                NSString *str_Amount = [NSString stringWithFormat:@"%.2f",Amount];
                
                str_Amount = [GoalManagerAppDelegate Change_String_Formate:str_Amount];
                
                //NSLog(@"%@",str_Amount);
                
                NSString *str_Weekly = [NSString stringWithFormat:NSLocalizedString(@"Weekly", nil)];
                
                lbl_SavingsNeeded.text = [NSString stringWithFormat:@"%@ %@/%@",str_Amount,selected_Goal.g_currency,str_Weekly];
            }
            
            
        }
        else if ([selected_Goal.g_savingfrequency isEqualToString:@"Daily"])
        {
            //NSLog(@"%.2f",Amount);
            
            //NSLog(@"%ld",(long)[components day]+1);
            
            if (Amount == 0) {
                lbl_SavingsNeeded.text = [NSString stringWithFormat:NSLocalizedString(@"Goal Completed",nil)];
            }
            else{
                Amount = Amount / ([components day]+1);
                
                //NSLog(@"%.2f",Amount);
                
                NSString *str_Amount = [NSString stringWithFormat:@"%.2f",Amount];
                
                str_Amount = [GoalManagerAppDelegate Change_String_Formate:str_Amount];
                
                //NSLog(@"%@",str_Amount);
                
                NSString *str_Daily = [NSString stringWithFormat:NSLocalizedString(@"Daily", nil)];
                
                lbl_SavingsNeeded.text = [NSString stringWithFormat:@"%@ %@/%@",str_Amount,selected_Goal.g_currency,str_Daily];
            }
            
            
            
        }
        else if ([selected_Goal.g_savingfrequency isEqualToString:@"Monthly"])
        {
            //NSLog(@"%ld",(long)[components month]);
            
            if (Amount == 0) {
                lbl_SavingsNeeded.text = [NSString stringWithFormat:NSLocalizedString(@"Goal Completed",nil)];
            }
            else{
                if ([components month] == 0)
                {
                    Amount = Amount / ([components month]+1);
                }
                else
                {
                    Amount = Amount / ([components month]);
                }
                //NSLog(@"%.2f",Amount);
                
                NSString *str_Amount = [NSString stringWithFormat:@"%.2f",Amount];
                
                str_Amount = [GoalManagerAppDelegate Change_String_Formate:str_Amount];
                
                //NSLog(@"%@",str_Amount);
                
                NSString *str_Monthly = [NSString stringWithFormat:NSLocalizedString(@"Monthly", nil)];
                
                lbl_SavingsNeeded.text = [NSString stringWithFormat:@"%@ %@/%@",str_Amount,selected_Goal.g_currency,str_Monthly];
            }
            
            
            
        }
        else if ([selected_Goal.g_savingfrequency isEqualToString:@"Bi-weekly"])
        {
            //NSLog(@"%ld",(long)[components week]);
            
            if (Amount == 0) {
                lbl_SavingsNeeded.text = [NSString stringWithFormat:NSLocalizedString(@"Goal Completed",nil)];
            }
            else
            {
                if ([components weekOfYear] == 0)
                {
                    Amount = Amount / ([components weekOfYear]+1);
                }
                else
                {
                    Amount = Amount / ([components weekOfYear]);
                }
                
                //NSLog(@"%.2f",Amount);
                
                NSString *str_Amount = [NSString stringWithFormat:@"%.2f",Amount];
                
                str_Amount = [GoalManagerAppDelegate Change_String_Formate:str_Amount];
                
                //NSLog(@"%@",str_Amount);
                
                NSString *str_Weekly = [NSString stringWithFormat:NSLocalizedString(@"Weekly", nil)];
                
                lbl_SavingsNeeded.text = [NSString stringWithFormat:@"%@ %@/%@",str_Amount,selected_Goal.g_currency,str_Weekly];
            }
        }

        else
        {
            lbl_SavingsNeeded.text = [NSString stringWithFormat:NSLocalizedString(@"Yet not planned", nil)];
        }
        
    }
    else
    {
        lbl_SavingsNeeded.text = [NSString stringWithFormat:NSLocalizedString(@"Goal overdue", nil)];
    }
    [super viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//=======================================================IN APP PURCHASE=========================================================

-(void)action_Product_Receive
{
    BOOL isInternet1 = [GoalManagerAppDelegate connectedToNetwork];
    
    if (isInternet1 == TRUE)
    {
        if ([InAppRageIAPHelper sharedHelper].products == nil)
        {
            [[InAppRageIAPHelper sharedHelper] requestProducts];
            
            [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            [self performSelector:@selector(timeout:) withObject:nil afterDelay:30.0];
        }
    }
    else
    {
        UIAlertView *alert2 = [[UIAlertView alloc] init];
        [alert2 setTitle:@""];
        alert2.tag=999;
        [alert2 setMessage:@"No internet connection!"];
        [alert2 setDelegate:self];
        [alert2 addButtonWithTitle:@"OK"];
        [alert2 show];
        alert2.delegate =self;
    }
}

- (void)timeout:(id)arg
{
    [self performSelector:@selector(dismissHUD:) withObject:nil afterDelay:5.0];
    
}
- (void)dismissHUD:(id)arg
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    self.hud = nil;
}

-(IBAction)Purchase:(id)sender
{
    if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InAppPurchase"] isEqualToString:@"1"])
    {
        UIAlertView *alert1=[[UIAlertView alloc] initWithTitle:nil message:@"You already purchased this" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert1 show];
    }
    else
    {
        if ([[InAppRageIAPHelper sharedHelper].products count]==0)
        {
            [self performSelector:@selector(dismissHUD:) withObject:nil afterDelay:5.0];
            UIAlertView *alert1=[[UIAlertView alloc] initWithTitle:nil message:@"Can not connect to itunes store" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert1 show];
        }
        else
        {
            [[InAppRageIAPHelper sharedHelper] buyProductIdentifier:@"com.andrey.MoneyBoxFullVersion"];
            
            hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.labelText = @"Buying...";
            [self performSelector:@selector(timeout:) withObject:nil afterDelay:60*5];
        }
    }
    
    
}

- (void)productsLoaded:(NSNotification *)notification
{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    
}
- (void)productPurchased:(NSNotification *)notification
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    NSString *productIdentifier = (NSString *) notification.object;
    NSLog(@"%@",productIdentifier);
    alert11 = [[UIAlertView alloc] init];
    [alert11 setTitle:@""];
    
    [self actionFunctionNSUSER:productIdentifier];
    
}

-(void)actionFunctionNSUSER:(NSString *)productIdentifier //This Function will cheack the NSUSER Defult and Fill with New DATA
{
    
    if([productIdentifier isEqualToString:@"com.andrey.MoneyBoxFullVersion"])
    {
        [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"InAppPurchase"];
        
    }
}

- (void)dealloc
{
    hud = nil;
}

-(void)viewDidUnload
{
    hud = nil;
}


- (void)productPurchaseFailed:(NSNotification *)notification
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
    SKPaymentTransaction * transaction = (SKPaymentTransaction *) notification.object;
    
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"Error!" message:transaction.error.localizedDescription delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert3 show];
    }
}


//===============================================================================================================================

#pragma mark - All User Defined Functions

-(IBAction)action_AddContribution:(id)sender
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
    
    if ([str_FromWhere isEqualToString:@"FromCompleted"])
    {
        NSString *str_Status = @"Not Completed";
        NSPredicate *m = [NSPredicate predicateWithFormat:@"(g_completedstatus == %@)",str_Status];
        NSMutableArray *muary_TotalActiveGoal = [NSMutableArray arrayWithArray:[Goal MR_findAllWithPredicate:m]];
        
        if (muary_TotalActiveGoal.count>=2)
        {
            if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InAppPurchase"] isEqualToString:@"1"])
            {
                            NSDictionary *articleParams = [NSDictionary dictionaryWithObjectsAndKeys:
                                                           @"From Goal Overview", @"AddContribution",
                                                           nil];
                
                            [Flurry logEvent:@"Add Contribution" withParameters:articleParams];
                            [Localytics tagEvent:@"Add Contribution"
                                      attributes:articleParams];
                [FIRAnalytics logEventWithName:@"Add_Contribution"
                                    parameters:articleParams];
                
                AddContributions_ViewController *obj_AddContributions_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"AddContributions_ViewController"];
                obj_AddContributions_ViewController.selectedGoal = selected_Goal;
                [self.navigationController pushViewController:obj_AddContributions_ViewController animated:YES];
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Goal", nil) message:NSLocalizedString(@"You can have only two active goals in free version. To have unlimited number of active goals and more upgrade to Pro version", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"CANCEL", nil) otherButtonTitles:NSLocalizedString(@"Upgrade", nil),nil];
                alert.tag = 1988;
                [alert show];
            }
        }
        else
        {
            NSDictionary *articleParams = [NSDictionary dictionaryWithObjectsAndKeys:
                                           @"From Goal Overview", @"AddContribution",
                                           nil];
            
            [Flurry logEvent:@"Add Contribution" withParameters:articleParams];
            [Localytics tagEvent:@"Add Contribution"
                      attributes:articleParams];
            [FIRAnalytics logEventWithName:@"Add_Contribution"
                                parameters:articleParams];
            
            AddContributions_ViewController *obj_AddContributions_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"AddContributions_ViewController"];
            obj_AddContributions_ViewController.selectedGoal = selected_Goal;
            [self.navigationController pushViewController:obj_AddContributions_ViewController animated:YES];
        }
    }
    else
    {
        NSDictionary *articleParams = [NSDictionary dictionaryWithObjectsAndKeys:
                                       @"From Goal Overview", @"AddContribution",
                                       nil];
        
        [Flurry logEvent:@"Add Contribution" withParameters:articleParams];
        [Localytics tagEvent:@"Add Contribution"
                  attributes:articleParams];
        [FIRAnalytics logEventWithName:@"Add_Contribution"
                            parameters:articleParams];
        
        AddContributions_ViewController *obj_AddContributions_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"AddContributions_ViewController"];
        obj_AddContributions_ViewController.selectedGoal = selected_Goal;
        [self.navigationController pushViewController:obj_AddContributions_ViewController animated:YES];
    }
    
    
}

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

-(IBAction)action_EditGoal:(id)sender
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
    
    if ([str_FromWhere isEqualToString:@"FromCompleted"])
    {
        NSString *str_Status = @"Not Completed";
        NSPredicate *m = [NSPredicate predicateWithFormat:@"(g_completedstatus == %@)",str_Status];
        NSMutableArray *muary_TotalActiveGoal = [NSMutableArray arrayWithArray:[Goal MR_findAllWithPredicate:m]];
        
        if (muary_TotalActiveGoal.count>=2)
        {
            if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InAppPurchase"] isEqualToString:@"1"])
            {
                EditGoal_ViewController *obj_EditGoal_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"EditGoal_ViewController"];
                [obj_EditGoal_ViewController setCurrentGoal:selected_Goal];
                [self.navigationController pushViewController:obj_EditGoal_ViewController animated:YES];
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Goal", nil) message:NSLocalizedString(@"You can have only two active goals in free version. To have unlimited number of active goals and more upgrade to Pro version", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"CANCEL", nil) otherButtonTitles:NSLocalizedString(@"Upgrade", nil),nil];
                alert.tag = 1988;
                [alert show];
            }
        }
        else
        {
            EditGoal_ViewController *obj_EditGoal_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"EditGoal_ViewController"];
            [obj_EditGoal_ViewController setCurrentGoal:selected_Goal];
            [self.navigationController pushViewController:obj_EditGoal_ViewController animated:YES];
        }
    }
    else
    {
        EditGoal_ViewController *obj_EditGoal_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"EditGoal_ViewController"];
        [obj_EditGoal_ViewController setCurrentGoal:selected_Goal];
        [self.navigationController pushViewController:obj_EditGoal_ViewController animated:YES];
    }
}

-(IBAction)action_GoalContributions:(id)sender
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
    
    if ([str_FromWhere isEqualToString:@"FromCompleted"])
    {
        NSString *str_Status = @"Not Completed";
        NSPredicate *m = [NSPredicate predicateWithFormat:@"(g_completedstatus == %@)",str_Status];
        NSMutableArray *muary_TotalActiveGoal = [NSMutableArray arrayWithArray:[Goal MR_findAllWithPredicate:m]];
        
        if (muary_TotalActiveGoal.count>=2)
        {
            if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InAppPurchase"] isEqualToString:@"1"])
            {
                ContributionsLists_ViewController *obj_ContributionsLists_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"ContributionsLists_ViewController"];
                obj_ContributionsLists_ViewController.selectedGoal = selected_Goal;
                [self.navigationController pushViewController:obj_ContributionsLists_ViewController animated:YES];
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Goal", nil) message:NSLocalizedString(@"You can have only two active goals in free version. To have unlimited number of active goals and more upgrade to Pro version", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"CANCEL", nil) otherButtonTitles:NSLocalizedString(@"Upgrade", nil),nil];
                alert.tag = 1988;
                [alert show];
            }
        }
        else
        {
            ContributionsLists_ViewController *obj_ContributionsLists_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"ContributionsLists_ViewController"];
            obj_ContributionsLists_ViewController.selectedGoal = selected_Goal;
            [self.navigationController pushViewController:obj_ContributionsLists_ViewController animated:YES];
        }
    }
    else
    {
        ContributionsLists_ViewController *obj_ContributionsLists_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"ContributionsLists_ViewController"];
        obj_ContributionsLists_ViewController.selectedGoal = selected_Goal;
        [self.navigationController pushViewController:obj_ContributionsLists_ViewController animated:YES];
    }
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (alertView.tag == 1988)
    {
        if (buttonIndex == 1)
        {
//            [Flurry logEvent:@"Click Upgrade on message box"];
//            [Localytics tagEvent:@"Click Upgrade on message box"];
            
            Settings_ViewController *obj_Settings_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"Settings_ViewController"];
            [self.navigationController pushViewController:obj_Settings_ViewController animated:YES];
        }
    }
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
    if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InitialScreen2"]isEqualToString:@"1"]) {
        [_interstitial presentFromRootViewController:self];
    }
    [[UIApplication sharedApplication]setStatusBarHidden:FALSE];
    //[_interstitial presentFromRootViewController:self];
}

@end
