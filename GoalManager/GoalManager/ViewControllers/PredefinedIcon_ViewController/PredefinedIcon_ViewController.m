//
//  PredefinedIcon_ViewController.m
//  GoalManager
//
//  Created by apple on 22/12/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import "PredefinedIcon_ViewController.h"
#import "NSString+FontAwesome.h"
#import "Cell_Predefinelist_TableViewCell.h"
#import "GoalManagerAppDelegate.h"

@implementation PredefinedIcon_ViewController

@synthesize lbl_ArrowDown, lbl_Back, btn_Back;
@synthesize muary_prelist,muary_prelist2;
@synthesize tbl_predefinelist;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    muary_prelist = [[NSMutableArray alloc]init];
    
    NSString *str_Trip = [NSString stringWithFormat:NSLocalizedString(@"Travel", nil)];
    NSString *str_House = [NSString stringWithFormat:NSLocalizedString(@"House", nil)];
    NSString *str_Car = [NSString stringWithFormat:NSLocalizedString(@"Car", nil)];
    NSString *str_Business = [NSString stringWithFormat:NSLocalizedString(@"Business", nil)];
    NSString *str_Camera = [NSString stringWithFormat:NSLocalizedString(@"Camera", nil)];
    NSString *str_Financial = [NSString stringWithFormat:NSLocalizedString(@"Financial Goal", nil)];
    NSString *str_Shopping = [NSString stringWithFormat:NSLocalizedString(@"Purchases", nil)];
    NSString *str_ATV = [NSString stringWithFormat:NSLocalizedString(@"TV", nil)];
    NSString *str_MotorBike = [NSString stringWithFormat:NSLocalizedString(@"Motorcycle", nil)];
    NSString *str_Truck = [NSString stringWithFormat:NSLocalizedString(@"Truck", nil)];
    
    muary_prelist = [[NSMutableArray alloc]initWithObjects:@"icon_travel_2",@"icon_house_2",@"icon_car_2",@"icon_business_2",@"icon_camera_2",@"icon_financial_goal_2",@"icon_purchases_2",@"icon_tv_2",@"icon_motorcycle_2",@"icon_truck_2", nil];
    muary_prelist2 = [[NSMutableArray alloc]initWithObjects:str_Trip,str_House,str_Car,str_Business,str_Camera,str_Financial,str_Shopping,str_ATV,str_MotorBike,str_Truck, nil];
    self.title = [NSString stringWithFormat:NSLocalizedString(@"Predefined Icons", nil)];
    
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
    
    lbl_ArrowDown.font = [UIFont fontWithName:kFontAwesomeFamilyName size:30];
    lbl_ArrowDown.text = [NSString fontAwesomeIconStringForIconIdentifier:@"fa-angle-right"];
    
    //////////////////////// UISwipeGestureRecognizer ////////////////////////
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    // Setting the swipe direction.
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.view addGestureRecognizer:swipeRight];
    
    [tbl_predefinelist reloadData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = false;
    [Localytics tagEvent:@"Select Predefind Icon"];
    [Flurry logEvent:@"Select Predefind Icon"];
    [FIRAnalytics logEventWithName:@"Select_Predefind_Icon"
                        parameters:nil];
}

#pragma mark UISwipeGestureRecognizer METHOD

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
        [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark table view delegate
#pragma mark Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return	[muary_prelist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *Cellidentifire=@"Cell_Predefinelist_TableViewCell";
    Cell_Predefinelist_TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Cellidentifire];
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [muary_prelist objectAtIndex:indexPath.row]]];
    cell.lbl_definename.text = [muary_prelist2 objectAtIndex:indexPath.row];
    
    cell.selectionStyle = NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[GoalManagerAppDelegate getdefaultvalue] setObject:[muary_prelist objectAtIndex:indexPath.row] forKey:@"perdefone_imagename"];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
