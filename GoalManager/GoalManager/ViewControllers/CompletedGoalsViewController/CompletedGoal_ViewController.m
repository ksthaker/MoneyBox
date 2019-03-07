//
//  CompletedGoal_ViewController.m
//  GoalManager
//
//  Created by apple on 11/11/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import "CompletedGoal_ViewController.h"
#import "NSString+FontAwesome.h"
#import "Cell_GoalLists.h"
#import "GoalManagerAppDelegate.h"
#import "GoalOverview_ViewController.h"
#import "GoalManager.h"
#import "Filter_ViewController.h"
#import "UIViewController+KNSemiModal.h"

@interface CompletedGoal_ViewController ()

@end

@implementation CompletedGoal_ViewController


@synthesize btn_AddGoal,btn_Settings;
@synthesize tbl_CompletedGoalLists;
@synthesize lbl_AddGoal,lbl_Settings,lbl_ArrowDown,lbl_TotalForAllActiveGoals;
@synthesize view_Totals,view_InnerTotalForAllActiveGoals;
@synthesize goalList;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize editingContext = _editingContext;

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(action_ViewRefresh) name:@"CompletedGoal_ViewController" object:nil];
    
    self.title = NSLocalizedString(@"Completed Goals", nil);
    
    UIImage* image2 = [UIImage imageNamed:@"navbar_cancel.png"];
    CGRect frameimg2 = CGRectMake(0, 0,22,22);
    UIButton *someButton2 = [[UIButton alloc] initWithFrame:frameimg2];
    [someButton2 setBackgroundImage:image2 forState:UIControlStateNormal];
    [someButton2 addTarget:self action:@selector(action_Close:)
          forControlEvents:UIControlEventTouchUpInside];
    [someButton2 setSelected:YES];
    
    btn_Settings= [[UIBarButtonItem alloc]initWithCustomView:someButton2];
    
    NSArray *arr_AddFilterGoalleft= [[NSArray alloc] initWithObjects:btn_Settings,nil];
    self.navigationItem.leftBarButtonItems = arr_AddFilterGoalleft;
    
    UIImage* image = [UIImage imageNamed:@"navbar_filter.png"];
    CGRect frameimg = CGRectMake(0, 0,22,22);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(action_FilterGoal:) forControlEvents:UIControlEventTouchUpInside];
    [someButton setSelected:YES];
    
    UIBarButtonItem *btn_FilterGoal= [[UIBarButtonItem alloc]initWithCustomView:someButton];
    
    NSArray *arr_AddFilterGoal= [[NSArray alloc] initWithObjects:btn_FilterGoal,nil];
    self.navigationItem.rightBarButtonItems = arr_AddFilterGoal;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = false;
    [Localytics tagEvent:@"List of Completed Goals"];
    
    [Flurry logEvent:@"List of Completed Goals"];
    
    [FIRAnalytics logEventWithName:@"List_of_Completed_Goals"
                        parameters:nil];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [super viewWillAppear:YES];
   
    [[UIApplication sharedApplication]setStatusBarHidden:FALSE];
}



-(void)action_ViewRefresh
{
    _fetchedResultsController = nil;
    [self.tbl_CompletedGoalLists reloadData];
}


#pragma mark - All User Defined Functions
-(IBAction)action_Close:(id)sender
{
    [[UIApplication sharedApplication]setStatusBarHidden:FALSE];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark All Delegates

#pragma mark - Core data functions
- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController )
    {
        NSString *str_Completed = @"Completed";
        
        //NSPredicate *predict_Completed = [NSPredicate predicateWithFormat:@"g_completedstatus == %@",str_Completed];
        
        if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"SortingType"] isEqualToString:@"Alphabetically"])
        {
            NSPredicate *predict_Completed = [NSPredicate predicateWithFormat:@"g_completedstatus == %@",str_Completed];
            _fetchedResultsController = [Goal MR_fetchAllGroupedBy:nil withPredicate:predict_Completed sortedBy:@"g_title" ascending:YES delegate:self];
        }
        else
        {
            NSPredicate *predict_Completed = [NSPredicate predicateWithFormat:@"g_completedstatus == %@",str_Completed];
            _fetchedResultsController = [Goal MR_fetchAllGroupedBy:nil withPredicate:predict_Completed sortedBy:@"g_targetdate" ascending:YES delegate:self];
        }
        //_fetchedResultsController = [Goal MR_fetchAllGroupedBy:nil withPredicate:predict_Completed sortedBy:nil ascending:NO delegate:self];
    }
    
    return _fetchedResultsController;
}

-(IBAction)action_FilterGoal:(id)sender
{
    [self.view endEditing:YES];
    NSString *str_BuDueDate = [NSString stringWithFormat:NSLocalizedString(@"By due date", nil)];
    NSString *str_Alphabetically = [NSString stringWithFormat:NSLocalizedString(@"Alphabetically", nil)];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"CANCEL", nil)
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:str_BuDueDate, str_Alphabetically, nil];
    actionSheet.tag = 1;
    [actionSheet showInView:self.view];
    
//    Filter_ViewController *obj_Filter_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"Filter_ViewController"];
//    obj_Filter_ViewController.str_FromWhere = @"FromCompleted";
//    [self presentSemiViewController:obj_Filter_ViewController withOptions:@{KNSemiModalOptionKeys.pushParentBack : @(NO),KNSemiModalOptionKeys.parentAlpha : @(1.0),KNSemiModalOptionKeys.animationDuration:@(0.2)}];
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
    return numberOfRows*2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row %2==0)
    {
        static NSString *simpleTableIdentifier = @"Cell_GoalLists";
        Cell_GoalLists *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row/2 inSection:indexPath.section];
        Goal *GoalDescription = [self.fetchedResultsController objectAtIndexPath:index];
        
        cell.lbl_Title.text = GoalDescription.g_title;
        
        cell.view_MainShadow.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        cell.view_MainShadow.layer.shadowOpacity = 1.0;
        cell.view_MainShadow.layer.shadowOffset = CGSizeZero;
        cell.view_MainShadow.layer.shadowRadius = 5;
        
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
        
        [dateFormatter1 setTimeZone:[NSTimeZone systemTimeZone]];
        NSDate *SatrtDate = [NSDate date];
        NSString *str_GoalStartDate = [NSString stringWithFormat:@"%@",[dateFormatter1 stringFromDate:SatrtDate]];
        
        NSString *str_GoalEndDate = [NSString stringWithFormat:@"%@",GoalDescription.g_targetdate];
        NSDate *endDate = [dateFormatter1 dateFromString:str_GoalEndDate];
        NSDate *startDate = [dateFormatter1 dateFromString:str_GoalStartDate];
        NSComparisonResult result = [endDate compare:startDate];
        
        if (result == NSOrderedDescending || result == NSOrderedSame)
        {
            cell.lbl_OverdueText.text = @"";
        }
        else
        {
            //cell.lbl_OverdueText.text = @"Goal overdue";
            cell.lbl_OverdueText.text = [NSString stringWithFormat:NSLocalizedString(@"Goal overdue", nil)];
        }
        
        NSDate *date = [dateFormatter1 dateFromString:GoalDescription.g_targetdate];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM dd, yyyy"];
        NSString *localDateString = [dateFormatter stringFromDate:date];
        
        NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
        
        NSString *string = language;
        if ([string rangeOfString:@"zh-Hans"].location != NSNotFound) {
            language = @"zh-Hans";
        } else if ([string rangeOfString:@"es"].location != NSNotFound) {
            language = @"es";
        }
        else if ([string rangeOfString:@"ja"].location != NSNotFound){
            language = @"ja";
        }
        
        if ([language isEqualToString:@"zh-Hans"]) {
            
            NSLog(@"%@",localDateString);
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            
            [dateFormatter setDateFormat:@"yyyy年M月d日'"];
            NSString *localDateString = [dateFormatter stringFromDate:date];
            cell.lbl_TargetDate.text = [NSString stringWithFormat:@"%@",localDateString];
            NSLog(@"%@",localDateString);
        }
        else{
            cell.lbl_TargetDate.text = [NSString stringWithFormat:@"%@",localDateString];
        }
        
        cell.lbl_NoImage.hidden = TRUE;
        if ([GoalDescription g_picture] == nil)
        {
            cell.imgView_GoalLogo.image = [UIImage imageNamed:@"camera1.png"];
        }
        else
        {
            cell.imgView_GoalLogo.image = [UIImage imageWithData:[GoalDescription g_picture]];
        }
        
        cell.imgView_GoalLogo .layer.cornerRadius = cell.imgView_GoalLogo.frame.size.width/2;
        cell.imgView_GoalLogo.clipsToBounds = YES;
        
        double goalTotal = [GoalDescription.g_amount doubleValue];
        NSString *str_GoalTotal = [NSString stringWithFormat:@"%.2f",goalTotal];
        str_GoalTotal=[GoalManagerAppDelegate Change_String_Formate:str_GoalTotal];
        
        //NSLog(@"%@",str_GoalTotal);
        
        NSString *str_ContributionTotal = [NSString stringWithFormat:@"%@",GoalDescription.g_contributedamount];
        str_ContributionTotal=[GoalManagerAppDelegate Change_String_Formate:str_ContributionTotal];
        //NSLog(@"%@",str_ContributionTotal);
        
        double total=[GoalDescription.g_amount doubleValue];
        
        double recent=[GoalDescription.g_contributedamount doubleValue];
        
        double per=recent*100/total;
        
        cell.lbl_Amount.text = [NSString stringWithFormat:@"%@ (%.2f%%) of %@ %@",str_ContributionTotal,per,str_GoalTotal,GoalDescription.g_currency];
        
        //NSLog(@"%.2f",per);
        
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
        //NSLog(@"%.2f",len);
        
        cell.view_CompletedStage.frame=CGRectMake(cell.view_CompletedStage.frame.origin.x,cell.view_CompletedStage.frame.origin.y,0, cell.view_CompletedStage.frame.size.height);
        
        cell.view_CompletedStage.layer.cornerRadius = 12;
        cell.view_CompletedStage.clipsToBounds = YES;
        
        cell.view_CompletedStageOuter.layer.cornerRadius = 12;
        cell.view_CompletedStageOuter.clipsToBounds = YES;
        
        [UIView animateWithDuration:3
                         animations:^{
                             CGRect frame = cell.view_CompletedStage.frame;
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
                             cell.view_CompletedStage.frame = frame;
                         } completion:nil];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        static NSString *simpleTableIdentifier = @"Space";
        UITableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (celll == nil) {
            celll = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        return celll;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row %2==0)
    {
        GoalOverview_ViewController *obj_GoalOverview_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"GoalOverview_ViewController"];
        NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row/2 inSection:indexPath.section];
        obj_GoalOverview_ViewController.selected_Goal = [self.fetchedResultsController objectAtIndexPath:index] ;
        [self.navigationController pushViewController:obj_GoalOverview_ViewController animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row %2==0)
    {
        return 147;
    }
    else{
        return 10;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row %2==0)
    {
        return YES;
    }
    else{
        return NO;
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row %2==0)
    {
        if (editingStyle == UITableViewCellEditingStyleDelete)
        {
            NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row/2 inSection:indexPath.section];
            [[self.fetchedResultsController objectAtIndexPath:index] MR_deleteEntity];
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
                if (!error)
                {
                }
                else
                {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Goal", nil) message:[error localizedDescription] delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                    [alert show];
                }
                
            }];
            
        }
        
    }
}



- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    _fetchedResultsController = nil;
    [self.tbl_CompletedGoalLists reloadData];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1 ) {
        
        if (buttonIndex == 0)
        {
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"DueDate" forKey:@"SortingType"];
            
        }
        else if (buttonIndex == 1){
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"Alphabetically" forKey:@"SortingType"];
        }
        
        _fetchedResultsController = nil;
        [self.tbl_CompletedGoalLists reloadData];
    }
    NSLog(@"Index = %ld - Title = %@", (long)buttonIndex, [actionSheet buttonTitleAtIndex:buttonIndex]);
}


@end
