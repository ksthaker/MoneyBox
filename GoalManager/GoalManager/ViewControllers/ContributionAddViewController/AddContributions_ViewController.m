//
//  AddContributions_ViewController.m
//  GoalManager
//
//  Created by apple on 11/11/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import "AddContributions_ViewController.h"
#import "NSString+FontAwesome.h"
#import "GoalManager.h"
#import "Reachability.h"
//#import "FHSTwitterEngine.h"
#import "GoalManagerAppDelegate.h"
#import "Scheduale_Event.h"
#import "ShareViewController.h"

@interface AddContributions_ViewController ()

@end

@implementation AddContributions_ViewController
@synthesize btn_Back,btn_SaveContribution,btn_Date;
@synthesize lbl_Back;
@synthesize datePicker_ContributionDate;
@synthesize txt_Amount,txt_Notes;
@synthesize view_DatePicker,view_Amount,view_Notes,view_Shadow;

@synthesize selectedGoal;
@synthesize editingContext = _editingContext;
@synthesize contributionAdd;
@synthesize goal = _goal;
@synthesize str_ContributionAddedDate;

#pragma mark Reachability
- (BOOL) connectedToNetwork
{
    Reachability* reachability = [Reachability reachabilityWithHostName:@"google.com"];
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable)
    {
        isInternet =NO;
    }
    else if (remoteHostStatus == ReachableViaWWAN)
    {
        isInternet = TRUE;
    }
    else if (remoteHostStatus == ReachableViaWiFi)
    {
      isInternet = TRUE;
    }
    return isInternet;
}

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    alert_achive = FALSE;
    alert_create = FALSE;
    alert_milestone = FALSE;
    
    self.title = NSLocalizedString(@"Add Contribution", nil);
    self.language = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    
    // Do any additional setup after loading the view.
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
    
    UIImage* image = [UIImage imageNamed:@"button_choose.png"];
    CGRect frameimg = CGRectMake(0, 0,22,22);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(action_SaveContribution:) forControlEvents:UIControlEventTouchUpInside];
    [someButton setSelected:YES];
   
    UIBarButtonItem *btn_SaveContributionBar= [[UIBarButtonItem alloc]initWithCustomView:someButton];
    
    NSArray *arr_AddFilterGoal= [[NSArray alloc] initWithObjects:btn_SaveContributionBar,nil];
    self.navigationItem.rightBarButtonItems = arr_AddFilterGoal;
    
    self.lbl_DateArrow.font = [UIFont fontWithName:kFontAwesomeFamilyName size:15];
    self.lbl_DateArrow.text = [NSString fontAwesomeIconStringForIconIdentifier:@"fa-chevron-right"];
    
    self.datePicker_ContributionDate.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
    
    self.datePicker_ContributionDate.date = [NSDate date];
    NSDateFormatter *df_TargetDate = [[NSDateFormatter alloc] init];
    [df_TargetDate setDateFormat:@"MMM dd, yyyy"];
    self.lbl_Date.text = [NSString stringWithFormat:@"%@",[df_TargetDate stringFromDate:self.datePicker_ContributionDate.date]];
    
    NSDateFormatter *df_TargetDate2 = [[NSDateFormatter alloc] init];
    [df_TargetDate2 setDateFormat:@"yyyy-MM-dd"];
    self.str_ContributionAddedDate = [NSString stringWithFormat:@"%@",
                                      [df_TargetDate2 stringFromDate:self.datePicker_ContributionDate.date]];
    
    NSString *string = self.language;
    if ([string rangeOfString:@"zh-Hans"].location != NSNotFound) {
        
        self.language = @"zh-Hans";
    } else if ([string rangeOfString:@"es"].location != NSNotFound) {
        self.language = @"es";
    }
    else if ([string rangeOfString:@"ja"].location != NSNotFound){
        self.language = @"ja";
    }
    
    if ([self.language isEqualToString:@"zh-Hans"]) {
        
        NSLog(@"%@",self.self.str_ContributionAddedDate);
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"yyyy年M月d日'"];
        NSString *localDateString = [dateFormatter stringFromDate:self.datePicker_ContributionDate.date];
        self.lbl_Date.text = [NSString stringWithFormat:@"%@",localDateString];
        NSLog(@"%@",localDateString);
    }
    
    //////////////////////// UISwipeGestureRecognizer ////////////////////////
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    // Setting the swipe direction.
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.view addGestureRecognizer:swipeRight];
    
    self.view_Shadow.hidden = TRUE;
    self.view_DatePicker.hidden =TRUE;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    
    
}

-(void)dismissKeyboard
{
    [self.txt_Amount resignFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = false;
   
    [Flurry logEvent:@"Add Contributions towards Goal"];
    
    [Localytics tagEvent:@"Add Contributions towards Goal"];
    
    [FIRAnalytics logEventWithName:@"Add_Contributions_towards_Goal"
                        parameters:nil];
    
    if (![[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InAppPurchase"] isEqualToString:@"1"])
    {
        self.view_AD.hidden = FALSE;
        
        self.view_AD.adUnitID = @"ca-app-pub-5298130731078005/7401333379";
        self.view_AD.rootViewController = self;
        GADRequest *request = [GADRequest request];
        
        //request.testDevices = @[ @"e33953a7d4e4e4fbac2a3e08d60e4f9db7abcdfa" ];
        
        [self.view_AD loadRequest:request];

        
    }
    else{
        self.view_AD.hidden = TRUE;

    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [super viewWillAppear:YES];
}

#pragma mark UISwipeGestureRecognizer METHOD

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



-(IBAction)action_SelectDate:(UIButton *)sender
{
    [self.view endEditing:YES];
    self.datePicker_ContributionDate.datePickerMode = UIDatePickerModeDate;
    self.view_Shadow.hidden = FALSE;
    self.view_DatePicker.hidden = FALSE;
    
}

-(IBAction)action_DoneDatePicker:(UIButton *)sender
{
    NSDateFormatter *df_TargetDate = [[NSDateFormatter alloc] init];
    [df_TargetDate setDateFormat:@"MMM dd, yyyy"];
    self.lbl_Date.text = [NSString stringWithFormat:@"%@",[df_TargetDate stringFromDate:self.datePicker_ContributionDate.date]];
    
    NSDateFormatter *df_TargetDate1 = [[NSDateFormatter alloc] init];
    [df_TargetDate1 setDateFormat:@"yyyy-MM-dd"];
    self.str_ContributionAddedDate = [NSString stringWithFormat:@"%@",
                                      [df_TargetDate1 stringFromDate:self.datePicker_ContributionDate.date]];
    
    if ([self.language isEqualToString:@"zh-Hans"]) {
        
        NSLog(@"%@",self.str_ContributionAddedDate);
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"yyyy年M月d日'"];
        NSString *localDateString = [dateFormatter stringFromDate:self.datePicker_ContributionDate.date];
        self.lbl_Date.text = [NSString stringWithFormat:@"%@",localDateString];
        NSLog(@"%@",localDateString);
    }

    self.view_DatePicker.hidden = TRUE;
    self.view_Shadow.hidden = TRUE;
}

-(IBAction)action_CancelDatePicker:(UIButton *)sender
{
    self.view_DatePicker.hidden = TRUE;
    self.view_Shadow.hidden = TRUE;
}

-(IBAction)action_SaveContribution:(id)sender
{
    if ([txt_Amount.text length]<1)
    {
        NSString *str_AlertText = [NSString stringWithFormat:NSLocalizedString(@"Please enter amount", nil)];
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Contributions", nil) message:str_AlertText delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    }
    else if ([txt_Notes.text length]<1)
    {
        txt_Notes.text = @"";
        [self saveContribution];
    }
    
    else
    {
        [self saveContribution];
    }
}

-(void)saveContribution
{
    NSDateFormatter *df_TargetDate = [[NSDateFormatter alloc] init];
    [df_TargetDate setDateFormat:@"yyyy-MM-dd"];
    str_ContributionAddedDate = [NSString stringWithFormat:@"%@",
                                 [df_TargetDate stringFromDate:datePicker_ContributionDate.date]];
    Contribution *addContribution =  [Contribution MR_createEntityInContext:self.editingContext];
    self.contributionAdd = addContribution;
    
    [self.contributionAdd setR_goal:[self.goal objectAtIndex:0]];
    
    self.contributionAdd.c_notes = txt_Notes.text;
    self.contributionAdd.c_date = str_ContributionAddedDate;
    
    NSString *str_ContributionAmount = txt_Amount.text;
    str_ContributionAmount=[str_ContributionAmount stringByReplacingOccurrencesOfString:@"," withString:@""];
    self.contributionAdd.c_amount = str_ContributionAmount;
    
    [self.editingContext MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
        if (!error)
        {
            NSManagedObjectID *ContributionObjectID = [self.contributionAdd objectID];
            int Contribution_PK = [[[[[ContributionObjectID URIRepresentation] absoluteString] lastPathComponent] substringFromIndex:1] intValue];
            NSLog(@"%d",Contribution_PK);
            
            NSString *str_NumberContribution = [NSString stringWithFormat:@"%d",Contribution_PK];
            
            NSManagedObjectID *GoalObjectID = [self.selectedGoal objectID];
            int Goal_PK = [[[[[GoalObjectID URIRepresentation] absoluteString] lastPathComponent] substringFromIndex:1] intValue];
            NSLog(@"%d",Goal_PK);
            
            NSString *str_NumberGoal = [NSString stringWithFormat:@"%d",Goal_PK];
            
            NSDictionary *articleParams = [NSDictionary dictionaryWithObjectsAndKeys:
                                           str_NumberContribution, @"Contribution Number",
                                           str_NumberGoal, @"Number for Goal",
                                           nil];
            
            [Flurry logEvent:@"New Contribution Added" withParameters:articleParams];
            
            [Localytics tagEvent:@"New Contribution Added" attributes:articleParams];
            
            NSDictionary *articleParams2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                            str_NumberContribution, @"Contribution_Number",
                                            str_NumberGoal, @"Number_for_Goal",
                                            nil];
            
            [FIRAnalytics logEventWithName:@"New_Contribution_Added"
                                parameters:articleParams2];
            
            double contributionAmount = 0.0;
            
            id a = selectedGoal.objectID;
            NSPredicate *m = [NSPredicate predicateWithFormat:@"(r_goal == %@)",a];
            
            NSMutableArray *muary_TotalOfContribution = [[NSMutableArray alloc]init];
            [muary_TotalOfContribution addObjectsFromArray:[Contribution MR_findAllWithPredicate:m]];
            
            double ContributionTotal = 0.0;
            for (int i = 0; i<muary_TotalOfContribution.count; i++)
            {
                Contribution *GoalContribution = [muary_TotalOfContribution objectAtIndex:i];
                ContributionTotal += [GoalContribution.c_amount doubleValue];
            }
            
            contributionAmount = ContributionTotal;
            
            //double precentage = (100 * contributionAmount)/[selectedGoal.g_amount doubleValue];
            
            
            if (contributionAmount >= [selectedGoal.g_amount doubleValue])
            {
                selectedGoal.g_completedstatus = @"Completed";
                
                
                NSString *str_ObjectID = [NSString stringWithFormat:@"%@",selectedGoal.objectID];
                [Scheduale_Event CancelExistingNotification:str_ObjectID];
            }
            else
            {
                NSString *str_ObjectID = [NSString stringWithFormat:@"%@",selectedGoal.objectID];
                [Scheduale_Event CancelExistingNotification:str_ObjectID];
                
                selectedGoal.g_completedstatus = @"Not Completed";
                
                if ([selectedGoal.g_reminderday isEqualToString:@"Sunday"])
                {
                    integer_SelectedReminderDay = 1;
                }
                else if ([selectedGoal.g_reminderday isEqualToString:@"Monday"])
                {
                    integer_SelectedReminderDay = 2;
                }
                else if ([selectedGoal.g_reminderday isEqualToString:@"Tuesday"])
                {
                    integer_SelectedReminderDay = 3;
                }
                else if ([selectedGoal.g_reminderday isEqualToString:@"Wednesday"])
                {
                    integer_SelectedReminderDay = 4;
                }
                else if ([selectedGoal.g_reminderday isEqualToString:@"Thursday"])
                {
                    integer_SelectedReminderDay = 5;
                }
                else if ([selectedGoal.g_reminderday isEqualToString:@"Friday"])
                {
                    integer_SelectedReminderDay = 6;
                }
                else if ([selectedGoal.g_reminderday isEqualToString:@"Saturday"])
                {
                    integer_SelectedReminderDay = 7;
                }
                
                
                if ([selectedGoal.g_setsavingreminder isEqualToString:@"YES"])
                {
                    //NSLog(@"%@",self.goalAdd.objectID);
                    NSString *str_ObjectID = [NSString stringWithFormat:@"%@",selectedGoal.objectID];
                    [Scheduale_Event CancelExistingNotification:str_ObjectID];
                    
                    if ([selectedGoal.g_savingfrequency isEqualToString:@"Daily"])
                    {
                        NSDate *currentDate = [[NSDate alloc] init];
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                        NSString *localDateString = [dateFormatter stringFromDate:currentDate];
                        
                        NSString *str_DateAndTime = [NSString stringWithFormat:@"%@ %@:00",localDateString,selectedGoal.g_remindertime];
                        //NSLog(@"%@",str_DateAndTime);
                        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        NSDate *date_DateAndTime = [dateFormatter dateFromString:str_DateAndTime];
                        
                        NSString *str_Add = [NSString stringWithFormat:NSLocalizedString(@"add Daily contribution to goal", nil)];
                        
                        NSString *str_Message = [NSString stringWithFormat:@"%@ \"%@\"",str_Add,selectedGoal.g_title];
                        
                        [Scheduale_Event scheduleLocalNotificationWithDate:date_DateAndTime atIndex:str_ObjectID Description:str_Message repeat:@"Daily"];
                    }
                    else if ([selectedGoal.g_savingfrequency isEqualToString:@"Weekly"])
                    {
                        NSDate *today = [NSDate date];
                        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                        [gregorian setLocale:[NSLocale currentLocale]];
                        NSDateComponents *nowComponents = [gregorian components:NSCalendarUnitYear | NSCalendarUnitWeekOfYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday fromDate:today];
                        
                        NSInteger weekday = [nowComponents weekday];
                        //NSLog(@"%ld",(long)weekday) ;
                        [nowComponents setWeekday:integer_SelectedReminderDay]; //Monday
                        if (weekday >= integer_SelectedReminderDay)
                        {
                            [nowComponents setWeekOfYear:[nowComponents weekOfYear]+1];
                            
                            //[nowComponents setWeek: [nowComponents week]+1];
                        }
                        else
                        {
                            [nowComponents setWeekOfYear:[nowComponents weekOfYear]];
                        }
                        NSDate *beginningOfWeek = [gregorian dateFromComponents:nowComponents];
                        
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                        NSString *localDateString = [dateFormatter stringFromDate:beginningOfWeek];
                        NSString *str_DateAndTime = [NSString stringWithFormat:@"%@ %@:00",localDateString,selectedGoal.g_remindertime];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        NSDate *date_DateAndTime = [dateFormatter dateFromString:str_DateAndTime];
                        //NSLog(@"%@",date_DateAndTime);
                        
                        NSString *str_Add = [NSString stringWithFormat:NSLocalizedString(@"add Weekly contribution to goal", nil)];
                        
                        
                        
                        NSString *str_Message = [NSString stringWithFormat:@"%@ \"%@\"",str_Add,selectedGoal.g_title];
                        
                        [Scheduale_Event scheduleLocalNotificationWithDate:date_DateAndTime atIndex:str_ObjectID Description:str_Message repeat:@"Weekly"];
                        
                        //NSLog(@"%@",beginningOfWeek);
                    }
                    else if ([selectedGoal.g_savingfrequency isEqualToString:@"Bi-weekly"])
                    {
                        NSDate *today = [NSDate date];
                        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                        [gregorian setLocale:[NSLocale currentLocale]];
                        NSDateComponents *nowComponents = [gregorian components:NSCalendarUnitYear | NSCalendarUnitWeekOfYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday fromDate:today];
                        
                        NSInteger weekday = [nowComponents weekday];
                        //NSLog(@"%ld",(long)weekday) ;
                        [nowComponents setWeekday:integer_SelectedReminderDay]; //Monday
                        if (weekday >= integer_SelectedReminderDay)
                        {
                            [nowComponents setWeekOfYear:[nowComponents weekOfYear]+1];
                            
                            //[nowComponents setWeek: [nowComponents week]+1];
                        }
                        else
                        {
                            [nowComponents setWeekOfYear:[nowComponents weekOfYear]];
                        }
                        NSDate *beginningOfWeek = [gregorian dateFromComponents:nowComponents];
                        
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                        NSString *localDateString = [dateFormatter stringFromDate:beginningOfWeek];
                        NSString *str_DateAndTime = [NSString stringWithFormat:@"%@ %@:00",localDateString,selectedGoal.g_remindertime];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        NSDate *date_DateAndTime = [dateFormatter dateFromString:str_DateAndTime];
                        //NSLog(@"%@",date_DateAndTime);
                        
                        NSString *str_Add = [NSString stringWithFormat:NSLocalizedString(@"add Weekly contribution to goal", nil)];
                        
                        
                        
                        NSString *str_Message = [NSString stringWithFormat:@"%@ \"%@\"",str_Add,selectedGoal.g_title];
                        
                        [Scheduale_Event scheduleLocalNotificationWithDate:date_DateAndTime atIndex:str_ObjectID Description:str_Message repeat:@"Weekly"];
                        
                        //NSLog(@"%@",beginningOfWeek);
                        
                    }
                    else if ([selectedGoal.g_savingfrequency isEqualToString:@"Monthly"])
                    {
                        NSDate *today = [NSDate date];
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setDateFormat:@"yyyy-MM"];
                        NSString *localDateString = [dateFormatter stringFromDate:today];
                        
                        NSString *str_SelectedFullDate = [NSString stringWithFormat:@"%@-%@",localDateString,selectedGoal.g_reminderdate];
                        //NSLog(@"%@",str_SelectedFullDate);
                        
                        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                        NSString *str_TodayFullDate = [dateFormatter stringFromDate:today];
                        //NSLog(@"%@",str_TodayFullDate);
                        
                        NSDate *date_TodayDate = [dateFormatter dateFromString:str_TodayFullDate];
                        NSDate *date_SelectedDate = [dateFormatter dateFromString:str_SelectedFullDate];
                        
                        //NSLog(@"%@",date_TodayDate);
                        //NSLog(@"%@",date_SelectedDate);
                        
                        NSComparisonResult result = [date_TodayDate compare:date_SelectedDate];
                        
                        //NSLog(@"%ld",result);
                        
                        if (result == NSOrderedDescending)
                        {
                            NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                            [gregorian setLocale:[NSLocale currentLocale]];
                            NSDateComponents *nowComponents = [gregorian components:NSCalendarUnitYear | NSCalendarUnitWeekOfYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday fromDate:today];
                            
                            //                       NSInteger Month = [nowComponents month];
                            NSInteger Year = [nowComponents year];
                            
                            //NSLog(@"%ld",(long)Month);
                            //NSLog(@"%ld",(long)Year);
                            
                            [nowComponents setMonth:[nowComponents month]+1];
                            NSInteger Month1 = [nowComponents month];
                            //NSString *localDateString =
                            
                            NSString *str_SelectedFullDate = [NSString stringWithFormat:@"%ld-%02ld-%@",(long)Year,(long)Month1,selectedGoal.g_reminderdate];
                            //NSLog(@"%@",str_SelectedFullDate);
                            
                            NSString *str_DateAndTime = [NSString stringWithFormat:@"%@ %@:00",str_SelectedFullDate,selectedGoal.g_remindertime];
                            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                            NSDate *date_DateAndTime = [dateFormatter dateFromString:str_DateAndTime];
                            //NSLog(@"%@",date_DateAndTime);
                            
                            NSString *str_Add = [NSString stringWithFormat:NSLocalizedString(@"add Monthly contribution to goal", nil)];
                            
                            
                            
                            NSString *str_Message = [NSString stringWithFormat:@"%@ \"%@\"",str_Add,selectedGoal.g_title];
                            
                            [Scheduale_Event scheduleLocalNotificationWithDate:date_DateAndTime atIndex:str_ObjectID Description:str_Message repeat:@"Monthly"];
                            
                        }
                        else
                        {
                            NSString *str_DateAndTime = [NSString stringWithFormat:@"%@ %@:00",str_SelectedFullDate,selectedGoal.g_remindertime];
                            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                            NSDate *date_DateAndTime = [dateFormatter dateFromString:str_DateAndTime];
                            //NSLog(@"%@",date_DateAndTime);
                            NSString *str_Add = [NSString stringWithFormat:NSLocalizedString(@"add Monthly contribution to goal", nil)];
                            
                            NSString *str_Message = [NSString stringWithFormat:@"%@ \"%@\"",str_Add,selectedGoal.g_title];
                            
                            [Scheduale_Event scheduleLocalNotificationWithDate:date_DateAndTime atIndex:str_ObjectID Description:str_Message repeat:@"Monthly"];
                        }
                    }
                    
                }
                
                
                
                
                
                //                if(precentage >= 80.0)
                //                {
                //                    if ([selectedGoal.g_eighty isEqualToString:@""])
                //                    {
                //                        selectedGoal.g_eighty = @"80";
                //                        str_milestone_persentage = @"80";
                //                    }
                //                    else
                //                    {
                //                        str_milestone_persentage = @"";
                //                    }
                //                }
                //                else if (precentage >= 50.0)
                //                {
                //                    if ([selectedGoal.g_fifty isEqualToString:@""])
                //                    {
                //                        selectedGoal.g_fifty = @"50";
                //                        str_milestone_persentage = @"50";
                //                    }
                //                    else
                //                    {
                //                        str_milestone_persentage = @"";
                //                    }
                //                }
            }
            
            selectedGoal.g_contributedamount = [NSString stringWithFormat:@"%.2f",contributionAmount];
            
            [self.editingContext MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
                [self.navigationController popViewControllerAnimated:YES];
                
//                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Contributions", nil) message:NSLocalizedString(@"Do you want to share this goal information?",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"Share",nil),nil];
//                alert.tag = 1111;
//                [alert show];
            }];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Contributions", nil) message:[error localizedDescription] delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (NSManagedObjectContext *)editingContext
{
    if (!_editingContext)
    {
        _editingContext = [NSManagedObjectContext MR_defaultContext];
    }
    
    return _editingContext;
}

- (NSArray *)goal
{
    id a = selectedGoal.objectID;

    NSPredicate *m = [NSPredicate predicateWithFormat:@"(self == %@)",a];
    _goal = [Goal MR_findAllWithPredicate:m inContext:self.editingContext];

    return _goal;
}
#pragma mark - All Delegate Methods
#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    }
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
   return TRUE;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag==1)
    {
        NSRange minusrange = [textField.text rangeOfString:@"-"];
        
        NSRange dotrange = [textField.text rangeOfString:@"."];
        
        if(textField.text.length==0 && [string isEqualToString:@"."])
            textField.text=@"0";
        else if([textField.text isEqualToString:@"-"] && [string isEqualToString:@"."])
            textField.text=@"-0";
        
        if (dotrange.length > 0 && [string isEqualToString:@"."])
            return NO;
        else if (textField.text.length==0 && [string isEqualToString:@"-"])
            return YES;
        else if (range.location==0 && minusrange.length==0 && [string isEqualToString:@"-"])
            return YES;
        else
        {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890."];
            for (int i = 0; i < [string length]; i++)
            {
                unichar c = [string characterAtIndex:i];
                if (![myCharSet characterIsMember:c])
                {
                    return NO;
                }
            }
        }
    }
    
    return YES;
}

#pragma mark - AlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    
    if (alertView.tag == 1)
    {
        if (buttonIndex == 0)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1111)
        
    {
        if (buttonIndex == 0)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [self.view endEditing:true];
            ShareViewController *obj_Currency_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"ShareViewController"];
            obj_Currency_ViewController.goal_details = self.selectedGoal;
            obj_Currency_ViewController.str_from = @"Contribution";
            [self.navigationController pushViewController:obj_Currency_ViewController animated:YES];
            
        }
    }
}

@end