//
//  ContributionsLists_ViewController.m
//  GoalManager
//
//  Created by apple on 11/11/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import "ContributionsLists_ViewController.h"
#import "Cell_ContributionsList.h"
#import "NSString+FontAwesome.h"
#import "AddContributions_ViewController.h"
#import "EditContribution_ViewController.h"
#import "GoalManagerAppDelegate.h"
#import "Scheduale_Event.h"
#import "GoalManager.h"

@interface ContributionsLists_ViewController ()

@end

@implementation ContributionsLists_ViewController
@synthesize lbl_Back,lbl_AddContribution;
@synthesize btn_Back,btn_AddContribution;
@synthesize tbl_ContributionLists;
@synthesize contributionList;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize selectedGoal;
@synthesize editingContext = _editingContext;
@synthesize view_NoContributions;
#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //self.title = @"Contributions";
    self.title = NSLocalizedString(@"Contributions", nil);
    
    self.language = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    UIImage* image2 = [UIImage imageNamed:@"navbar_back.png"];
    CGRect frameimg2 = CGRectMake(0, 0,22,22);
    UIButton *someButton2 = [[UIButton alloc] initWithFrame:frameimg2];
    [someButton2 setBackgroundImage:image2 forState:UIControlStateNormal];
    [someButton2 addTarget:self action:@selector(action_Back:)
          forControlEvents:UIControlEventTouchUpInside];
    [someButton2 setSelected:YES];
    
    btn_Back= [[UIBarButtonItem alloc]initWithCustomView:someButton2];
    
    NSArray *arr_GoalOverviewLeft= [[NSArray alloc] initWithObjects:btn_Back,nil];
    self.navigationItem.leftBarButtonItems = arr_GoalOverviewLeft;
    
    UIImage* image = [UIImage imageNamed:@"navbar_add_goal.png"];
    CGRect frameimg = CGRectMake(0, 0,22,22);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(action_AddContribution:) forControlEvents:UIControlEventTouchUpInside];
    [someButton setSelected:YES];
    
    UIBarButtonItem *btn_AddGoal= [[UIBarButtonItem alloc]initWithCustomView:someButton];
    NSArray *arr_AddFilterGoal= [[NSArray alloc] initWithObjects:btn_AddGoal,nil];
    self.navigationItem.rightBarButtonItems = arr_AddFilterGoal;
    
    //////////////////////// UISwipeGestureRecognizer ////////////////////////
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    // Setting the swipe direction.
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.view addGestureRecognizer:swipeRight];
    
    self.view_AD.adUnitID = @"ca-app-pub-5298130731078005/7401333379";
    self.view_AD.rootViewController = self;
    GADRequest *request = [GADRequest request];
    
    //request.testDevices = @[ @"e33953a7d4e4e4fbac2a3e08d60e4f9db7abcdfa" ];
    
    [self.view_AD loadRequest:request];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = false;
    [Localytics tagEvent:@"List of Contributions towards Goal"];
    [Flurry logEvent:@"List of Contributions towards Goal"];
    [FIRAnalytics logEventWithName:@"List_of_Contributions"
                        parameters:nil];
    NSMutableArray *muary_ContributionCountCheck = [[NSMutableArray alloc]init];
    id a = selectedGoal.objectID;
    NSPredicate *m = [NSPredicate predicateWithFormat:@"(r_goal == %@)",a];
    [muary_ContributionCountCheck addObjectsFromArray:[Contribution MR_findAllWithPredicate:m]];
    
    if (muary_ContributionCountCheck.count == 0)
    {
        self.view_NoContributions.hidden = FALSE;
        self.tbl_ContributionLists.hidden = TRUE;
        
        BOOL isInternetCheck = [GoalManagerAppDelegate connectedToNetwork];
        if (isInternetCheck == TRUE)
        {
            if (![[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InAppPurchase"] isEqualToString:@"1"])
            {
                self.view_AD.hidden = FALSE;
            }
            else
            {
                self.view_AD.hidden = TRUE;
            }
        }
        else
        {
             self.view_AD.hidden = TRUE;
        }
    }
    else
    {
        self.view_NoContributions.hidden = TRUE;
        self.tbl_ContributionLists.hidden = FALSE;
        
        BOOL isInternetCheck = [GoalManagerAppDelegate connectedToNetwork];
        if (isInternetCheck == TRUE)
        {
            if (![[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InAppPurchase"] isEqualToString:@"1"])
            {
                self.view_AD.hidden = FALSE;
                
                NSLog(@"%f",self.view.frame.size.height);
                
//                CGRect tbl1 = self.view_Totals.frame;
//                tbl1.origin.y = self.view.bounds.size.height-tbl1.size.height-50;
//                self.view_Totals.frame = tbl1;
                
                CGRect tbl = self.tbl_ContributionLists.frame;
                tbl.size.height = self.view.bounds.size.height-50;
                self.tbl_ContributionLists.frame = tbl;
                
            }
            else
            {
                self.view_AD.hidden = TRUE;
                
                CGRect tbl = self.tbl_ContributionLists.frame;
                tbl.size.height = self.view.bounds.size.height;
                self.tbl_ContributionLists.frame = tbl;
            }
        }
        else
        {
            self.view_AD.hidden = TRUE;
            
            CGRect tbl = self.tbl_ContributionLists.frame;
            tbl.size.height = self.view.bounds.size.height;
            self.tbl_ContributionLists.frame = tbl;
        }
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

- (IBAction)action_AddContribution:(id)sender
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
    NSDictionary *articleParams = [NSDictionary dictionaryWithObjectsAndKeys:
                                   @"From Contribution List", @"AddContribution",
                                   nil];
    
    [Flurry logEvent:@"Add Contribution" withParameters:articleParams];
    
    [Localytics tagEvent:@"Add Contribution" attributes:articleParams];
    
    NSDictionary *articleParams2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"From Contribution List", @"AddContribution",
                                    nil];
    
    [FIRAnalytics logEventWithName:@"Add_Contribution"
                        parameters:articleParams2];
    
    AddContributions_ViewController *obj_AddContributions_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"AddContributions_ViewController"];
    obj_AddContributions_ViewController.selectedGoal = selectedGoal;
    [self.navigationController pushViewController:obj_AddContributions_ViewController animated:YES];

}

#pragma mark All Delegates

- (NSFetchedResultsController *)fetchedResultsController {
    if (!_fetchedResultsController )
    {
        id a = selectedGoal.objectID;
        NSPredicate *m = [NSPredicate predicateWithFormat:@"(r_goal == %@)",a];
        _fetchedResultsController = [Contribution MR_fetchAllGroupedBy:nil withPredicate:m sortedBy:@"c_date" ascending:YES delegate:self];
    }
    return _fetchedResultsController;
}


#pragma mark tableView code

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    NSInteger numberOfRows = [sectionInfo numberOfObjects];
    return numberOfRows;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell_ContributionsList";
    Cell_ContributionsList *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    Contribution *GoalContribution = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.lbl_Note.text = GoalContribution.c_notes;
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter1 dateFromString:GoalContribution.c_date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM, dd yyyy"];
    NSString *localDateString = [dateFormatter stringFromDate:date];
    
    cell.lbl_Date.text = [NSString stringWithFormat:@"%@",localDateString];
    
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
        
        NSLog(@"%@",localDateString);
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"yyyy年M月d日'"];
        NSString *localDateString = [dateFormatter stringFromDate:date];
        cell.lbl_Date.text = [NSString stringWithFormat:@"%@",localDateString];
        NSLog(@"%@",localDateString);
    }

    
    double ContributionTotal = [GoalContribution.c_amount doubleValue];
    NSString *str_ContributionTotal = [NSString stringWithFormat:@"%.2f",ContributionTotal];
    str_ContributionTotal=[GoalManagerAppDelegate Change_String_Formate:str_ContributionTotal];
    
    NSRange range = [str_ContributionTotal rangeOfString:@"-"];
    if (range.location != NSNotFound)
    {
        str_ContributionTotal = [str_ContributionTotal stringByReplacingOccurrencesOfString:@"-" withString:@""];
        cell.lbl_Amount.text = [NSString stringWithFormat:@"- %@ %@",str_ContributionTotal,GoalContribution.r_goal.g_currency];
    }
    else
    {
        cell.lbl_Amount.text = [NSString stringWithFormat:@"+ %@ %@",str_ContributionTotal,GoalContribution.r_goal.g_currency];
        
    }
    
    cell.lbl_Arrow.font = [UIFont fontWithName:kFontAwesomeFamilyName size:15];
    cell.lbl_Arrow.text = [NSString fontAwesomeIconStringForIconIdentifier:@"fa-chevron-right"];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditContribution_ViewController *obj_EditContribution_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"EditContribution_ViewController"];
    
    [obj_EditContribution_ViewController setContributionEdit:[self.fetchedResultsController objectAtIndexPath:indexPath]];
    obj_EditContribution_ViewController.selectedGoal = selectedGoal;
    [self.navigationController pushViewController:obj_EditContribution_ViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        [[self.fetchedResultsController objectAtIndexPath:indexPath] MR_deleteEntity];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
            if (!error)
            {
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
                    //                       str_milestone_persentage = @"";
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
                    //                       str_milestone_persentage = @"";
                    //                    }
                    //                }
                    
                }
                selectedGoal.g_contributedamount = [NSString stringWithFormat:@"%.2f",contributionAmount];
                [self.editingContext MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
                    if (!error)
                    {
                        
                    }
                    else
                    {
                        
                    }
                }];
                
                [self viewWillAppear:YES];
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Contributions", nil) message:[error localizedDescription] delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                [alert show];
            }
            
        }];
        
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    _fetchedResultsController = nil;
    [self.tbl_ContributionLists reloadData];
}

#pragma mark - Custom Accessors

- (NSManagedObjectContext *)editingContext
{
    if (!_editingContext)
    {
        _editingContext = [NSManagedObjectContext MR_defaultContext];
    }
    
    return _editingContext;
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
@end
