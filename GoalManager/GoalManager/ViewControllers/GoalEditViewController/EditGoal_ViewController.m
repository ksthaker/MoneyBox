//
//  EditGoal_ViewController.m
//  GoalManager
//
//  Created by apple on 12/11/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import "EditGoal_ViewController.h"
#import "NSString+FontAwesome.h"
#import "GoalManagerAppDelegate.h"
#import "Currency_ViewController.h"
#import "Cell_PlannedSavingsFrequency.h"
#import "GoalManager.h"
#import "PredefinedIcon_ViewController.h"
#import "Scheduale_Event.h"
#import "Contribution.h"
//#import "FHSTwitterEngine.h"
@interface EditGoal_ViewController ()

@end

@implementation EditGoal_ViewController
@synthesize editingContext = _editingContext;

@synthesize img_GoalLogo,imgView_InitialScreen;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.title = @"Edit Goal";
    
    self.title = NSLocalizedString(@"Edit Goal", nil);
    
    [[GoalManagerAppDelegate getdefaultvalue]setObject:@"" forKey:@"perdefone_imagename"];
    
    self.txt_SavingsAccount.text = @"";
    
    self.language = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    [[GoalManagerAppDelegate getdefaultvalue]setObject:@"" forKey:@"perdefone_imagename"];
    
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
    [someButton addTarget:self action:@selector(action_SaveGoal:) forControlEvents:UIControlEventTouchUpInside];
    [someButton setSelected:YES];
    
    UIBarButtonItem *btn_SaveContributionBar= [[UIBarButtonItem alloc]initWithCustomView:someButton];
    
    NSArray *arr_AddFilterGoal= [[NSArray alloc] initWithObjects:btn_SaveContributionBar,nil];
    self.navigationItem.rightBarButtonItems = arr_AddFilterGoal;
    
    self.datePicker_Date.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
    self.pickerView_ReminderDateMonthly.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
    isSetReminder = FALSE;
    self.str_SetSavingReminder = @"NO";
    [self.switch_SetReminder setOn:FALSE];
 
    self.view_SetReminderWeekly.hidden = TRUE;
    self.view_SetReminderMonthly.hidden =TRUE;
    self.view_SetReminderDaily.hidden = TRUE;
    
    self.view_SetDate.hidden = TRUE;
    self.view_SetDateMonthly.hidden = TRUE;
    self.view_Sahdow.hidden = TRUE;
    
    self.scroll_AddGoal.contentSize = CGSizeMake(0, 648);
   
    self.datePicker_Date.datePickerMode = UIDatePickerModeDate;
    self.muary_PlannedSavingsFrequency = [[NSMutableArray alloc]initWithObjects:@"Not Planned",@"Daily",@"Weekly",@"Monthly", nil];
    
    
    self.str_Monday = [NSString stringWithFormat:NSLocalizedString(@"Monday", nil)];
    self.str_Tuesday = [NSString stringWithFormat:NSLocalizedString(@"Tuesday", nil)];
    self.str_Wednesday = [NSString stringWithFormat:NSLocalizedString(@"Wednesday", nil)];
    self.str_Thursday = [NSString stringWithFormat:NSLocalizedString(@"Thursday", nil)];
    self.str_Friday = [NSString stringWithFormat:NSLocalizedString(@"Friday", nil)];
    self.str_Saturday = [NSString stringWithFormat:NSLocalizedString(@"Saturday", nil)];
    self.str_Sunday = [NSString stringWithFormat:NSLocalizedString(@"Sunday", nil)];
    
    
    
    self.muary_ReminderDay2 = [[NSMutableArray alloc]initWithObjects:self.str_Monday,self.str_Tuesday,self.str_Wednesday,self.str_Thursday,self.str_Friday,self.str_Saturday,self.str_Sunday, nil];
    
    self.muary_ReminderDay = [[NSMutableArray alloc]initWithObjects:@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday",@"Sunday", nil];
    
    self.muary_ReminderDates = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31", nil];
    
    integer_SelectFrequency = 0;
    
    self.str_SetSavingReminder = @"NO";
    self.str_PlannedSavingFrequency = @"Not Planned";
    self.lbl_SavingFrequency.text = [NSString stringWithFormat:NSLocalizedString(@"Not Planned", nil)];
    
    self.lbl_CurrencyArrow.font = [UIFont fontWithName:kFontAwesomeFamilyName size:15];
    self.lbl_CurrencyArrow.text = [NSString fontAwesomeIconStringForIconIdentifier:@"fa-chevron-right"];
    
    self.lbl_FrequencyArrow.font = [UIFont fontWithName:kFontAwesomeFamilyName size:15];
    self.lbl_FrequencyArrow.text = [NSString fontAwesomeIconStringForIconIdentifier:@"fa-chevron-right"];
    
    self.lbl_TargetDateArrow.font = [UIFont fontWithName:kFontAwesomeFamilyName size:15];
    self.lbl_TargetDateArrow.text = [NSString fontAwesomeIconStringForIconIdentifier:@"fa-chevron-right"];
    
    self.lbl_DailyRemindMeArrow.font = [UIFont fontWithName:kFontAwesomeFamilyName size:15];
    self.lbl_DailyRemindMeArrow.text = [NSString fontAwesomeIconStringForIconIdentifier:@"fa-chevron-right"];
    
    self.lbl_WeeklyRemindeMeArrow.font = [UIFont fontWithName:kFontAwesomeFamilyName size:15];
    self.lbl_WeeklyRemindeMeArrow.text = [NSString fontAwesomeIconStringForIconIdentifier:@"fa-chevron-right"];
    
    self.lbl_WeeklyReminderDayArrow.font = [UIFont fontWithName:kFontAwesomeFamilyName size:15];
    self.lbl_WeeklyReminderDayArrow.text = [NSString fontAwesomeIconStringForIconIdentifier:@"fa-chevron-right"];
    
    self.lbl_MonthlyRemindeMeArrow.font = [UIFont fontWithName:kFontAwesomeFamilyName size:15];
    self.lbl_MonthlyRemindeMeArrow.text = [NSString fontAwesomeIconStringForIconIdentifier:@"fa-chevron-right"];
    
    self.lbl_MonthlyReminderDateArrow.font = [UIFont fontWithName:kFontAwesomeFamilyName size:15];
    self.lbl_MonthlyReminderDateArrow.text = [NSString fontAwesomeIconStringForIconIdentifier:@"fa-chevron-right"];
    
    
    self.datePicker_Date.date = [NSDate date];
    NSDateFormatter *df_TargetDate = [[NSDateFormatter alloc] init];
    [df_TargetDate setDateFormat:@"MMM dd, yyyy"];
    self.lbl_TargetDate.text = [NSString stringWithFormat:@"%@",[df_TargetDate stringFromDate:self.datePicker_Date.date]];
    
    NSDateFormatter *df_TargetDate2 = [[NSDateFormatter alloc] init];
    [df_TargetDate2 setDateFormat:@"yyyy-MM-dd"];
    self.str_TargetDate = [NSString stringWithFormat:@"%@",
                           [df_TargetDate2 stringFromDate:self.datePicker_Date.date]];
    
    NSString *string = self.language;
    if ([string rangeOfString:@"zh-Hans"].location != NSNotFound) {
        self.language = @"zh-Hans";
    }
    else if ([string rangeOfString:@"es"].location != NSNotFound) {
        self.language = @"es";
    }
    else if ([string rangeOfString:@"ja"].location != NSNotFound){
        self.language = @"ja";
    }
    
    if ([self.language isEqualToString:@"zh-Hans"]) {
        
        NSLog(@"%@",self.str_TargetDate);
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:@"yyyy年M月d日'"];
        NSString *localDateString = [dateFormatter stringFromDate:self.datePicker_Date.date];
        self.lbl_TargetDate.text = [NSString stringWithFormat:@"%@",localDateString];
        NSLog(@"%@",localDateString);
    }
    
    [[GoalManagerAppDelegate getdefaultvalue]setObject:nil forKey:@"CurrencySelected"];
    
    //////////////////////// UISwipeGestureRecognizer ////////////////////////
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    // Setting the swipe direction.
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    isEdit = FALSE;
    
    self.imgView_GoalPicture.layer.cornerRadius = self.imgView_GoalPicture.frame.size.width/2;
    self.imgView_GoalPicture.clipsToBounds = YES;
    
    self.str_ReminderDate = @"1";
    self.lbl_add_photo.text = NSLocalizedString(@"Add icon or photo", nil);
    
    
}

#pragma mark UISwipeGestureRecognizer METHOD

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = false;
    self.txt_GoalAmount.keyboardType = UIKeyboardTypeDecimalPad;
    [Localytics tagEvent:@"Edit Goal"];
    [Flurry logEvent:@"Edit Goal"];
    
    [FIRAnalytics logEventWithName:@"Edit_Goal"
                        parameters:nil];
    if (isEdit == TRUE)
    {
        if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"CurrencySelected"]isEqualToString:@"1"])
        {
            self.lbl_Currency.text = [[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"CurrencyCode"];
            self.str_SelectedCurrencySymbol = [[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"CurrencySymbol"];
        }
    }
    else
    {
        
        if ([_currentGoal g_picture] == nil )
        {
            self.imgView_GoalPicture.image = [UIImage imageNamed:@"camera1.png"];
        }
        else
        {
            self.imgView_GoalPicture.image = [UIImage imageWithData:[_currentGoal g_picture]];
        }
        
        self.txt_TitleOfGoal.text = _currentGoal.g_title;
        self.txt_GoalAmount.text = _currentGoal.g_amount;
        self.lbl_Currency.text = _currentGoal.g_currency;
        
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter1 dateFromString:_currentGoal.g_targetdate];
        self.str_TargetDate = [NSString stringWithFormat:@"%@", [dateFormatter1 stringFromDate:date]];
        
        NSDateFormatter *df_TargetDate = [[NSDateFormatter alloc] init];
        [df_TargetDate setDateFormat:@"MMM dd, yyyy"];
        self.lbl_TargetDate.text = [NSString stringWithFormat:@"%@",[df_TargetDate stringFromDate:date]];
        
        self.datePicker_Date.date = date;
        
        if ([self.language isEqualToString:@"zh-Hans"]) {
            
            NSLog(@"%@",self.str_TargetDate);
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            
            [dateFormatter setDateFormat:@"yyyy年M月d日'"];
            NSString *localDateString = [dateFormatter stringFromDate:self.datePicker_Date.date];
            self.lbl_TargetDate.text = [NSString stringWithFormat:@"%@",localDateString];
            NSLog(@"%@",localDateString);
        }
        
        
        self.txt_SavingsAccount.text = _currentGoal.g_savingaccount;
        //self.lbl_SavingFrequency.text = _currentGoal.g_savingfrequency;
        self.str_PlannedSavingFrequency = _currentGoal.g_savingfrequency;
        self.lbl_Line.hidden = FALSE;
        
        if ([_currentGoal.g_setsavingreminder isEqualToString:@"YES"])
        {
            isSetReminder = TRUE;
            self.str_SetSavingReminder = @"YES";
            [self.switch_SetReminder setOn:TRUE];
            
            if ([_currentGoal.g_savingfrequency isEqualToString:@"Not Planned"])
            {
                self.str_PlannedSavingFrequency = @"Not Planned";
                self.view_SetReminderDaily.hidden = TRUE;
                self.view_SetReminderWeekly.hidden = TRUE;
                self.view_SetReminderMonthly.hidden = TRUE;
                
                self.scroll_AddGoal.contentSize = CGSizeMake(0, 648);
                self.lbl_SavingFrequency.text = NSLocalizedString(@"Not Planned", nil);
                self.btn_delete.frame = CGRectMake(self.btn_delete.frame.origin.x, self.btn_delete.frame.origin.y-100, self.btn_delete.frame.size.width, self.btn_delete.frame.size.height);
                
            }
            else if ([_currentGoal.g_savingfrequency isEqualToString:@"Daily"])
            {
                integer_SelectFrequency = 1;
                
                self.str_PlannedSavingFrequency = @"Daily";
                self.lbl_DailyRemindMe.text = [NSString stringWithFormat:@"%@",_currentGoal.g_remindertime];
                self.str_ReminderTime = [NSString stringWithFormat:@"%@",_currentGoal.g_remindertime];
                
                self.view_SetReminderDaily.hidden = FALSE;
                self.view_SetReminderWeekly.hidden = TRUE;
                self.view_SetReminderMonthly.hidden = TRUE;
                
                self.lbl_Line.hidden = TRUE;
                self.scroll_AddGoal.contentSize = CGSizeMake(0, 700);
                
                self.lbl_SavingFrequency.text = NSLocalizedString(@"Daily", nil);
                self.btn_delete.frame = CGRectMake(self.btn_delete.frame.origin.x, 625, self.btn_delete.frame.size.width, self.btn_delete.frame.size.height);
            }
            else if ([_currentGoal.g_savingfrequency isEqualToString:@"Weekly"])
            {
                integer_SelectFrequency = 2;
                self.str_PlannedSavingFrequency = @"Weekly";
                
                self.lbl_WeeklyReminderDay.text = [NSString stringWithFormat:@"%@",_currentGoal.g_reminderday];
                self.lbl_WeeklyRemindeMe.text = [NSString stringWithFormat:@"%@",_currentGoal.g_remindertime];
                self.str_ReminderTime = [NSString stringWithFormat:@"%@",_currentGoal.g_remindertime];
                
                self.view_SetReminderDaily.hidden = TRUE;
                self.view_SetReminderWeekly.hidden = FALSE;
                self.view_SetReminderMonthly.hidden = TRUE;
                
                self.lbl_Line.hidden = TRUE;
                self.scroll_AddGoal.contentSize = CGSizeMake(0, 727);
                
                self.lbl_SavingFrequency.text = NSLocalizedString(@"Weekly", nil);
                self.btn_delete.frame = CGRectMake(self.btn_delete.frame.origin.x, 678, self.btn_delete.frame.size.width, self.btn_delete.frame.size.height);
            }
            else if ([_currentGoal.g_savingfrequency isEqualToString:@"Bi-weekly"])
            {
                integer_SelectFrequency = 2;
                
                self.str_PlannedSavingFrequency = @"Weekly";
                
                self.lbl_WeeklyReminderDay.text = [NSString stringWithFormat:@"%@",_currentGoal.g_reminderday];
                self.lbl_WeeklyRemindeMe.text = [NSString stringWithFormat:@"%@",_currentGoal.g_remindertime];
                self.str_ReminderTime = [NSString stringWithFormat:@"%@",_currentGoal.g_remindertime];
                
                self.view_SetReminderDaily.hidden = TRUE;
                self.view_SetReminderWeekly.hidden = FALSE;
                self.view_SetReminderMonthly.hidden = TRUE;
                
                self.lbl_Line.hidden = TRUE;
                self.scroll_AddGoal.contentSize = CGSizeMake(0, 727);
                
                self.lbl_SavingFrequency.text = NSLocalizedString(@"Weekly", nil);
                self.btn_delete.frame = CGRectMake(self.btn_delete.frame.origin.x, 678, self.btn_delete.frame.size.width, self.btn_delete.frame.size.height);
                
            }
            else if ([_currentGoal.g_savingfrequency isEqualToString:@"Monthly"])
            {
                integer_SelectFrequency = 4;
                
                self.str_PlannedSavingFrequency = @"Monthly";
                
                self.lbl_MonthlyReminderDate.text = [NSString stringWithFormat:@"%@",_currentGoal.g_reminderdate];
                self.lbl_MonthlyRemindeMe.text = [NSString stringWithFormat:@"%@",_currentGoal.g_remindertime];
                
                self.str_ReminderDate = [NSString stringWithFormat:@"%@",_currentGoal.g_reminderdate];
                self.str_ReminderTime = [NSString stringWithFormat:@"%@",_currentGoal.g_remindertime];
                
                self.lbl_Line.hidden = TRUE;
                self.view_SetReminderDaily.hidden = TRUE;
                self.view_SetReminderWeekly.hidden = TRUE;
                self.view_SetReminderMonthly.hidden = FALSE;
                
                self.scroll_AddGoal.contentSize = CGSizeMake(0, 727);
                
                self.lbl_SavingFrequency.text = NSLocalizedString(@"Monthly", nil);
                self.btn_delete.frame = CGRectMake(self.btn_delete.frame.origin.x, 678, self.btn_delete.frame.size.width, self.btn_delete.frame.size.height);
            }
        }
        else
        {
            isSetReminder = FALSE;
            self.str_SetSavingReminder = @"NO";
            [self.switch_SetReminder setOn:FALSE];
            
            if ([_currentGoal.g_savingfrequency isEqualToString:@"Not Planned"])
            {
                self.str_PlannedSavingFrequency = @"Not Planned";
                self.lbl_SavingFrequency.text = NSLocalizedString(@"Not Planned", nil);
            }
            else if ([_currentGoal.g_savingfrequency isEqualToString:@"Daily"])
            {
                integer_SelectFrequency = 1;
                self.str_PlannedSavingFrequency = @"Daily";
                self.lbl_SavingFrequency.text = NSLocalizedString(@"Daily", nil);
            }
            else if ([_currentGoal.g_savingfrequency isEqualToString:@"Weekly"])
            {
                integer_SelectFrequency = 2;
                self.str_PlannedSavingFrequency = @"Weekly";
                self.lbl_SavingFrequency.text = NSLocalizedString(@"Weekly", nil);
            }
            else if ([_currentGoal.g_savingfrequency isEqualToString:@"Bi-weekly"])
            {
                integer_SelectFrequency = 2;
                self.str_PlannedSavingFrequency = @"Weekly";
                self.lbl_SavingFrequency.text = NSLocalizedString(@"Weekly", nil);
            }
            else if ([_currentGoal.g_savingfrequency isEqualToString:@"Monthly"])
            {
                integer_SelectFrequency = 4;
                self.str_PlannedSavingFrequency = @"Monthly";
                self.lbl_SavingFrequency.text = NSLocalizedString(@"Monthly", nil);
            }
            self.view_SetReminderDaily.hidden = TRUE;
            self.view_SetReminderWeekly.hidden = TRUE;
            self.view_SetReminderMonthly.hidden = TRUE;
            self.scroll_AddGoal.contentSize = CGSizeMake(0, 648);
            self.btn_delete.frame = CGRectMake(self.btn_delete.frame.origin.x,578, self.btn_delete.frame.size.width, self.btn_delete.frame.size.height);
        }
        
        if ([_currentGoal.g_reminderday isEqualToString:@"Sunday"])
        {
            integer_SelectedReminderDay = 1;
        }
        else if ([_currentGoal.g_reminderday isEqualToString:@"Monday"])
        {
            integer_SelectedReminderDay = 2;
        }
        else if ([_currentGoal.g_reminderday isEqualToString:@"Tuesday"])
        {
            integer_SelectedReminderDay = 3;
        }
        else if ([_currentGoal.g_reminderday isEqualToString:@"Wednesday"])
        {
            integer_SelectedReminderDay = 4;
        }
        else if ([_currentGoal.g_reminderday isEqualToString:@"Thursday"])
        {
            integer_SelectedReminderDay = 5;
        }
        else if ([_currentGoal.g_reminderday isEqualToString:@"Friday"])
        {
            integer_SelectedReminderDay = 6;
        }
        else if ([_currentGoal.g_reminderday isEqualToString:@"Saturday"])
        {
            integer_SelectedReminderDay = 7;
        }
        
        if ([_currentGoal.g_setsavingreminder isEqualToString:@"YES"])
        {
            isSetReminder = TRUE;
            self.str_SetSavingReminder = @"YES";
            [self.switch_SetReminder setOn:TRUE];
        }
        else
        {
            isSetReminder = FALSE;
            self.str_SetSavingReminder = @"NO";
            [self.switch_SetReminder setOn:FALSE];
           
        }
    }
    
    if (![[[GoalManagerAppDelegate getdefaultvalue]objectForKey:@"perdefone_imagename"] isEqualToString:@""])
    {
        NSString *str_ImageName = [NSString stringWithFormat:@"%@.png",[[GoalManagerAppDelegate getdefaultvalue]objectForKey:@"perdefone_imagename"]];
        NSLog(@"%@",str_ImageName);
        str_ImageName = [str_ImageName stringByReplacingOccurrencesOfString:@"2" withString:@"1"];
        NSLog(@"%@",str_ImageName);
        UIImage *img_icon = [UIImage imageNamed:str_ImageName];
        self.imgView_GoalPicture.image = img_icon;
    }
    
    UIImage *img2 = [UIImage imageNamed:@"camera_bg.png"];
    UIImage *img = [UIImage imageNamed:@"camera1.png"];
    NSData *data1 = UIImagePNGRepresentation(self.imgView_GoalPicture.image);
    NSData *data2 = UIImagePNGRepresentation(img2);
    
    if ([self.imgView_GoalPicture.image isEqual:img] || [self.imgView_GoalPicture.image isEqual:img2] || [data1 isEqual:data2])
    {
        self.lbl_add_photo.hidden = false;
        self.imgView_GoalPicture.image = img;
    }
    else 
    {
        self.lbl_add_photo.hidden = true;
    }

   
}

#pragma mark - All User Defined Functions


#pragma mark - Custom Accessors

- (NSManagedObjectContext *)editingContext {
    if (!_editingContext)
    {
        _editingContext = [NSManagedObjectContext MR_defaultContext];
    }
    
    return _editingContext;
}

- (void)setCurrentGoal:(Goal *)aGoal{
    
    if (aGoal.managedObjectContext != self.editingContext)
    {
        aGoal = (id)[self.editingContext objectWithID:[aGoal objectID]];
    }
    if (_currentGoal != aGoal)
    {
        _currentGoal = aGoal;
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

-(IBAction)action_SaveGoal:(id)sender
{
    if (self.imgView_GoalPicture == nil)
    {
        NSString *str_AlertText = [[NSString alloc]init];
        str_AlertText = [NSString stringWithFormat:NSLocalizedString(@"Please select picture", nil)];
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Goal", nil) message:str_AlertText delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    }
    else if ([self.txt_TitleOfGoal.text length]<1)
    {
        NSString *str_AlertText = [[NSString alloc]init];
        str_AlertText = [NSString stringWithFormat:NSLocalizedString(@"Please enter title of goal", nil)];
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Goal", nil) message:str_AlertText delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    }
    else if ([self.txt_GoalAmount.text length]<1)
    {
        NSString *str_AlertText = [[NSString alloc]init];
        str_AlertText = [NSString stringWithFormat:NSLocalizedString(@"Please enter amount of goal", nil)];
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Goal", nil) message:str_AlertText delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    }
    else if ([self.lbl_Currency.text length]<1)
    {
        NSString *str_AlertText = [[NSString alloc]init];
        str_AlertText = [NSString stringWithFormat:NSLocalizedString(@"Please select currency of goal", nil)];
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Goal", nil) message:str_AlertText delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    }
    else if ([self.str_PlannedSavingFrequency length]<=1)
    {
        NSString *str_AlertText = [[NSString alloc]init];
        str_AlertText = [NSString stringWithFormat:NSLocalizedString(@"Please select planned savings frequency", nil)];
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Goal", nil) message:str_AlertText delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [self action_AddGoal];
    }
}

-(void)action_AddGoal
{
    if ([self.str_PlannedSavingFrequency isEqualToString:@"Not Planned"])
    {
        self.str_ReminderTime = @"";
        self.str_ReminderDate = @"";
        self.lbl_WeeklyReminderDay.text = @"";
    }
    else
    {
        if ([self.str_SetSavingReminder isEqualToString:@"YES"])
        {
            if ([self.str_PlannedSavingFrequency isEqualToString:@"Daily"])
            {
                NSLog(@"%@",self.str_ReminderTime);
                self.str_ReminderDate = @"";
                self.lbl_WeeklyReminderDay.text = @"";
            }
            else if ([self.str_PlannedSavingFrequency isEqualToString:@"Weekly"] || [self.str_PlannedSavingFrequency isEqualToString:@"Bi-weekly"])
            {
                NSLog(@"%@",self.str_ReminderTime);
                self.str_ReminderDate = @"";
                
                
            }
            else if ([self.str_PlannedSavingFrequency isEqualToString:@"Monthly"])
            {
                NSLog(@"%@",self.str_ReminderTime);
                NSLog(@"%@",self.str_ReminderDate);
                
                int int_Date = [self.str_ReminderDate intValue];
                
                self.str_ReminderDate = [NSString stringWithFormat:@"%02d",int_Date];
                NSLog(@"%@",self.str_ReminderDate);
                self.lbl_WeeklyReminderDay.text = @"";
            }
        }
        else
        {
            self.str_ReminderTime = @"";
            self.str_ReminderDate = @"";
            self.lbl_WeeklyReminderDay.text = @"";
        }
    }
    NSLog(@"%@",self.str_TargetDate);
    self.currentGoal.g_title = self.txt_TitleOfGoal.text;
    
    
    NSString *str_balance = self.txt_GoalAmount.text;
    str_balance=[str_balance stringByReplacingOccurrencesOfString:@"," withString:@"."];
    
    if ([self.imgView_GoalPicture.image isEqual:[UIImage imageNamed:@"camera1.png"]])
    {
        self.currentGoal.g_picture = nil;
    }
    else
    {
        self.currentGoal.g_picture = UIImageJPEGRepresentation(self.imgView_GoalPicture.image, 1.0);
    }
    
    self.currentGoal.g_amount = str_balance;
    self.currentGoal.g_currency = self.lbl_Currency.text;
    self.currentGoal.g_targetdate = self.str_TargetDate;
    
    if ([self.txt_SavingsAccount.text length]<=1)
    {
        self.currentGoal.g_savingaccount = @"";
    }
    else
    {
        self.currentGoal.g_savingaccount = self.txt_SavingsAccount.text;
    }
    
    self.currentGoal.g_savingfrequency = self.str_PlannedSavingFrequency;
    self.currentGoal.g_setsavingreminder = self.str_SetSavingReminder;
    self.currentGoal.g_reminderday = self.lbl_WeeklyReminderDay.text;
    self.currentGoal.g_remindertime = self.str_ReminderTime;
    self.currentGoal.g_reminderdate = self.str_ReminderDate;
    
    id a = _currentGoal.objectID;
    NSPredicate *m = [NSPredicate predicateWithFormat:@"(r_goal == %@)",a];
    
    NSMutableArray *muary_TotalOfContribution = [[NSMutableArray alloc]init];
    [muary_TotalOfContribution addObjectsFromArray:[Contribution MR_findAllWithPredicate:m]];
    
    double ContributionTotal = 0.0;
    for (int i = 0; i<muary_TotalOfContribution.count; i++)
    {
        Contribution *GoalContribution = [muary_TotalOfContribution objectAtIndex:i];
        ContributionTotal += [GoalContribution.c_amount doubleValue];
    }
    
    
    if (ContributionTotal >= [self.currentGoal.g_amount doubleValue])
    {
        self.currentGoal.g_completedstatus = @"Completed";
    }
    else
    {
        self.currentGoal.g_completedstatus = @"Not Completed";
    }
    
    [self.editingContext MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
        if (!error)
        {
            
            
            
            if ([self.currentGoal.g_completedstatus isEqualToString:@"Not Completed"])
            {
                if ([self.str_PlannedFrequencyChanged isEqualToString:@"1"]) {
                    
                    NSString *str_ObjectID = [NSString stringWithFormat:@"%@",self.currentGoal.objectID];
                    [Scheduale_Event CancelExistingNotification:str_ObjectID];
                    
                    if ([self.str_SetSavingReminder isEqualToString:@"YES"])
                    {
                        
                        if ([self.str_PlannedSavingFrequency isEqualToString:@"Daily"])
                        {
                            NSDate *currentDate = [[NSDate alloc] init];
                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                            NSString *localDateString = [dateFormatter stringFromDate:currentDate];
                            
                            NSString *str_DateAndTime = [NSString stringWithFormat:@"%@ %@:00",localDateString,self.str_ReminderTime];
                            
                            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                            NSDate *date_DateAndTime = [dateFormatter dateFromString:str_DateAndTime];
                            
                            NSString *str_Add = [NSString stringWithFormat:NSLocalizedString(@"add Daily contribution to goal", nil)];
                            
                            NSString *str_Message = [NSString stringWithFormat:@"%@ \"%@\"",str_Add,self.txt_TitleOfGoal.text];
                            
                            [Scheduale_Event scheduleLocalNotificationWithDate:date_DateAndTime atIndex:str_ObjectID Description:str_Message repeat:@"Daily"];
                        }
                        else if ([self.str_PlannedSavingFrequency isEqualToString:@"Weekly"])
                        {
                            //                        NSDate *today = [NSDate date];
                            //                        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                            //                        [gregorian setLocale:[NSLocale currentLocale]];
                            //                        NSDateComponents *nowComponents = [gregorian components:NSYearCalendarUnit | NSWeekCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit fromDate:today];
                            //                        NSInteger weekday = [nowComponents weekday];
                            //
                            //                        [nowComponents setWeekday:integer_SelectedReminderDay]; //Monday
                            //                        if (weekday > integer_SelectedReminderDay)
                            //                        {
                            //                            [nowComponents setWeek: [nowComponents week]+1];
                            //                        }
                            //                        else
                            //                        {
                            //                            [nowComponents setWeek: [nowComponents week]];
                            //                        }
                            //                        NSDate *beginningOfWeek = [gregorian dateFromComponents:nowComponents];
                            
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
                            NSString *str_DateAndTime = [NSString stringWithFormat:@"%@ %@:00",localDateString,self.str_ReminderTime];
                            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                            NSDate *date_DateAndTime = [dateFormatter dateFromString:str_DateAndTime];
                            NSLog(@"%@",date_DateAndTime);
                            
                            NSString *str_Add = [NSString stringWithFormat:NSLocalizedString(@"add Weekly contribution to goal", nil)];
                            
                            NSString *str_Message = [NSString stringWithFormat:@"%@ \"%@\"",str_Add,self.txt_TitleOfGoal.text];
                            
                            [Scheduale_Event scheduleLocalNotificationWithDate:date_DateAndTime atIndex:str_ObjectID Description:str_Message repeat:@"Weekly"];
                        }
                        else if ([self.str_PlannedSavingFrequency isEqualToString:@"Bi-weekly"])
                        {
                            //                        NSDate *today = [NSDate date];
                            //                        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                            //                        [gregorian setLocale:[NSLocale currentLocale]];
                            //                        NSDateComponents *nowComponents = [gregorian components:NSYearCalendarUnit | NSWeekCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit fromDate:today];
                            //                        NSInteger weekday = [nowComponents weekday];
                            //                        [nowComponents setWeekday:integer_SelectedReminderDay]; //Monday
                            //                        if (weekday > integer_SelectedReminderDay)
                            //                        {
                            //                            [nowComponents setWeek: [nowComponents week]+2];
                            //                        }
                            //                        else
                            //                        {
                            //                            [nowComponents setWeek: [nowComponents week]];
                            //                        }
                            //                        NSDate *beginningOfWeek = [gregorian dateFromComponents:nowComponents];
                            //
                            //                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                            //                            NSDate *today = [NSDate date];
                            //                            NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                            //                            [gregorian setLocale:[NSLocale currentLocale]];
                            //                            NSDateComponents *nowComponents = [gregorian components:NSCalendarUnitYear | NSCalendarUnitWeekOfYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday fromDate:today];
                            //
                            //                            NSInteger weekday = [nowComponents weekday];
                            //                            //NSLog(@"%ld",(long)weekday) ;
                            //                            [nowComponents setWeekday:integer_SelectedReminderDay]; //Monday
                            //                            if (weekday >= integer_SelectedReminderDay)
                            //                            {
                            //                                [nowComponents setWeekOfYear:[nowComponents weekOfYear]+2];
                            //                                //[nowComponents setWeek: [nowComponents week]+1];
                            //                            }
                            //                            else
                            //                            {
                            //                                [nowComponents setWeekOfYear:[nowComponents weekOfYear]+1];
                            //                            }
                            //                            NSDate *beginningOfWeek = [gregorian dateFromComponents:nowComponents];
                            //
                            //                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                            //                            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                            //                            NSString *localDateString = [dateFormatter stringFromDate:beginningOfWeek];
                            //                            NSString *str_DateAndTime = [NSString stringWithFormat:@"%@ %@:00",localDateString,self.str_ReminderTime];
                            //                            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                            //                            NSDate *date_DateAndTime = [dateFormatter dateFromString:str_DateAndTime];
                            //                            NSLog(@"%@",date_DateAndTime);
                            //
                            //                            NSString *str_Add = [NSString stringWithFormat:NSLocalizedString(@"add Bi-weekly contribution to goal", nil)];
                            //
                            //                            NSString *str_Message = [NSString stringWithFormat:@"%@ \"%@\"",str_Add,self.txt_TitleOfGoal.text];
                            //
                            //                            [Scheduale_Event scheduleLocalNotificationWithDate:date_DateAndTime atIndex:str_ObjectID Description:str_Message repeat:@"Bi-weekly"];
                            
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
                            NSString *str_DateAndTime = [NSString stringWithFormat:@"%@ %@:00",localDateString,self.str_ReminderTime];
                            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                            NSDate *date_DateAndTime = [dateFormatter dateFromString:str_DateAndTime];
                            NSLog(@"%@",date_DateAndTime);
                            
                            NSString *str_Add = [NSString stringWithFormat:NSLocalizedString(@"add Weekly contribution to goal", nil)];
                            
                            NSString *str_Message = [NSString stringWithFormat:@"%@ \"%@\"",str_Add,self.txt_TitleOfGoal.text];
                            
                            [Scheduale_Event scheduleLocalNotificationWithDate:date_DateAndTime atIndex:str_ObjectID Description:str_Message repeat:@"Weekly"];
                            
                        }
                        else if ([self.str_PlannedSavingFrequency isEqualToString:@"Monthly"])
                        {
                            NSDate *today = [NSDate date];
                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                            [dateFormatter setDateFormat:@"yyyy-MM"];
                            NSString *localDateString = [dateFormatter stringFromDate:today];
                            
                            NSString *str_SelectedFullDate = [NSString stringWithFormat:@"%@-%@",localDateString,self.str_ReminderDate];
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
                                
                                NSString *str_SelectedFullDate = [NSString stringWithFormat:@"%ld-%02ld-%@",Year,Month1,self.str_ReminderDate];
                                //NSLog(@"%@",str_SelectedFullDate);
                                
                                NSString *str_DateAndTime = [NSString stringWithFormat:@"%@ %@:00",str_SelectedFullDate,self.str_ReminderTime];
                                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                                NSDate *date_DateAndTime = [dateFormatter dateFromString:str_DateAndTime];
                                //NSLog(@"%@",date_DateAndTime);
                                
                                NSString *str_Add = [NSString stringWithFormat:NSLocalizedString(@"add Monthly contribution to goal", nil)];
                                
                                NSString *str_Message = [NSString stringWithFormat:@"%@ \"%@\"",str_Add,self.txt_TitleOfGoal.text];
                                
                                [Scheduale_Event scheduleLocalNotificationWithDate:date_DateAndTime atIndex:str_ObjectID Description:str_Message repeat:@"Monthly"];
                                
                            }
                            else
                            {
                                NSString *str_DateAndTime = [NSString stringWithFormat:@"%@ %@:00",str_SelectedFullDate,self.str_ReminderTime];
                                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                                NSDate *date_DateAndTime = [dateFormatter dateFromString:str_DateAndTime];
                                //NSLog(@"%@",date_DateAndTime);
                                NSString *str_Add = [NSString stringWithFormat:NSLocalizedString(@"add Monthly contribution to goal", nil)];
                                
                                NSString *str_Message = [NSString stringWithFormat:@"%@ \"%@\"",str_Add,self.txt_TitleOfGoal.text];
                                
                                [Scheduale_Event scheduleLocalNotificationWithDate:date_DateAndTime atIndex:str_ObjectID Description:str_Message repeat:@"Monthly"];
                            }
                        }
                    }
                }
                else{
                    
                }
                
                
                [self.navigationController popViewControllerAnimated:YES];
            }
            else{
                NSString *str_ObjectID = [NSString stringWithFormat:@"%@",self.currentGoal.objectID];
                [Scheduale_Event CancelExistingNotification:str_ObjectID];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert", nil) message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
    
    
}

-(IBAction)action_SelectDateMonthly:(id)sender{
    self.view_Sahdow.hidden = FALSE;
    self.view_SetDateMonthly.hidden = FALSE;
}
-(IBAction)action_CancelPickerView:(UIButton *)sender
{
    self.view_Sahdow.hidden = TRUE;
    self.view_SetDateMonthly.hidden = TRUE;
}

-(IBAction)action_DonePickerView:(UIButton *)sender
{
    NSInteger iii = [self.pickerView_ReminderDateMonthly selectedRowInComponent:0];
    self.str_ReminderDate =[NSString stringWithFormat:@"%@",[self.muary_ReminderDates objectAtIndex:iii]];
    
    self.lbl_MonthlyReminderDate.text = self.str_ReminderDate;
    if ([self.language isEqualToString:@"zh-Hans"]) {
        self.lbl_MonthlyReminderDate.text = [NSString stringWithFormat:@"%@ 日",self.str_ReminderDate];
        
    }
    self.view_Sahdow.hidden = TRUE;
    self.view_SetDateMonthly.hidden = TRUE;
}

-(IBAction)action_SelectDate:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (sender.tag == 1)
    {
        self.datePicker_Date.datePickerMode = UIDatePickerModeDate;
        self.btn_DoneDatePicker.tag = 1;
        
        if ([self.language isEqualToString:@"zh-Hans"]) {
            
            NSLog(@"%@",self.str_TargetDate);
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            
            [dateFormatter setDateFormat:@"yyyy年M月d日'"];
            self.datePicker_Date.date = [dateFormatter dateFromString:self.lbl_TargetDate.text];
        }
        else{
            NSDateFormatter *df_TargetDate = [[NSDateFormatter alloc] init];
            [df_TargetDate setDateFormat:@"MMM dd, yyyy"];
            self.datePicker_Date.date = [df_TargetDate dateFromString:self.lbl_TargetDate.text];
        }
    }
    else if (sender.tag == 2)
    {
        self.datePicker_Date.datePickerMode = UIDatePickerModeTime;
        self.btn_DoneDatePicker.tag = 2;
        if ([self.lbl_DailyRemindMe.text length]>0)
        {
            NSDateFormatter *df_TargetTime = [[NSDateFormatter alloc] init];
            [df_TargetTime setDateFormat:@"HH:mm"];
            self.datePicker_Date.date = [df_TargetTime dateFromString:self.lbl_DailyRemindMe.text];
        }
    }
    else if (sender.tag == 3)
    {
        self.datePicker_Date.datePickerMode = UIDatePickerModeTime;
        self.btn_DoneDatePicker.tag = 3;
        if ([self.lbl_WeeklyRemindeMe.text length]>0)
        {
            NSDateFormatter *df_TargetTime = [[NSDateFormatter alloc] init];
            [df_TargetTime setDateFormat:@"HH:mm"];
            self.datePicker_Date.date = [df_TargetTime dateFromString:self.lbl_WeeklyRemindeMe.text];
        }
    }
    else if (sender.tag == 4)
    {
        self.datePicker_Date.datePickerMode = UIDatePickerModeTime;
        self.btn_DoneDatePicker.tag = 4;
        if ([self.lbl_MonthlyRemindeMe.text length]>0)
        {
            NSDateFormatter *df_TargetTime = [[NSDateFormatter alloc] init];
            [df_TargetTime setDateFormat:@"HH:mm"];
            self.datePicker_Date.date = [df_TargetTime dateFromString:self.lbl_MonthlyRemindeMe.text];
        }
    }
    self.view_Sahdow.hidden = FALSE;
    self.view_SetDate.hidden = FALSE;
    
}

-(IBAction)action_DoneDatePicker:(UIButton *)sender
{
    if (sender.tag == 1)
    {
        NSDateFormatter *df_TargetDate = [[NSDateFormatter alloc] init];
        [df_TargetDate setDateFormat:@"MMM dd, yyyy"];
        self.lbl_TargetDate.text = [NSString stringWithFormat:@"%@",[df_TargetDate stringFromDate:self.datePicker_Date.date]];
        
        NSDateFormatter *df_TargetDate1 = [[NSDateFormatter alloc] init];
        [df_TargetDate1 setDateFormat:@"yyyy-MM-dd"];
        self.str_TargetDate = [NSString stringWithFormat:@"%@",
                               [df_TargetDate1 stringFromDate:self.datePicker_Date.date]];
        
        if ([self.language isEqualToString:@"zh-Hans"]) {
            
            NSLog(@"%@",self.str_TargetDate);
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            
            [dateFormatter setDateFormat:@"yyyy年M月d日'"];
            NSString *localDateString = [dateFormatter stringFromDate:self.datePicker_Date.date];
            self.lbl_TargetDate.text = [NSString stringWithFormat:@"%@",localDateString];
            NSLog(@"%@",localDateString);
        }
    }
    else if (sender.tag == 2)
    {
        NSDateFormatter *df_TargetTime = [[NSDateFormatter alloc] init];
        [df_TargetTime setDateFormat:@"HH:mm"];
        self.str_ReminderTime = [NSString stringWithFormat:@"%@",
                                 [df_TargetTime stringFromDate:self.datePicker_Date.date]];
        
        self.lbl_DailyRemindMe.text = self.str_ReminderTime;
        self.str_ReminderDate = @"";
        
    }
    else if (sender.tag == 3)
    {
        NSDateFormatter *df_TargetTime = [[NSDateFormatter alloc] init];
        [df_TargetTime setDateFormat:@"HH:mm"];
        self.str_ReminderTime = [NSString stringWithFormat:@"%@",
                                 [df_TargetTime stringFromDate:self.datePicker_Date.date]];
        
        self.lbl_WeeklyRemindeMe.text = self.str_ReminderTime;
        self.str_ReminderDate = @"";
    }
    else if (sender.tag == 4)
    {
        NSDateFormatter *df_TargetTime = [[NSDateFormatter alloc] init];
        [df_TargetTime setDateFormat:@"HH:mm"];
        self.str_ReminderTime = [NSString stringWithFormat:@"%@",
                                 [df_TargetTime stringFromDate:self.datePicker_Date.date]];
        
        self.lbl_MonthlyRemindeMe.text = self.str_ReminderTime;
        self.str_ReminderDate = @"";
    }
    
    self.view_SetDate.hidden = TRUE;
    self.view_Sahdow.hidden = TRUE;
}

-(IBAction)action_CancelDatePicker:(UIButton *)sender
{
    self.view_SetDate.hidden = TRUE;
    self.view_Sahdow.hidden = TRUE;
}


-(IBAction)action_SelectFrequency:(id)sender
{
    [self.view endEditing:YES];
    NSString *str_NotPlanned = [NSString stringWithFormat:NSLocalizedString(@"Not Planned", nil)];
    NSString *str_Daily = [NSString stringWithFormat:NSLocalizedString(@"Daily", nil)];
    NSString *str_Weekly = [NSString stringWithFormat:NSLocalizedString(@"Weekly", nil)];
    
    NSString *str_Monthly = [NSString stringWithFormat:NSLocalizedString(@"Monthly", nil)];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Pick a Frequency:", nil)
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"CANCEL", nil)
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:str_NotPlanned, str_Daily, str_Weekly, str_Monthly, nil];
    actionSheet.tag = 1;
    [actionSheet showInView:self.view];
}

-(IBAction)action_SelectWeekDays:(id)sender
{
    [self.view endEditing:YES];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Pick a week day:", nil)
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"CANCEL", nil)
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:self.str_Monday, self.str_Tuesday,self.str_Wednesday, self.str_Thursday, self.str_Friday,self.str_Saturday,self.str_Sunday, nil];
    actionSheet.tag = 2;
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1 ) {
        
        if (buttonIndex != 5) {
            self.datePicker_Date.datePickerMode = UIDatePickerModeTime;
            self.datePicker_Date.date = [NSDate date];
            NSDateFormatter *df_TargetTime = [[NSDateFormatter alloc] init];
            [df_TargetTime setDateFormat:@"HH:mm"];
            self.str_ReminderTime = [NSString stringWithFormat:@"%@",
                                     [df_TargetTime stringFromDate:self.datePicker_Date.date]];
            
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd"];
            // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
            NSString *str_Current_Date = [[NSString alloc]init];
            str_Current_Date = [dateFormatter stringFromDate:[NSDate date]];
            NSLog(@"%@",str_Current_Date);
            
            NSInteger weekday = [[NSCalendar currentCalendar] component:NSCalendarUnitWeekday
                                                               fromDate:[NSDate date]];
            
            if (buttonIndex == 0) {
                self.str_PlannedSavingFrequency = @"Not Planned";
            }
            else if (buttonIndex == 1) {
                self.str_PlannedSavingFrequency = @"Daily";
                self.lbl_DailyRemindMe.text = self.str_ReminderTime;
            }
            else if (buttonIndex == 2) {
                self.str_PlannedSavingFrequency = @"Weekly";
                self.lbl_WeeklyRemindeMe.text = self.str_ReminderTime;
                self.lbl_WeeklyReminderDay.text = [NSString stringWithFormat:NSLocalizedString(@"Monday", nil)];
            }
            else if (buttonIndex == 3)
            {
                self.str_PlannedSavingFrequency = @"Monthly";
                self.lbl_MonthlyRemindeMe.text = self.str_ReminderTime;
                self.lbl_MonthlyReminderDate.text = self.str_ReminderDate;
                
                if ([self.language isEqualToString:@"zh-Hans"])
                {
                    self.lbl_MonthlyReminderDate.text = [NSString stringWithFormat:@"%@ 日",self.str_ReminderDate];
                    
                }
            }
            
            self.lbl_SavingFrequency.text = [actionSheet buttonTitleAtIndex:buttonIndex];
            
            if (weekday == 1)
            {
                self.lbl_WeeklyReminderDay.text = self.str_Sunday;
            }
            else if (weekday == 2)
            {
                self.lbl_WeeklyReminderDay.text = self.str_Monday;
            }
            else if (weekday == 3)
            {
                self.lbl_WeeklyReminderDay.text = self.str_Tuesday;
            }
            else if (weekday == 4)
            {
                self.lbl_WeeklyReminderDay.text = self.str_Wednesday;
            }
            else if (weekday == 5)
            {
                self.lbl_WeeklyReminderDay.text = self.str_Thursday;
            }
            else if (weekday == 6)
            {
                self.lbl_WeeklyReminderDay.text = self.str_Friday;
            }
            else if (weekday == 7)
            {
                self.lbl_WeeklyReminderDay.text = self.str_Saturday;
            }
            
            integer_SelectedReminderDay = weekday;
            
            NSLog(@"The Normal action sheet.");
            self.lbl_SavingFrequency.text = [actionSheet buttonTitleAtIndex:buttonIndex];
            
            if ([self.str_SetSavingReminder isEqualToString:@"YES"])
            {
                
                if ([self.str_PlannedSavingFrequency isEqualToString:@"Daily"])
                {
                    self.view_SetReminderDaily.hidden = FALSE;
                    self.view_SetReminderWeekly.hidden = TRUE;
                    self.view_SetReminderMonthly.hidden = TRUE;
                    self.scroll_AddGoal.contentSize = CGSizeMake(0, 727);
                    self.btn_delete.frame = CGRectMake(self.btn_delete.frame.origin.x, 625, self.btn_delete.frame.size.width, self.btn_delete.frame.size.height);
                    
                    
                }
                else if ([self.str_PlannedSavingFrequency isEqualToString:@"Weekly"] || [self.str_PlannedSavingFrequency isEqualToString:@"Bi-weekly"])
                {
                    self.view_SetReminderDaily.hidden = TRUE;
                    self.view_SetReminderWeekly.hidden = FALSE;
                    self.view_SetReminderMonthly.hidden = TRUE;
                    self.scroll_AddGoal.contentSize = CGSizeMake(0, 727);
                      self.btn_delete.frame = CGRectMake(self.btn_delete.frame.origin.x, 678, self.btn_delete.frame.size.width, self.btn_delete.frame.size.height);
                    
                }
                else if ([self.str_PlannedSavingFrequency isEqualToString:@"Monthly"])
                {
                    self.view_SetReminderDaily.hidden = TRUE;
                    self.view_SetReminderWeekly.hidden = TRUE;
                    self.view_SetReminderMonthly.hidden = FALSE;
                    self.scroll_AddGoal.contentSize = CGSizeMake(0, 727);
                      self.btn_delete.frame = CGRectMake(self.btn_delete.frame.origin.x, 678, self.btn_delete.frame.size.width, self.btn_delete.frame.size.height);
                    
                }
                else if ([self.str_PlannedSavingFrequency isEqualToString:@"Not Planned"])
                {
                    self.view_SetReminderDaily.hidden = TRUE;
                    self.view_SetReminderWeekly.hidden = TRUE;
                    self.view_SetReminderMonthly.hidden = TRUE;
                    
                    self.str_SetSavingReminder = @"NO";
                    [self.switch_SetReminder setOn:FALSE];
                    self.scroll_AddGoal.contentSize = CGSizeMake(0, 727);
                      self.btn_delete.frame = CGRectMake(self.btn_delete.frame.origin.x, 578, self.btn_delete.frame.size.width, self.btn_delete.frame.size.height);
                }
            }
            self.str_PlannedFrequencyChanged = @"1";
        }
        
        
    }
    else{
        
        if (buttonIndex != 7)
        {
            if (buttonIndex != 7) {
                if (buttonIndex == 0)
                {
                    self.lbl_WeeklyReminderDay.text = self.str_Monday;
                }
                else if (buttonIndex == 1)
                {
                    self.lbl_WeeklyReminderDay.text = self.str_Tuesday;
                }
                else if (buttonIndex == 2)
                {
                    self.lbl_WeeklyReminderDay.text = self.str_Wednesday;
                }
                else if (buttonIndex == 3)
                {
                    self.lbl_WeeklyReminderDay.text = self.str_Thursday;
                }
                else if (buttonIndex == 4)
                {
                    self.lbl_WeeklyReminderDay.text = self.str_Friday;
                }
                else if (buttonIndex == 5)
                {
                    self.lbl_WeeklyReminderDay.text = self.str_Saturday;
                }
                else if (buttonIndex == 6)
                {
                    self.lbl_WeeklyReminderDay.text = self.str_Sunday;
                }
                
                
                
                
                if (buttonIndex == 6)
                {
                    integer_SelectedReminderDay = 1;
                }
                else
                {
                    integer_SelectedReminderDay = buttonIndex+2;
                }
            }
            self.str_PlannedFrequencyChanged = @"1";
        }
        
        
    }
    NSLog(@"Index = %ld - Title = %@", (long)buttonIndex, [actionSheet buttonTitleAtIndex:buttonIndex]);
}

-(IBAction)action_SelectPicture:(id)sender
{
    [self.view endEditing:YES];
    NSString *str_PredefinedIcon = [NSString stringWithFormat:NSLocalizedString(@"Predefined Icons", nil)];
    
    NSString *str_Album = [NSString stringWithFormat:NSLocalizedString(@"Album", nil)];
    
    NSString *str_AlertTitle = [NSString stringWithFormat:NSLocalizedString(@"Select Photo!", nil)];
    
    UIAlertView *alert_action = [[UIAlertView alloc] initWithTitle:str_AlertTitle message:nil delegate:self cancelButtonTitle:CANCEL1 otherButtonTitles:str_PredefinedIcon, str_Album, nil];
    alert_action.tag = 101;
    [alert_action show];
}

-(IBAction)action_SelectCurrency:(id)sender
{
    [self.view endEditing:YES];
    isEdit = TRUE;
    Currency_ViewController *obj_Currency_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"Currency_ViewController"];
    
    [self.navigationController pushViewController:obj_Currency_ViewController animated:YES];
}

-(void)action_SetReminder
{
    self.scroll_AddGoal.contentSize = CGSizeMake(0, 727);
    self.datePicker_Date.datePickerMode = UIDatePickerModeTime;
    self.datePicker_Date.date = [NSDate date];
    NSDateFormatter *df_TargetTime = [[NSDateFormatter alloc] init];
    [df_TargetTime setDateFormat:@"HH:mm"];
    self.str_ReminderTime = [NSString stringWithFormat:@"%@",
                             [df_TargetTime stringFromDate:self.datePicker_Date.date]];
    
    if ([self.str_PlannedSavingFrequency isEqualToString:@"Daily"])
    {
        if ([self.lbl_DailyRemindMe.text length]<1) {
            self.lbl_DailyRemindMe.text = self.str_ReminderTime;
        }
        
        self.view_SetReminderDaily.hidden = FALSE;
        self.view_SetReminderWeekly.hidden = TRUE;
        self.view_SetReminderMonthly.hidden = TRUE;
        self.btn_delete.frame = CGRectMake(self.btn_delete.frame.origin.x, 625, self.btn_delete.frame.size.width, self.btn_delete.frame.size.height);
    }
    else if ([self.str_PlannedSavingFrequency isEqualToString:@"Weekly"] || [self.str_PlannedSavingFrequency isEqualToString:@"Bi-weekly"])
    {
        if ([self.lbl_WeeklyRemindeMe.text length]<1 || [self.lbl_WeeklyReminderDay.text length]<1) {
            self.lbl_WeeklyRemindeMe.text = self.str_ReminderTime;
            self.lbl_WeeklyReminderDay.text = [NSString stringWithFormat:NSLocalizedString(@"Monday", nil)];
        }
        
        self.view_SetReminderDaily.hidden = TRUE;
        self.view_SetReminderWeekly.hidden = FALSE;
        self.view_SetReminderMonthly.hidden = TRUE;
         self.btn_delete.frame = CGRectMake(self.btn_delete.frame.origin.x, 678, self.btn_delete.frame.size.width, self.btn_delete.frame.size.height);
    }
    else if ([self.str_PlannedSavingFrequency isEqualToString:@"Monthly"])
    {
        if ([self.lbl_MonthlyRemindeMe.text length]<1 || [self.lbl_MonthlyReminderDate.text length]<1) {
            self.lbl_MonthlyRemindeMe.text = self.str_ReminderTime;
            self.lbl_MonthlyReminderDate.text = self.str_ReminderDate;
            if ([self.language isEqualToString:@"zh-Hans"]) {
                self.lbl_MonthlyReminderDate.text = [NSString stringWithFormat:@"%@ 日",self.str_ReminderDate];
                
            }
        }
        
        self.view_SetReminderDaily.hidden = TRUE;
        self.view_SetReminderWeekly.hidden = TRUE;
        self.view_SetReminderMonthly.hidden = FALSE;
        self.btn_delete.frame =  CGRectMake(self.btn_delete.frame.origin.x,678, self.btn_delete.frame.size.width, self.btn_delete.frame.size.height);
    }
    
    self.lbl_Line.hidden = TRUE;
    self.str_SetSavingReminder = @"YES";
    [self.switch_SetReminder setOn:TRUE];
}

-(IBAction)action_SetReminder:(id)sender
{
    if ([self.str_SetSavingReminder isEqualToString:@"NO"])
    {
        if ([self.lbl_SavingFrequency.text isEqualToString:NSLocalizedString(@"Not Planned", nil)])
        {
            
            if (self.switch_SetReminder.isOn == TRUE)
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert", nil) message:NSLocalizedString(@"Please select saving frequency first!", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
                self.lbl_Line.hidden = FALSE;
                [self.switch_SetReminder setOn:FALSE];
                return;
            }
            return;
        }
        
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(currentUserNotificationSettings)]){ // Check it's iOS 8 and above
            UIUserNotificationSettings *grantedSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
            
            if (self.switch_SetReminder.isOn == TRUE)
            {
                if (grantedSettings.types == UIUserNotificationTypeNone)
                {
                    if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"LocalNotifAsked"] isEqualToString:@"1"]) {
                        NSString *str_AlertTitle = [NSString stringWithFormat:NSLocalizedString(@"Money Box", nil)];
                        NSString *str_AlertText = [NSString stringWithFormat:NSLocalizedString(@"Notification are disallowed please make it enable from iphone's settings", nil)];
                        
                        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:str_AlertTitle message:str_AlertText delegate:self cancelButtonTitle:NSLocalizedString(@"Later", nil) otherButtonTitles:NSLocalizedString(@"Yes, Please", nil),nil];
                        alert.tag = 213;
                        [alert show];
                    }
                    else{
                        [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"LocalNotifAsked"];
                        
                        if ([[UIApplication sharedApplication]respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
                        {
                            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
                            
                            [[UIApplication sharedApplication] registerForRemoteNotifications];
                        }
                        else
                        {
                            [[UIApplication sharedApplication] registerForRemoteNotifications];
                        }
//                        NSString *str_AlertTitle = [NSString stringWithFormat:NSLocalizedString(@"Money Box", nil)];
//                        NSString *str_AlertText = [NSString stringWithFormat:NSLocalizedString(@"Money Box needs your permission to remind you about your saving goals and payments. This will help you achieve your savings goals faster. Do you want it to remind you next time?", nil)];
//
//                        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:str_AlertTitle message:str_AlertText delegate:self cancelButtonTitle:NSLocalizedString(@"Later", nil) otherButtonTitles:NSLocalizedString(@"Yes, Please", nil),nil];
//                        alert.tag = 212;
//                        [alert show];
                    }
                    self.lbl_Line.hidden = FALSE;
                    [self.switch_SetReminder setOn:FALSE];
                    return;
                }
                else if (grantedSettings.types & UIUserNotificationTypeSound & UIUserNotificationTypeAlert )
                {
                    NSLog(@"Sound and alert permissions ");
                    [self action_SetReminder];
                }
                else if (grantedSettings.types  & UIUserNotificationTypeAlert){
                    NSLog(@"Alert Permission Granted");
                    [self action_SetReminder];
                }
                 //
            }
            
        }
       
    }
    else{
        self.lbl_Line.hidden = FALSE;
        self.scroll_AddGoal.contentSize = CGSizeMake(0, 648);
        self.str_SetSavingReminder = @"NO";
        [self.switch_SetReminder setOn:FALSE];
        self.view_SetReminderDaily.hidden = TRUE;
        self.view_SetReminderMonthly.hidden = TRUE;
        self.view_SetReminderWeekly.hidden = TRUE;
        self.btn_delete.frame = CGRectMake(self.btn_delete.frame.origin.x,578, self.btn_delete.frame.size.width, self.btn_delete.frame.size.height);
    }
    
}


#pragma mark - All Delegate Methods

#pragma mark - Textfield Delegate
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
    if(textField.tag==2)
    {
//        NSRange minusrange = [textField.text rangeOfString:@"-"];
//        
//        NSRange dotrange = [textField.text rangeOfString:@"."];
//        
//        if(textField.text.length==0 && [string isEqualToString:@"."])
//            textField.text=@"0";
//        else if([textField.text isEqualToString:@"-"] && [string isEqualToString:@"."])
//            textField.text=@"-0";
//        
//        if (dotrange.length > 0 && [string isEqualToString:@"."])
//            return NO;
//        else if (textField.text.length==0 && [string isEqualToString:@"-"])
//            return NO;
//        else if (range.location==0 && minusrange.length==0 && [string isEqualToString:@"-"])
//            return YES;
//        else
//        {
//            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890."];
//            for (int i = 0; i < [string length]; i++)
//            {
//                unichar c = [string characterAtIndex:i];
//                if (![myCharSet characterIsMember:c])
//                {
//                    return NO;
//                }
//            }
//        }
//    }
//    
//    return YES;
        NSRange minusrange = [textField.text rangeOfString:@"-"];
        
        NSRange dotrange = [textField.text rangeOfString:@"."];
        NSRange commarange = [textField.text rangeOfString:@","];
        
        //        if(textField.text.length==0 && [string isEqualToString:@"."])
        //            textField.text=@"";
        //        else if([textField.text isEqualToString:@"-"] && [string isEqualToString:@"."])
        //            textField.text=@"";
        
        if (dotrange.length > 0 && [string isEqualToString:@"."])
            return NO;
        else if (commarange.length > 0 && [string isEqualToString:@","])
            return NO;
        else if (textField.text.length==0 && [string isEqualToString:@"0"])
            return NO;
        else if (textField.text.length==0 && [string isEqualToString:@"-"])
            return NO;
        else if (textField.text.length==0 && [string isEqualToString:@"."])
            return NO;
        else if (textField.text.length==0 && [string isEqualToString:@","])
            return NO;
        else if (range.location==0 && minusrange.length==0 && [string isEqualToString:@"-"])
            return YES;

        else
        {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890.,"];
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
    else if (alertView.tag == 101)
    {
        if (buttonIndex == 1)
        {
            PredefinedIcon_ViewController *obj_PredefinedIcon_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"PredefinedIcon_ViewController"];
            
            [self.navigationController pushViewController:obj_PredefinedIcon_ViewController animated:YES];
        }
        else if(buttonIndex == 2)
        {
            isEdit = TRUE;
            UIImagePickerController * picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            picker.delegate = self;
            picker.allowsEditing = NO;
            [self presentViewController:picker animated:YES completion:^{
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            }];
        }
        else if([[alertView buttonTitleAtIndex:buttonIndex]isEqualToString:@"Cancel"])
        {
            //NSLog(@"cancel");
        }
    }
    
    if (alertView.tag == 212)
    {
        if (buttonIndex == 1)
        {
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"LocalNotifAsked"];
            if ([[UIApplication sharedApplication]respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
            {
                [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
                
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
            else
            {
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
            [Localytics tagEvent:@"Clicked on Yes, Please Notification"];
            [Flurry logEvent:@"Clicked on Yes, Please Notification"];
            [FIRAnalytics logEventWithName:@"Clicked_On_Yes_Notifications"
                                parameters:nil];
        }
        else{
            [Localytics tagEvent:@"Clicked on Later Notification"];
            [Flurry logEvent:@"Clicked on Later Notification"];
            [FIRAnalytics logEventWithName:@"Clicked_on_Later_Notification"
                                parameters:nil];
        }
    }
    else if (alertView.tag == 213){
        if (buttonIndex == 1) {
            
            if (UIApplicationOpenSettingsURLString != nil) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication] openURL:url];
            }
            [Localytics tagEvent:@"Clicked on Yes, Please Notification"];
            [Flurry logEvent:@"Clicked on Yes, Please Notification"];
            [FIRAnalytics logEventWithName:@"Clicked_On_Yes_Notifications"
                                parameters:nil];
        }
        else{
            [Localytics tagEvent:@"Clicked on Later Notification"];
            [Flurry logEvent:@"Clicked on Later Notification"];
            [FIRAnalytics logEventWithName:@"Clicked_on_Later_Notification"
                                parameters:nil];
        }
    }
    else if (alertView.tag == 3333)
    {
        if (buttonIndex == 1)
        {
            [self goal_delete];
        }
    }

}

#pragma mark - Picker View Delegates
// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.muary_ReminderDates.count;
}


// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
//    self.str_ReminderDate =[NSString stringWithFormat:@"%@",[self.muary_ReminderDates objectAtIndex:row]];
    return self.muary_ReminderDates[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"%ld",(long)row);
    self.str_ReminderDate =[NSString stringWithFormat:@"%@",[self.muary_ReminderDates objectAtIndex:row]];
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    
    img_GoalLogo = [[UIImage alloc]init];
    img_GoalLogo = image;
    
    [picker dismissViewControllerAnimated:NO completion:^()
     {
         //UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
         
         float Height=320;
         
         float Yax=(self.view.frame.size.height+20-Height)/2;
         
         float Xax=(self.view.frame.size.width-Height)/2;
         
         VPImageCropperViewController *imgCropperVC = [[VPImageCropperViewController alloc] initWithImage:image cropFrame:CGRectMake(Xax, Yax, Height, Height) limitScaleRatio:3.0];
         imgCropperVC.delegate = self;
         imgCropperVC.view.center=self.view.center;
         [self presentViewController:imgCropperVC animated:YES completion:^{
             //TO DO
         }];
     }];
    }


- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)image
{
    [cropperViewController dismissViewControllerAnimated:YES completion:nil];
    
    img_GoalLogo = image;
    [self.imgView_GoalPicture setImage:img_GoalLogo];
    
    [[GoalManagerAppDelegate getdefaultvalue]setObject:@"" forKey:@"perdefone_imagename"];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController
{
    [cropperViewController dismissViewControllerAnimated:YES completion:nil];
}


- (UIImage *)scaleAndRotateImage:(UIImage *)image
{
    int kMaxResolution = 640; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution)
    {
        CGFloat ratio = width/height;
        if (ratio > 1)
        {
            bounds.size.width = kMaxResolution;
            bounds.size.height = roundf(bounds.size.width / ratio);
        }
        else
        {
            bounds.size.height = kMaxResolution;
            bounds.size.width = roundf(bounds.size.height * ratio);
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(IBAction)delete_goal:(id)sender
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Money Box" message:NSLocalizedString(@"Are you sure want to delete this goal?", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"No", nil) otherButtonTitles:NSLocalizedString(@"Yes", nil),nil];
    alert.tag = 3333;
    [alert show];
    
}

-(void)goal_delete
{
    //NSLog(@"%@",delete_Goal);
    
    NSString *str_ObjectID = [NSString stringWithFormat:@"%@",_currentGoal.objectID];
    [Scheduale_Event CancelExistingNotification:str_ObjectID];
    
    [_currentGoal MR_deleteEntity];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
        if (!error)
        {
            [self.navigationController popToRootViewControllerAnimated:true];
        }
        else
        {
            NSString *str_AlertTitle = [[NSString alloc]init];
            str_AlertTitle = [NSString stringWithFormat:NSLocalizedString(@"Goal", nil)];
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:str_AlertTitle message:[error localizedDescription] delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
            [alert show];
        }
    }];
    
}



@end
