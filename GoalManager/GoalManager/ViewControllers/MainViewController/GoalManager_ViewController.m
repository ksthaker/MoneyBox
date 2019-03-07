//
//  ViewController.m
//  GoalManager
//
//  Created by apple on 10/11/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import "GoalManager_ViewController.h"
#import "Cell_GoalLists.h"
#import "NSString+FontAwesome.h"
#import "CompletedGoal_ViewController.h"
#import "GoalOverview_ViewController.h"
#import "Settings_ViewController.h"
#import "GoalManagerAppDelegate.h"
#import "AddGoal_ViewController.h"
#import "GoalManager.h"
#import "Reachability.h"
#import "Scheduale_Event.h"
#import "UIViewController+KNSemiModal.h"
#import "Filter_ViewController.h"
#import "AboutApp_ViewController.h"
#import "CrossAppViewController.h"

@interface GoalManager_ViewController ()

@end

@implementation GoalManager_ViewController
@synthesize btn_AddGoal,btn_CompletedGoals,btn_Settings,btn_FilterGoal;
@synthesize tbl_GoalLists;
@synthesize lbl_AddGoal,lbl_Settings,lbl_ArrowUp,lbl_TotalForAllActiveGoals,lbl_Filter,lbl_MainGoal;
@synthesize view_Totals,view_InnerTotalForAllActiveGoals,view_OuterTotalForAllActiveGoals,view_Main;
@synthesize goalList;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize editingContext = _editingContext;
@synthesize hud;
@synthesize imgView_InitialScreen;

#pragma mark - Internet Connectivity Check
- (BOOL) connectedToNetwork
{
    Reachability* reachability = [Reachability reachabilityWithHostName:@"google.com"];
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if (remoteHostStatus == ReachableViaWWAN)
    {
        isInternet = TRUE;
    }
    else if (remoteHostStatus == ReachableViaWiFi)
    {
        isInternet = TRUE;
    }
    else
    {
        isInternet =NO;
    }
    return isInternet;
}

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    //self.title = NSLocalizedString(@"Goals", nil);
    //self.lbl_MainGoal.text = NSLocalizedString(@"Goals", nil);
    self.btn_AddGoalNew.layer.cornerRadius=3;
    
    //self.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    self.view_InnerTotalForAllActiveGoals.layer.cornerRadius = 12;
    self.view_InnerTotalForAllActiveGoals.clipsToBounds = YES;
    
    self.view_OuterTotalForAllActiveGoals.layer.cornerRadius = 12;
    self.view_OuterTotalForAllActiveGoals.clipsToBounds = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(action_ViewRefresh) name:@"GoalManager_ViewController" object:nil];
    
    
    //[[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"InitialScreen1"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *yourArtPath = [documentsDirectory stringByAppendingPathComponent:@""];
    NSLog(@"%@",yourArtPath);
    
    if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"CurrencyStore"] length] <=0 || [[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"CurrencyStore"]isEqualToString:@"(null)"])
    {
        NSDictionary *muary_converter =[[NSDictionary alloc]init];
        muary_converter = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"3.6727" , @"USDAED",
                           @"68.599998", @"USDAFN" ,
                           @"111.849998", @"USDALL" ,
                           @"483.670013", @"USDAMD" ,
                           @"1.78023", @"USDANG" ,
                           @"165.098007", @"USDAOA" ,
                           @"17.294001", @"USDARS" ,
                           @"1.3138", @"USDAUD" ,
                           @"1.78", @"USDAWG" ,
                           @"1.699596", @"USDAZN" ,
                           @"1.645021", @"USDBAM" ,
                           @"2", @"USDBBD" ,
                           @"82.099998", @"USDBDT" ,
                           @"1.636403", @"USDBGN" ,
                           @"0.377403", @"USDBHD" ,
                           @"1747.829956", @"USDBIF" ,
                           @"1", @"USDBMD" ,
                           @"1.345498", @"USDBND" ,
                           @"6.8498", @"USDBOB" ,
                           @"3.227498", @"USDBRL" ,
                           @"1", @"USDBSD" ,
                           @"0.000102", @"USDBTC" ,
                           @"64.599998", @"USDBTN" ,
                           @"10.4553", @"USDBWP" ,
                           @"1.990258", @"USDBYN" ,
                           @"19600", @"USDBYR" ,
                           @"1.997805", @"USDBZD" ,
                           @"1.27576", @"USDCAD" ,
                           @"1565.496581", @"USDCDF" ,
                           @"0.98158", @"USDCHF" ,
                           @"0.02363", @"USDCLF" ,
                           @"637.330017", @"USDCLP" ,
                           @"6.602898", @"USDCNY" ,
                           @"2999.899902", @"USDCOP" ,
                           @"560.710022", @"USDCRC" ,
                           @"1", @"USDCUC" ,
                           @"26.5", @"USDCUP" ,
                           @"92.620003", @"USDCVE" ,
                           @"21.354996", @"USDCZK" ,
                           @"176.830002", @"USDDJF" ,
                           @"6.24962", @"USDDKK" ,
                           @"48.080002", @"USDDOP" ,
                           @"114.087997", @"USDDZD" ,
                           @"17.669711", @"USDEGP" ,
                           @"14.989649", @"USDERN" ,
                           @"27.150252", @"USDETB" ,
                           @"0.839603", @"USDEUR" ,
                           @"2.089015", @"USDFJD" ,
                           @"0.749497", @"USDFKP" ,
                           @"0.74985", @"USDGBP" ,
                           @"2.708296", @"USDGEL" ,
                           @"0.749924", @"USDGGP" ,
                           @"4.628499", @"USDGHS" ,
                           @"0.749696", @"USDGIP" ,
                           @"47.150002", @"USDGMD" ,
                           @"9003.000328", @"USDGNF" ,
                           @"7.338025", @"USDGTQ" ,
                           @"203.779999", @"USDGYD" ,
                           @"7.802811", @"USDHKD" ,
                           @"23.492001", @"USDHNL" ,
                           @"6.334497", @"USDHRK" ,
                           @"61.549999", @"USDHTG" ,
                           @"260.890015", @"USDHUF" ,
                           @"13511", @"USDIDR" ,
                           @"3.501047", @"USDILS" ,
                           @"0.749924", @"USDIMP" ,
                           @"64.400002", @"USDINR" ,
                           @"1166", @"USDIQD" ,
                           @"35230.000281", @"USDIRR" ,
                           @"102.800003", @"USDISK" ,
                           @"0.749924", @"USDJEP" ,
                           @"125.249635", @"USDJMD" ,
                           @"0.706952", @"USDJOD" ,
                           @"111.181027", @"USDJPY" ,
                           @"103.150002", @"USDKES" ,
                           @"69.670998", @"USDKGS" ,
                           @"4020.000299", @"USDKHR" ,
                           @"413.920013", @"USDKMF" ,
                           @"899.999756", @"USDKPW" ,
                           @"1085.670044", @"USDKRW" ,
                           @"0.3014", @"USDKWD" ,
                           @"0.819805", @"USDKYD" ,
                           @"331.359985", @"USDKZT" ,
                           @"8293.000397", @"USDLAK" ,
                           @"1510.999777", @"USDLBP" ,
                           @"153.600006", @"USDLKR" ,
                           @"124.650002", @"USDLRD" ,
                           @"13.7302", @"USDLSL" ,
                           @"3.048701", @"USDLTL" ,
                           @"0.62055", @"USDLVL" ,
                           @"1.357992", @"USDLYD" ,
                           @"9.393602", @"USDMAD" ,
                           @"17.157047", @"USDMDL" ,
                           @"3179.999829", @"USDMGA" ,
                           @"51.429966", @"USDMKD" ,
                           @"1362.000061", @"USDMMK" ,
                           @"2436.999836", @"USDMNT" ,
                           @"8.036702999999999", @"USDMOP" ,
                           @"351.109985", @"USDMRO" ,
                           @"33.459999", @"USDMUR" ,
                           @"15.570184", @"USDMVR" ,
                           @"716.169983", @"USDMWK" ,
                           @"18.578298", @"USDMXN" ,
                           @"4.116503", @"USDMYR" ,
                           @"60.400002", @"USDMZN" ,
                           @"13.758025", @"USDNAD" ,
                           @"356.999513", @"USDNGN" ,
                           @"30.600376", @"USDNIO" ,
                           @"8.148160000000001", @"USDNOK" ,
                           @"103.550003", @"USDNPR" ,
                           @"1.441501", @"USDNZD" ,
                           @"0.384798", @"USDOMR" ,
                           @"1", @"USDPAB" ,
                           @"3.231803", @"USDPEN" ,
                           @"3.207803", @"USDPGK" ,
                           @"50.31999", @"USDPHP" ,
                           @"105.349998", @"USDPKR" ,
                           @"3.534597", @"USDPLN" ,
                           @"5637.999815", @"USDPYG" ,
                           @"3.838398", @"USDQAR" ,
                           @"3.891803", @"USDRON" ,
                           @"99.785398", @"USDRSD" ,
                           @"58.404099", @"USDRUB" ,
                           @"834.47998", @"USDRWF" ,
                           @"3.750157", @"USDSAR" ,
                           @"7.810136", @"USDSBD" ,
                           @"13.279905", @"USDSCR" ,
                           @"6.659805", @"USDSDG" ,
                           @"8.29833", @"USDSEK" ,
                           @"1.34591", @"USDSGD" ,
                           @"0.7496969999999999", @"USDSHP" ,
                           @"7630.000475", @"USDSLL" ,
                           @"558.999735", @"USDSOS" ,
                           @"7.409858", @"USDSRD" ,
                           @"20579.5", @"USDSTD" ,
                           @"8.749720999999999", @"USDSVC" ,
                           @"514.97998", @"USDSYP" ,
                           @"13.759956", @"USDSZL" ,
                           @"32.580002", @"USDTHB" ,
                           @"8.811102999999999", @"USDTJS" ,
                           @"3.4", @"USDTMT" ,
                           @"2.4893", @"USDTND" ,
                           @"2.288973", @"USDTOP" ,
                           @"3.907501", @"USDTRY" ,
                           @"6.629496", @"USDTTD" ,
                           @"29.979693", @"USDTWD" ,
                           @"2234.999894", @"USDTZS" ,
                           @"26.799999", @"USDUAH" ,
                           @"3627.000344", @"USDUGX" ,
                           @"1", @"USDUSD" ,
                           @"29.049999", @"USDUYU" ,
                           @"8085.0003", @"USDUZS" ,
                           @"9.974500000000001", @"USDVEF" ,
                           @"22713", @"USDVND" ,
                           @"106.139999", @"USDVUV" ,
                           @"2.5702", @"USDWST" ,
                           @"550.450012", @"USDXAF" ,
                           @"0.058667", @"USDXAG" ,
                           @"0.000773", @"USDXAU" ,
                           @"2.704821", @"USDXCD" ,
                           @"0.704217", @"USDXDR" ,
                           @"549.450012", @"USDXOF" ,
                           @"100.149888", @"USDXPF" ,
                           @"249.929993", @"USDYER" ,
                           @"13.760703", @"USDZAR" ,
                           @"9001.213532", @"USDZMK" ,
                           @"10.089912", @"USDZMW" ,
                           @"322.355011", @"USDZWL" ,
                           nil];
        
        NSLog(@"%@",muary_converter);
        
        [[GoalManagerAppDelegate getdefaultvalue]setObject:[muary_converter mutableCopy] forKey:@"CurrencyConvert"];
        
        [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"CurrencyStore"];
    }
    
    
}

-(void)action_CrossPromotion
{
    CrossAppViewController *obj_CrossAppViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CrossAppViewController"];
    [self presentViewController:obj_CrossAppViewController animated:YES completion:nil];
}

-(void)action_ViewRefresh
{
    [self viewWillAppear:NO];
}


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = true;
    
    [self action_InitialScreen];
    
    [Localytics tagEvent:@"List of Uncompleted Goals"];
    [Flurry logEvent:@"List of Uncompleted Goals"];
    
    [FIRAnalytics logEventWithName:@"List_of_Uncompleted_Goals"
                        parameters:nil];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    NSMutableArray *muary_GoalCountCheck = [[NSMutableArray alloc]init];
    NSString *str_Completed = @"Not Completed";
    NSPredicate *predict_Completed = [NSPredicate predicateWithFormat:@"g_completedstatus == %@",str_Completed];
    [muary_GoalCountCheck addObjectsFromArray:[Goal MR_findAllSortedBy:@"g_title" ascending:YES withPredicate:predict_Completed]];
    BOOL isInternetCheck = [GoalManagerAppDelegate connectedToNetwork];
    
    self.bannerView.adUnitID = @"ca-app-pub-5298130731078005/7401333379";
    self.bannerView.rootViewController = self;
    GADRequest *request = [GADRequest request];
    
    //request.testDevices = @[@"e33953a7d4e4e4fbac2a3e08d60e4f9db7abcdfa"];
    
    [self.bannerView loadRequest:request];
    
    NSMutableArray *muary_CompleteGoal = [[NSMutableArray alloc]init];
    NSString *str_CompleteGoal = @"Completed";
    NSPredicate *predict_CompleteGoal = [NSPredicate predicateWithFormat:@"g_completedstatus == %@",str_CompleteGoal];
    [muary_CompleteGoal addObjectsFromArray:[Goal MR_findAllSortedBy:@"g_title" ascending:YES withPredicate:predict_CompleteGoal]];
    
    for (int i = 0; i<muary_CompleteGoal.count; i++)
    {
        Goal *CompleteGoal = [muary_CompleteGoal objectAtIndex:i];
        NSString *str_ObjectID = [NSString stringWithFormat:@"%@",CompleteGoal.objectID];
        [Scheduale_Event CancelExistingNotification:str_ObjectID];
    }
    
    if (![[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InAppPurchase"] isEqualToString:@"1"])
    {
        [[GoalManagerAppDelegate getdefaultvalue]setObject:@"OFF" forKey:@"ShowTotals"];
        
        self.imgView_Lock.hidden = FALSE;
        self.view_Lock.hidden = FALSE;
        self.imgView_LockTable1.hidden = FALSE;
        self.imgView_LockTable2.hidden = TRUE;
        self.view_Lock3.hidden = TRUE;
    }
    else{
        self.imgView_Lock.hidden = TRUE;
        self.view_Lock.hidden = TRUE;
        
        self.view_Lock3.hidden = FALSE;
    }
    
    
    if (muary_GoalCountCheck.count == 0)
    {
        self.view_NoGoal.hidden = FALSE;
        self.view_Lock.hidden = TRUE;
        self.view_Lock2.hidden = TRUE;
        self.tbl_GoalLists.hidden = TRUE;
        self.view_Totals.hidden = TRUE;
        self.imgView_Lock.hidden = TRUE;
        if (isInternetCheck == TRUE) {
            if (![[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InAppPurchase"] isEqualToString:@"1"])
            {
                self.bannerView.hidden = FALSE;
            }
            else
            {
                self.bannerView.hidden = TRUE;
            }
        }
        else
        {
           self.bannerView.hidden = TRUE;
        }
        
        if (![[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InAppPurchase"] isEqualToString:@"1"])
        {
            
            
            if (muary_CompleteGoal.count == 2){
                
                self.imgView_Lock.hidden = FALSE;
            }
            else if (muary_CompleteGoal.count > 2){
                
                self.imgView_Lock.hidden = FALSE;
            }
        }
        else{
            
            self.view_Lock.hidden = TRUE;
            self.view_Lock2.hidden = TRUE;
            self.imgView_Lock.hidden = TRUE;
        }
    }
    else
    {
        self.view_NoGoal.hidden = TRUE;
        self.tbl_GoalLists.hidden = FALSE;
        
        if (isInternetCheck == TRUE)
        {
            if (![[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InAppPurchase"] isEqualToString:@"1"])
            {
                self.bannerView.hidden = FALSE;
                
                NSLog(@"%f",self.view_Main.frame.size.height);
                
                CGRect tbl1 = self.view_Totals.frame;
                tbl1.origin.y = self.view_Main.bounds.size.height-tbl1.size.height-50;
                self.view_Totals.frame = tbl1;
                
                CGRect tbl = self.tbl_GoalLists.frame;
                
                if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"ShowTotals"]isEqualToString:@"ON"])
                {
                    tbl.size.height = self.view_Main.bounds.size.height-160;
                }
                else
                {
                    tbl.size.height = self.view_Main.bounds.size.height-50;
                }
                self.tbl_GoalLists.frame = tbl;
            }
            else
            {
                self.bannerView.hidden = TRUE;
                CGRect tbl1 = self.view_Totals.frame;
                tbl1.origin.y = self.view_Main.bounds.size.height-tbl1.size.height;
                self.view_Totals.frame = tbl1;
                
                CGRect tbl = self.tbl_GoalLists.frame;
                
                
                if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"ShowTotals"]isEqualToString:@"ON"])
                {
                    tbl.size.height = self.view_Main.bounds.size.height-110;
                }
                else
                {
                    tbl.size.height = self.view_Main.bounds.size.height;
                }
                
                self.tbl_GoalLists.frame = tbl;
            }
        }
        else
        {
            self.bannerView.hidden = TRUE;
            
            CGRect tbl1 = self.view_Totals.frame;
            tbl1.origin.y = self.view_Main.bounds.size.height-tbl1.size.height;
            self.view_Totals.frame = tbl1;
            
            CGRect tbl = self.tbl_GoalLists.frame;
            if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"ShowTotals"]isEqualToString:@"ON"])
            {
                tbl.size.height = self.view_Main.bounds.size.height-110;
            }
            else
            {
                tbl.size.height = self.view_Main.bounds.size.height;
            }
            self.tbl_GoalLists.frame = tbl;
        }
        
        if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"ShowTotals"]isEqualToString:@"ON"])
        {
            view_Totals.hidden = FALSE;
            [self action_TotalForAllActiveGoals:self];
        }
        else
        {
            view_Totals.hidden = TRUE;
        }
        
        CAShapeLayer *yourViewBorder = [CAShapeLayer layer];
        yourViewBorder.strokeColor = [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1.0].CGColor;
        yourViewBorder.fillColor = nil;
        yourViewBorder.lineDashPattern = @[@3, @3];
        yourViewBorder.frame = self.view_Lock.bounds;
        yourViewBorder.path = [UIBezierPath bezierPathWithRect:self.view_Lock.bounds].CGPath;
        [self.view_Lock.layer addSublayer:yourViewBorder];
        
        CAShapeLayer *yourViewBorder2 = [CAShapeLayer layer];
        yourViewBorder2.strokeColor = [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1.0].CGColor;
        yourViewBorder2.fillColor = nil;
        yourViewBorder2.lineDashPattern = @[@3, @3];
        yourViewBorder2.frame = self.view_Lock2.bounds;
        yourViewBorder2.path = [UIBezierPath bezierPathWithRect:self.view_Lock2.bounds].CGPath;
        [self.view_Lock2.layer addSublayer:yourViewBorder2];
        
        CAShapeLayer *yourViewBorder3 = [CAShapeLayer layer];
        yourViewBorder3.strokeColor = [UIColor colorWithRed:179/255.0 green:179/255.0 blue:179/255.0 alpha:1.0].CGColor;
        yourViewBorder3.fillColor = nil;
        yourViewBorder3.lineDashPattern = @[@3, @3];
        yourViewBorder3.frame = self.view_Lock3.bounds;
        yourViewBorder3.path = [UIBezierPath bezierPathWithRect:self.view_Lock3.bounds].CGPath;
        [self.view_Lock3.layer addSublayer:yourViewBorder3];
        
        
        if (![[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InAppPurchase"] isEqualToString:@"1"])
        {
            NSMutableArray *muary_TotalActiveGoal = [NSMutableArray arrayWithArray:[Goal MR_findAll]];
            
            if (muary_TotalActiveGoal.count == 1)
            {
                self.view_Lock.hidden = FALSE;
                self.view_Lock2.hidden = TRUE;
                self.imgView_LockTable1.hidden = FALSE;
                self.imgView_LockTable2.hidden = TRUE;
                self.imgView_Lock.hidden = TRUE;
            }
            else if (muary_TotalActiveGoal.count == 2){
                
                if (muary_CompleteGoal.count == 1) {
                    self.view_Lock.hidden = FALSE;
                    
                    self.imgView_LockTable1.hidden = TRUE;
                    self.imgView_LockTable2.hidden = FALSE;
                    
                    
                    self.view_Lock2.hidden = TRUE;
                    self.imgView_Lock.hidden = FALSE;
                }
                else{
                    self.view_Lock.hidden = TRUE;
                    self.view_Lock2.hidden = FALSE;
                    self.imgView_Lock.hidden = FALSE;
                }
                
                
            }
            else if (muary_TotalActiveGoal.count > 2){
                self.view_Lock.hidden = TRUE;
                self.view_Lock2.hidden = TRUE;
                self.imgView_Lock.hidden = TRUE;
            }
        }
        else{
            
            self.view_Lock.hidden = TRUE;
            self.view_Lock2.hidden = TRUE;
            self.imgView_Lock.hidden = TRUE;
        }
        
    }
    
    
    
//    if ([self.language isEqualToString:@"zh-Hans"]) {
//    }
//    else if ([self.language isEqualToString:@"es"]) {
//    }
//    else if ([self.language isEqualToString:@"ja"]) {
//    }
//    else{
//        if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"CrossAppFirst"] length] <=0 || [[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"CrossAppFirst"]isEqualToString:@"(null)"])
//        {
//
//            if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InitialScreen1"]isEqualToString:@"1"])
//            {
//
//
//                CrossAppViewController *obj_CrossAppViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CrossAppViewController"];
//                [self presentViewController:obj_CrossAppViewController animated:YES completion:nil];
//            }
//            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"CrossAppFirst"];
//
//        }
//        else{
//            NSString *majorVersion = [[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"CrossApp"];
//            NSLog(@"%@",majorVersion);
//
//            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//
//            NSString *majorVersion2 = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//            NSLog(@"%@",majorVersion2);
//
//            double version_Major = [[majorVersion2 stringByReplacingOccurrencesOfString:@" " withString:@""] doubleValue];
//            NSLog(@"%f", version_Major);
//
//            double version_Minor = [[majorVersion stringByReplacingOccurrencesOfString:@" " withString:@""] doubleValue];
//            NSLog(@"%f", version_Minor);
//
//            if (version_Major > version_Minor) {
//                CrossAppViewController *obj_CrossAppViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CrossAppViewController"];
//                [self presentViewController:obj_CrossAppViewController animated:YES completion:nil];
//
//                [[GoalManagerAppDelegate getdefaultvalue]setObject:majorVersion2 forKey:@"CrossApp"];
//            }
//        }
//
//        if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"AppKilled"]isEqualToString:@"1"]) {
//            if ([[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"CrossAppSeeLater"] == nil || [[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"CrossAppSeeLater"]isEqualToString:@""])
//            {
//                [[GoalManagerAppDelegate getdefaultvalue]setObject:@"0" forKey:@"CrossAppSeeLater"];
//            }
//            else if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"CrossAppSeeLater"] isEqualToString:@"0"])
//            {
//                [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"CrossAppSeeLater"];
//            }
//            else if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"CrossAppSeeLater"] isEqualToString:@"1"])
//            {
//                [[GoalManagerAppDelegate getdefaultvalue]setObject:@"2" forKey:@"CrossAppSeeLater"];
//            }
//            else if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"CrossAppSeeLater"] isEqualToString:@"2"])
//            {
//                [[GoalManagerAppDelegate getdefaultvalue]setObject:@"3" forKey:@"CrossAppSeeLater"];
//            }
//            else if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"CrossAppSeeLater"] isEqualToString:@"3"])
//            {
//                [[GoalManagerAppDelegate getdefaultvalue]setObject:@"4" forKey:@"CrossAppSeeLater"];
//            }
//            else if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"CrossAppSeeLater"] isEqualToString:@"4"])
//            {
//                [[GoalManagerAppDelegate getdefaultvalue]setObject:@"5" forKey:@"CrossAppSeeLater"];
//            }
//            else if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"CrossAppSeeLater"] isEqualToString:@"5"])
//            {
//                [[GoalManagerAppDelegate getdefaultvalue]setObject:@"6" forKey:@"CrossAppSeeLater"];
//            }
//            else if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"CrossAppSeeLater"] isEqualToString:@"6"])
//            {
//                [[GoalManagerAppDelegate getdefaultvalue]setObject:@"7" forKey:@"CrossAppSeeLater"];
//            }
//            else if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"CrossAppSeeLater"] isEqualToString:@"7"])
//            {
//                [[GoalManagerAppDelegate getdefaultvalue]setObject:@"8" forKey:@"CrossAppSeeLater"];
//            }
//            else if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"CrossAppSeeLater"] isEqualToString:@"8"])
//            {
//                [[GoalManagerAppDelegate getdefaultvalue]setObject:@"9" forKey:@"CrossAppSeeLater"];
//            }
//            else if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"CrossAppSeeLater"] isEqualToString:@"9"])
//            {
//                [[GoalManagerAppDelegate getdefaultvalue]setObject:@"10" forKey:@"CrossAppSeeLater"];
//            }
//            else if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"CrossAppSeeLater"] isEqualToString:@"10"])
//            {
//                [[GoalManagerAppDelegate getdefaultvalue]setObject:@"11" forKey:@"CrossAppSeeLater"];
//                CrossAppViewController *obj_CrossAppViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CrossAppViewController"];
//                [self presentViewController:obj_CrossAppViewController animated:YES completion:nil];
//            }
//        }
//    }
    
//    LockScreen_VC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LockScreen_VC"];
//    vc.modalPresentationStyle = UIModalPresentationCurrentContext;
//    vc.modalPresentationStyle = UIModalPresentationCustom;
//    vc.view.backgroundColor = [UIColor clearColor];
//    [self.navigationController presentViewController:vc animated:YES completion:^{}];
    
//    LockScreen_VC *obj_LockScreen_VC =[self.storyboard instantiateViewControllerWithIdentifier:@"LockScreen_VC"];
//    [self.navigationController pushViewController:obj_LockScreen_VC animated:NO];
    
    
    //[self action_TotalForAllActiveGoals:self];
//    UIImage* image = [UIImage imageNamed:@"navbar_add_goal.png"];
//    CGRect frameimg = CGRectMake(0, 0,22,22);
//    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
//    [someButton setBackgroundImage:image forState:UIControlStateNormal];
//    [someButton addTarget:self action:@selector(action_AddGoal:) forControlEvents:UIControlEventTouchUpInside];
//    [someButton setSelected:YES];
//
//    btn_AddGoal= [[UIBarButtonItem alloc]initWithCustomView:someButton];
//
//
//    UIButton *empty=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
//    empty.backgroundColor=[UIColor clearColor];
//
//    UIBarButtonItem *btn_empty=[[UIBarButtonItem alloc]initWithCustomView:empty];
//
//    UIImage* image1 = [UIImage imageNamed:@"navbar_filter.png"];
//    CGRect frameimg1 = CGRectMake(0,0,22,22);
//    UIButton *someButton1 = [[UIButton alloc] initWithFrame:frameimg1];
//    [someButton1 setBackgroundImage:image1 forState:UIControlStateNormal];
//    [someButton1 addTarget:self action:@selector(action_FilterGoal:)
//          forControlEvents:UIControlEventTouchUpInside];
//    [someButton1 setSelected:YES];
//
//
//    btn_FilterGoal= [[UIBarButtonItem alloc]initWithCustomView:someButton1];
//
//    NSArray *arr_AddFilterGoal= [[NSArray alloc] initWithObjects:btn_AddGoal,btn_empty,btn_FilterGoal,nil];
//    self.navigationItem.rightBarButtonItems = arr_AddFilterGoal;
//
//    UIImage* image2 = [UIImage imageNamed:@"navbar_settings.png"];
//    CGRect frameimg2 = CGRectMake(0, 0,22,22);
//    UIButton *someButton2 = [[UIButton alloc] initWithFrame:frameimg2];
//    [someButton2 setBackgroundImage:image2 forState:UIControlStateNormal];
//    [someButton2 addTarget:self action:@selector(action_Settings:)
//          forControlEvents:UIControlEventTouchUpInside];
//    [someButton2 setSelected:YES];
//
//    btn_Settings= [[UIBarButtonItem alloc]initWithCustomView:someButton2];
//
//    UIButton *emptyleft=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
//    emptyleft.backgroundColor=[UIColor clearColor];
//
//    UIBarButtonItem *btn_emptyleft=[[UIBarButtonItem alloc]initWithCustomView:emptyleft];
//
//    UIImage* image3 = [UIImage imageNamed:@"navbar_completed_goals.png"];
//    CGRect frameimg3 = CGRectMake(0, 0,22,22);
//    UIButton *someButton3 = [[UIButton alloc] initWithFrame:frameimg3];
//    [someButton3 setBackgroundImage:image3 forState:UIControlStateNormal];
//    [someButton3 addTarget:self action:@selector(action_CompletedGoals:)
//          forControlEvents:UIControlEventTouchUpInside];
//    [someButton3 setSelected:YES];
//
//    UIBarButtonItem *btn_goalcompleted= [[UIBarButtonItem alloc]initWithCustomView:someButton3];
//
//    NSArray *arr_AddFilterGoalleft= [[NSArray alloc] initWithObjects:btn_Settings,btn_emptyleft,btn_goalcompleted,nil];
//    self.navigationItem.leftBarButtonItems = arr_AddFilterGoalleft;
    
    
    
    
    _fetchedResultsController = nil;
    [tbl_GoalLists reloadData];
    
    
    [self action_AskLock];
    [self action_SetReminderAgain];
    [super viewWillAppear:YES];
}

-(void)action_SetReminderAgain{
    if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"LocalNotifReminder"] length] <=0 || [[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"LocalNotifReminder"]isEqualToString:@"(null)"])
    {
        NSMutableArray *muary_BiWeeklyGoal = [[NSMutableArray alloc]init];
        NSString *str_BiWeeklyGoal = @"Not Completed";
        NSString *str_BiWeeklyGoal1 = @"Bi-weekly";
        NSPredicate *predict_BiweeklyGoal = [NSPredicate predicateWithFormat:@"g_completedstatus == %@ AND g_savingfrequency == %@",str_BiWeeklyGoal,str_BiWeeklyGoal1];
        [muary_BiWeeklyGoal addObjectsFromArray:[Goal MR_findAllSortedBy:@"g_title" ascending:YES withPredicate:predict_BiweeklyGoal]];
        
        for (int i = 0; i<muary_BiWeeklyGoal.count; i++)
        {
            Goal *BiweeklyGoal = [muary_BiWeeklyGoal objectAtIndex:i];
            NSString *str_ObjectIDBiweekly = [NSString stringWithFormat:@"%@",BiweeklyGoal.objectID];
            BiweeklyGoal.g_savingfrequency = @"Weekly";
            
            [Scheduale_Event CancelExistingNotification:str_ObjectIDBiweekly];
            
            //        NSInteger integer_SelectedReminderDay = 0;
            //
            //        if ([BiweeklyGoal.g_reminderday isEqualToString:@"Sunday"])
            //        {
            //            integer_SelectedReminderDay = 1;
            //        }
            //        else if ([BiweeklyGoal.g_reminderday isEqualToString:@"Monday"])
            //        {
            //            integer_SelectedReminderDay = 2;
            //        }
            //        else if ([BiweeklyGoal.g_reminderday isEqualToString:@"Tuesday"])
            //        {
            //            integer_SelectedReminderDay = 3;
            //        }
            //        else if ([BiweeklyGoal.g_reminderday isEqualToString:@"Wednesday"])
            //        {
            //            integer_SelectedReminderDay = 4;
            //        }
            //        else if ([BiweeklyGoal.g_reminderday isEqualToString:@"Thursday"])
            //        {
            //            integer_SelectedReminderDay = 5;
            //        }
            //        else if ([BiweeklyGoal.g_reminderday isEqualToString:@"Friday"])
            //        {
            //            integer_SelectedReminderDay = 6;
            //        }
            //        else if ([BiweeklyGoal.g_reminderday isEqualToString:@"Saturday"])
            //        {
            //            integer_SelectedReminderDay = 7;
            //        }
            //
            //
            //        NSDate *today = [NSDate date];
            //        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            //        [gregorian setLocale:[NSLocale currentLocale]];
            //        NSDateComponents *nowComponents = [gregorian components:NSCalendarUnitYear | NSCalendarUnitWeekOfYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday fromDate:today];
            //
            //        NSInteger weekday = [nowComponents weekday];
            //        //NSLog(@"%ld",(long)weekday) ;
            //        [nowComponents setWeekday:integer_SelectedReminderDay]; //Monday
            //        if (weekday >= integer_SelectedReminderDay)
            //        {
            //            [nowComponents setWeekOfYear:[nowComponents weekOfYear]+1];
            //
            //            //[nowComponents setWeek: [nowComponents week]+1];
            //        }
            //        else
            //        {
            //            [nowComponents setWeekOfYear:[nowComponents weekOfYear]];
            //        }
            //        NSDate *beginningOfWeek = [gregorian dateFromComponents:nowComponents];
            //
            //        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            //        NSString *localDateString = [dateFormatter stringFromDate:beginningOfWeek];
            //        NSString *str_DateAndTime = [NSString stringWithFormat:@"%@ %@:00",localDateString,BiweeklyGoal.g_remindertime];
            //        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            //        NSDate *date_DateAndTime = [dateFormatter dateFromString:str_DateAndTime];
            //        //NSLog(@"%@",date_DateAndTime);
            //
            //        NSString *str_Add = [NSString stringWithFormat:NSLocalizedString(@"add Weekly contribution to goal", nil)];
            //
            //        NSString *str_Message = [NSString stringWithFormat:@"%@ \"%@\"",str_Add,BiweeklyGoal.g_title];
            //
            //        [Scheduale_Event scheduleLocalNotificationWithDate:date_DateAndTime atIndex:str_ObjectIDBiweekly Description:str_Message repeat:@"Weekly"];
            
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
                if (!error)
                {
                    
                }
                else
                {
                    
                }
            }];
        }
        
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:0];
        NSInteger numberOfRows = [sectionInfo numberOfObjects];
        NSLog(@"%ld",(long)numberOfRows);
        for (int i = 0; i<numberOfRows; i++)
        {
            NSIndexPath *indexPath = [[NSIndexPath alloc]init];
            indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            Goal *GoalForReminderChange = [self.fetchedResultsController objectAtIndexPath:indexPath];
            
            if ([GoalForReminderChange.g_completedstatus isEqualToString:@"Not Completed"])
            {
                if ([GoalForReminderChange.g_setsavingreminder isEqualToString:@"YES"])
                {
                    NSInteger integer_SelectedReminderDay = 0;
                    
                    if ([GoalForReminderChange.g_reminderday isEqualToString:@"Sunday"])
                    {
                        integer_SelectedReminderDay = 1;
                    }
                    else if ([GoalForReminderChange.g_reminderday isEqualToString:@"Monday"])
                    {
                        integer_SelectedReminderDay = 2;
                    }
                    else if ([GoalForReminderChange.g_reminderday isEqualToString:@"Tuesday"])
                    {
                        integer_SelectedReminderDay = 3;
                    }
                    else if ([GoalForReminderChange.g_reminderday isEqualToString:@"Wednesday"])
                    {
                        integer_SelectedReminderDay = 4;
                    }
                    else if ([GoalForReminderChange.g_reminderday isEqualToString:@"Thursday"])
                    {
                        integer_SelectedReminderDay = 5;
                    }
                    else if ([GoalForReminderChange.g_reminderday isEqualToString:@"Friday"])
                    {
                        integer_SelectedReminderDay = 6;
                    }
                    else if ([GoalForReminderChange.g_reminderday isEqualToString:@"Saturday"])
                    {
                        integer_SelectedReminderDay = 7;
                    }
                    
                    if ([GoalForReminderChange.g_savingfrequency isEqualToString:@"Daily"])
                    {
                        NSDate *currentDate = [[NSDate alloc] init];
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                        NSString *localDateString = [dateFormatter stringFromDate:currentDate];
                        
                        NSString *str_DateAndTime = [NSString stringWithFormat:@"%@ %@:00",localDateString,GoalForReminderChange.g_remindertime];
                        
                        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        NSDate *date_DateAndTime = [dateFormatter dateFromString:str_DateAndTime];
                        
                        NSString *str_Add = [NSString stringWithFormat:NSLocalizedString(@"add Daily contribution to goal", nil)];
                        
                        NSString *str_Message = [NSString stringWithFormat:@"%@ \"%@\"",str_Add,GoalForReminderChange.g_title];
                        
                        [Scheduale_Event scheduleLocalNotificationWithDate:date_DateAndTime atIndex:[NSString stringWithFormat:@"%@",GoalForReminderChange.objectID] Description:str_Message repeat:@"Daily"];
                    }
                    else if ([GoalForReminderChange.g_savingfrequency isEqualToString:@"Weekly"])
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
                        NSString *str_DateAndTime = [NSString stringWithFormat:@"%@ %@:00",localDateString,GoalForReminderChange.g_remindertime];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        NSDate *date_DateAndTime = [dateFormatter dateFromString:str_DateAndTime];
                        NSLog(@"%@",date_DateAndTime);
                        
                        NSString *str_Add = [NSString stringWithFormat:NSLocalizedString(@"add Weekly contribution to goal", nil)];
                        
                        NSString *str_Message = [NSString stringWithFormat:@"%@ \"%@\"",str_Add,GoalForReminderChange.g_title];
                        
                        [Scheduale_Event scheduleLocalNotificationWithDate:date_DateAndTime atIndex:[NSString stringWithFormat:@"%@",GoalForReminderChange.objectID] Description:str_Message repeat:@"Weekly"];
                    }
                    else if ([GoalForReminderChange.g_savingfrequency isEqualToString:@"Bi-weekly"])
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
                        NSString *str_DateAndTime = [NSString stringWithFormat:@"%@ %@:00",localDateString,GoalForReminderChange.g_remindertime];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        NSDate *date_DateAndTime = [dateFormatter dateFromString:str_DateAndTime];
                        NSLog(@"%@",date_DateAndTime);
                        
                        NSString *str_Add = [NSString stringWithFormat:NSLocalizedString(@"add Weekly contribution to goal", nil)];
                        
                        NSString *str_Message = [NSString stringWithFormat:@"%@ \"%@\"",str_Add,GoalForReminderChange.g_title];
                        
                        [Scheduale_Event scheduleLocalNotificationWithDate:date_DateAndTime atIndex:[NSString stringWithFormat:@"%@",GoalForReminderChange.objectID] Description:str_Message repeat:@"Weekly"];
                        
                    }
                    else if ([GoalForReminderChange.g_savingfrequency isEqualToString:@"Monthly"])
                    {
                        NSDate *today = [NSDate date];
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setDateFormat:@"yyyy-MM"];
                        NSString *localDateString = [dateFormatter stringFromDate:today];
                        
                        NSString *str_SelectedFullDate = [NSString stringWithFormat:@"%@-%@",localDateString,GoalForReminderChange.g_reminderdate];
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
                            
                            NSString *str_SelectedFullDate = [NSString stringWithFormat:@"%ld-%02ld-%@",(long)Year,(long)Month1,GoalForReminderChange.g_reminderdate];
                            //NSLog(@"%@",str_SelectedFullDate);
                            
                            NSString *str_DateAndTime = [NSString stringWithFormat:@"%@ %@:00",str_SelectedFullDate,GoalForReminderChange.g_remindertime];
                            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                            NSDate *date_DateAndTime = [dateFormatter dateFromString:str_DateAndTime];
                            //NSLog(@"%@",date_DateAndTime);
                            
                            NSString *str_Add = [NSString stringWithFormat:NSLocalizedString(@"add Monthly contribution to goal", nil)];
                            
                            NSString *str_Message = [NSString stringWithFormat:@"%@ \"%@\"",str_Add,GoalForReminderChange.g_title];
                            
                            [Scheduale_Event scheduleLocalNotificationWithDate:date_DateAndTime atIndex:[NSString stringWithFormat:@"%@",GoalForReminderChange.objectID] Description:str_Message repeat:@"Monthly"];
                            
                        }
                        else
                        {
                            NSString *str_DateAndTime = [NSString stringWithFormat:@"%@ %@:00",str_SelectedFullDate,GoalForReminderChange.g_remindertime];
                            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                            NSDate *date_DateAndTime = [dateFormatter dateFromString:str_DateAndTime];
                            //NSLog(@"%@",date_DateAndTime);
                            NSString *str_Add = [NSString stringWithFormat:NSLocalizedString(@"add Monthly contribution to goal", nil)];
                            
                            NSString *str_Message = [NSString stringWithFormat:@"%@ \"%@\"",str_Add,GoalForReminderChange.g_title];
                            
                            [Scheduale_Event scheduleLocalNotificationWithDate:date_DateAndTime atIndex:[NSString stringWithFormat:@"%@",GoalForReminderChange.objectID] Description:str_Message repeat:@"Monthly"];
                        }
                    }
                }
            }
        }
        [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"LocalNotifReminder"];
    }
}

-(void)action_AskLock{
    if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"AppKilled"]isEqualToString:@"1"]) {
        
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"HH:mm:ss"];
//
//        NSString *str_PasscodeOnTime = [[NSString alloc]init];
//        str_PasscodeOnTime = [formatter stringFromDate:[NSDate date]];
//
//        NSDate *startDate = [formatter dateFromString:[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"PasscodeOnTime"]];
//        NSDate *endDate = [formatter dateFromString:str_PasscodeOnTime];
//
//        NSTimeInterval timeDifference = [endDate timeIntervalSinceDate:startDate];
//
//        double minutes = timeDifference / 60;
//
//        if (minutes >= 10) {
            if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"TouchID"]isEqualToString:@"ON"] && [[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"Passcode"]isEqualToString:@"ON"]){
                
                [[GoalManagerAppDelegate getdefaultvalue]setObject:@"Open" forKey:@"Alert"];
                
                LAContext *context = [[LAContext alloc] init];
                [context setLocalizedFallbackTitle:@""];
                NSError *error = nil;
                
                self.aView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIApplication sharedApplication].keyWindow.bounds.size.width, [UIApplication sharedApplication].keyWindow.bounds.size.height)];
                if (isiPhoneX) {
                    self.aView.image = [UIImage imageNamed:@"iPhone6"];
                }
                else if (isiPhone6Plus) {
                    self.aView.image = [UIImage imageNamed:@"iphone6p"];
                }
                else if (isiPhone6) {
                    self.aView.image = [UIImage imageNamed:@"iPhone6"];
                }
                else if (isiPhone5) {
                    self.aView.image = [UIImage imageNamed:@"iPhone5"];
                }
                else{
                    self.aView.image = [UIImage imageNamed:@"iphon4"];
                }
                self.aView.backgroundColor = [UIColor whiteColor];
                
                [[UIApplication sharedApplication].keyWindow addSubview:self.aView];
                
                if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
                    // Authenticate User
                    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                            localizedReason:@"Please authenticate to unlock Money Box"
                                      reply:^(BOOL success, NSError *error) {
                                          
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              
                                              if (success) {
                                                  //[[GoalManagerAppDelegate getdefaultvalue]setObject:@"Close" forKey:@"Alert"];
                                                  [self.aView removeFromSuperview];
                                                  
                                              } else {
                                                  
                                                  LockScreen_VC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LockScreen_VC"];
                                                  vc.modalPresentationStyle = UIModalPresentationCurrentContext;
                                                  vc.modalPresentationStyle = UIModalPresentationCustom;
                                                  vc.view.backgroundColor = [UIColor whiteColor];
                                                  vc.str_FromWhere = @"";
                                                  [self.navigationController presentViewController:vc animated:FALSE completion:^{
                                                      [self.aView removeFromSuperview];
                                                  }];
                                                  
//                                                  NSString *str_Message = [[NSString alloc]init];
//                                                  str_Message = [self evaluateAuthenticationPolicyMessageForLA:error.code];
//
//                                                  UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"MoneyBox" message:str_Message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//                                                  [alert3 show];
                                                  
                                              }
                                          });
                                      }];
                    
                } else {
                    
                    
                    
                    LockScreen_VC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LockScreen_VC"];
                    vc.modalPresentationStyle = UIModalPresentationCurrentContext;
                    vc.modalPresentationStyle = UIModalPresentationCustom;
                    vc.view.backgroundColor = [UIColor whiteColor];
                    vc.str_FromWhere = @"";
                    [self.navigationController presentViewController:vc animated:FALSE completion:^{
                        [self.aView removeFromSuperview];
                    }];
                    
//                    NSLog(@"%@",[self evaluateAuthenticationPolicyMessageForLA:error.code]);
//                    NSString *str_Message = [[NSString alloc]init];
//                    str_Message = [self evaluateAuthenticationPolicyMessageForLA:error.code];
//
//                    UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"MoneyBox" message:str_Message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//
//                    [alert3 show];
                }
                
            }
            else if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"TouchID"]isEqualToString:@"ON"] && [[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"Passcode"]isEqualToString:@"OFF"]){
                [[GoalManagerAppDelegate getdefaultvalue]setObject:@"Open" forKey:@"Alert"];
                LAContext *context = [[LAContext alloc] init];
                [context setLocalizedFallbackTitle:@""];
                NSError *error = nil;
                
                self.aView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIApplication sharedApplication].keyWindow.bounds.size.width, [UIApplication sharedApplication].keyWindow.bounds.size.height)];
                if (isiPhoneX) {
                    self.aView.image = [UIImage imageNamed:@"iPhone6"];
                }
                else if (isiPhone6Plus) {
                    self.aView.image = [UIImage imageNamed:@"iphone6p"];
                }
                else if (isiPhone6) {
                    self.aView.image = [UIImage imageNamed:@"iPhone6"];
                }
                else if (isiPhone5) {
                    self.aView.image = [UIImage imageNamed:@"iPhone5"];
                }
                else{
                    self.aView.image = [UIImage imageNamed:@"iphon4"];
                }
                self.aView.backgroundColor = [UIColor whiteColor];
                
                [[UIApplication sharedApplication].keyWindow addSubview:self.aView];
                
                if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
                    // Authenticate User
                    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                            localizedReason:@"Please authenticate to unlock Money Box"
                                      reply:^(BOOL success, NSError *error) {
                                          
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              
                                              if (success) {
                                                  //[[GoalManagerAppDelegate getdefaultvalue]setObject:@"Close" forKey:@"Alert"];
                                                  [self.aView removeFromSuperview];
                                                  
                                              } else {
                                                  
                                                  
                                                  
                                                  NSString *str_Message = [[NSString alloc]init];
                                                  str_Message = [self evaluateAuthenticationPolicyMessageForLA:error.code];
                                                  
                                                  UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"Touch ID" message:str_Message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                                                  alert3.tag = 1234;
                                                  [alert3 show];
                                                  
                                              }
                                          });
                                      }];
                    
                } else {
                    
                    
                    //NSLog(@"%@",[self evaluateAuthenticationPolicyMessageForLA:error.code]);
                    NSString *str_Message = [[NSString alloc]init];
                    str_Message = [self evaluateAuthenticationPolicyMessageForLA:error.code];
                    
                    UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"Touch ID" message:str_Message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                    alert3.tag = 1234;
                    [alert3 show];
                }
            }
            else if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"TouchID"]isEqualToString:@"OFF"] && [[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"Passcode"]isEqualToString:@"ON"]){
                LockScreen_VC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LockScreen_VC"];
                vc.modalPresentationStyle = UIModalPresentationCurrentContext;
                vc.modalPresentationStyle = UIModalPresentationCustom;
                vc.view.backgroundColor = [UIColor whiteColor];
                vc.str_FromWhere = @"";
                [self.navigationController presentViewController:vc animated:FALSE completion:^{}];
            }
//            [[GoalManagerAppDelegate getdefaultvalue]setObject:str_PasscodeOnTime forKey:@"PasscodeOnTime"];
//        }
        
    }
    [[GoalManagerAppDelegate getdefaultvalue]setObject:@"0" forKey:@"AppKilled"];
}

- (NSString *)evaluatePolicyFailErrorMessageForLA:(NSInteger)errorCode{
    NSString *str_Message = [[NSString alloc]init];
    
    if (@available(iOS 11.0, *)) {
        switch (errorCode) {
            case LAErrorBiometryNotAvailable:
                str_Message = @"Authentication could not start because the device does not support biometric authentication.";
                break;
            case LAErrorBiometryLockout  :
                str_Message = @"Authentication could not continue because the user has been locked out of biometric authentication, due to failing authentication too many times.";
                break;
            case LAErrorBiometryNotEnrolled  :
                str_Message = @"Authentication could not start because the user has not enrolled in biometric authentication.";
                break;
            default :
                str_Message = @"Did not find error code on LAError object";
        }
    } else {
        switch (errorCode) {
            case LAErrorTouchIDLockout:
                str_Message = @"Too many failed attempts.";
                break;
            case LAErrorTouchIDNotAvailable  :
                str_Message = @"TouchID is not available on the device";
                break;
            case LAErrorTouchIDNotEnrolled  :
                str_Message = @"TouchID is not enrolled on the device";
                break;
            default :
                str_Message = @"Did not find error code on LAError object";
        }
    }
    return str_Message;
}


- (NSString *)evaluateAuthenticationPolicyMessageForLA:(NSInteger)errorCode{
    NSString *str_Message = [[NSString alloc]init];
    
    switch (errorCode) {
        case LAErrorAuthenticationFailed:
            str_Message = @"The user failed to provide valid credentials";
            break;
        case LAErrorAppCancel  :
            str_Message = @"Authentication was cancelled by application";
            break;
        case LAErrorInvalidContext  :
            str_Message = @"The context is invalid";
            break;
        case LAErrorNotInteractive  :
            str_Message = @"Not interactive";
            break;
        case LAErrorPasscodeNotSet  :
            str_Message = @"Passcode is not set on the device";
            break;
        case LAErrorSystemCancel  :
            str_Message = @"Authentication was cancelled by the system";
            break;
        case LAErrorUserFallback  :
            str_Message = @"The user chose to use the fallback";
            break;
        case LAErrorUserCancel  :
            str_Message = @"The user did cancel";
            break;
        default :
            str_Message = [self evaluatePolicyFailErrorMessageForLA:errorCode];
            break;
    }
    
    return str_Message;
}

-(void)action_InitialScreen{
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
    
    if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InitialScreen1"] length] <=0 || [[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InitialScreen1"]isEqualToString:@"(null)"])
    {
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(action_CrossPromotion) name:@"CrossPromotion" object:nil];
        //en
        //ru
        //es
        //zh
        
        //Chiense Sim = zh-Hans-US
        //spanish = es-US
        //jajpa = ja-US
        
        NSLog(@"%@",self.language);
        
        [GoalManagerAppDelegate sharedinstance].view_InitialScreen = [[UIView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        imgView_InitialScreen = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        if ([self.language isEqualToString:@"zh-Hans"]) {
            
            if (isiPhone6Plus)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial1_6PlusCHI"];
            }
            else if (isiPhone6)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial1_6CHI"];
            }
            else if (isiPhoneX)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial1_6CHI"];
            }
            else if (isiPhone5)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial1_5CHI"];
            }
            else
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial1_4CHI"];
            }
        }
        else if ([self.language isEqualToString:@"es"]) {
            
            if (isiPhone6Plus)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial1_6PlusSPA"];
            }
            else if (isiPhone6)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial1_6SPA"];
            }
            else if (isiPhoneX)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial1_6SPA"];
            }
            else if (isiPhone5)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial1_5SPA"];
            }
            else
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial1_4SPA"];
            }
        }
        else if ([self.language isEqualToString:@"ja"]) {
            if (isiPhone6Plus)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial1_6PlusJAP"];
            }
            else if (isiPhone6)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial1_6JAP"];
            }
            else if (isiPhoneX)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial1_6JAP"];
            }
            else if (isiPhone5)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial1_5JAP"];
            }
            else
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial1_4JAP"];
            }
        }
        else{
            if (isiPhone6Plus)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial1_6PlusEN"];
            }
            else if (isiPhone6)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial1_6EN"];
            }
            else if (isiPhoneX)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial1_6EN"];
            }
            else if (isiPhone5)
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial1_5EN"];
            }
            else
            {
                imgView_InitialScreen.image = [UIImage imageNamed:@"Initial1_4EN"];
            }
        }
        
        [[GoalManagerAppDelegate sharedinstance].view_InitialScreen addSubview:imgView_InitialScreen];
        [[UIApplication sharedApplication].keyWindow addSubview:[GoalManagerAppDelegate sharedinstance].view_InitialScreen];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
        [Localytics tagEvent:@"Purchased Successfully"];
        [Flurry logEvent:@"Purchased Successfully"];
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


#pragma mark - All User Defined Functions

- (IBAction)action_Lock:(UIButton *)sender {
    
    NSMutableArray *muary_TotalActiveGoal = [NSMutableArray arrayWithArray:[Goal MR_findAll]];
    
    if (muary_TotalActiveGoal.count == 1)
    {
        
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Goal", nil) message:NSLocalizedString(@"You can have only two active goals in free version. To have unlimited number of active goals and more upgrade to Pro version", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"CANCEL", nil) otherButtonTitles:NSLocalizedString(@"Upgrade", nil),nil];
        alert.tag = 1988;
        [alert show];
    }
    
    
}
- (IBAction)action_AddGoal:(id)sender
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
    
    NSMutableArray *muary_TotalActiveGoal = [NSMutableArray arrayWithArray:[Goal MR_findAll]];
    
    if (muary_TotalActiveGoal.count>=2)
    {
        if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InAppPurchase"] isEqualToString:@"1"])
        {
            AddGoal_ViewController *obj_AddGoal_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"AddGoal_ViewController"];
            [self.navigationController pushViewController:obj_AddGoal_ViewController animated:YES];
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
        AddGoal_ViewController *obj_AddGoal_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"AddGoal_ViewController"];
        [self.navigationController pushViewController:obj_AddGoal_ViewController animated:YES];
    }
}

-(IBAction)action_FilterGoal:(id)sender
{
//    LAContext *context = [[LAContext alloc] init];
//    [context setLocalizedFallbackTitle:@""];
//    NSError *error = nil;
//
//    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
//        // Authenticate User
//        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
//                localizedReason:@"Are you the device owner?"
//                          reply:^(BOOL success, NSError *error) {
//
//
//
//                              if (success) {
//
//
//                              } else {
//                                  NSLog(@"%@",[self evaluateAuthenticationPolicyMessageForLA:error.code]);
//                                  exit (0);
//                              }
//
//                          }];
//
//    } else {
//
//         NSLog(@"%@",[self evaluateAuthenticationPolicyMessageForLA:error.code]);
//        exit (0);
//
//    }
    
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
//    [self presentSemiViewController:obj_Filter_ViewController withOptions:@{KNSemiModalOptionKeys.pushParentBack : @(NO),KNSemiModalOptionKeys.parentAlpha : @(1.0),KNSemiModalOptionKeys.animationDuration:@(0.2)}];
}

-(void)action_Alert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                    message:@"You are the device owner!"
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}



- (IBAction)action_Settings:(id)sender
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
            [[GoalManagerAppDelegate getdefaultvalue]setObject: @"3" forKey:@"AdView"];
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
    
//    AboutApp_ViewController *obj_Settings_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"AboutApp_ViewController"];
//    
//    [self.navigationController pushViewController:obj_Settings_ViewController animated:YES];
    
    Settings_ViewController *obj_Settings_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"Settings_ViewController"];
    
    [self.navigationController pushViewController:obj_Settings_ViewController animated:YES];
}

-(IBAction)action_CompletedGoals:(id)sender
{
    NSMutableArray *muary_completedGoal = [[NSMutableArray alloc]init];
    NSString *str_Completed = @"Completed";
    NSPredicate *predict_Completed = [NSPredicate predicateWithFormat:@"g_completedstatus == %@",str_Completed];
    [muary_completedGoal addObjectsFromArray:[Goal MR_findAllWithPredicate:predict_Completed]];
    
    if (muary_completedGoal.count > 0)
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
        
        CompletedGoal_ViewController *obj_CompletedGoal_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"CompletedGoal_ViewController"];
        UINavigationController *nav_CompletedGoal_ViewController = [[UINavigationController alloc]initWithRootViewController:obj_CompletedGoal_ViewController];
        nav_CompletedGoal_ViewController.navigationBar.translucent = NO;
        [self.navigationController presentViewController:nav_CompletedGoal_ViewController animated:YES completion:nil];
    }
    else
    {
        NSString *str_AlertTitle = [[NSString alloc]init];
        NSString *str_AlertText = [[NSString alloc]init];
        
        str_AlertTitle = [NSString stringWithFormat:NSLocalizedString(@"Goal", nil)];
        str_AlertText = [NSString stringWithFormat:NSLocalizedString(@"No goal completed", nil)];
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:str_AlertTitle message:str_AlertText delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alert show];
    }
    
}

-(IBAction)action_TotalForAllActiveGoals:(id)sender
{
    [self Total];
    //[self performSelectorInBackground:@selector(Total) withObject:nil];
}

-(void)Total
{
    NSMutableArray *muary_TotalForAllActiveGoals = [[NSMutableArray alloc]init];
    NSString *str_Status = @"Not Completed";
    NSPredicate *m = [NSPredicate predicateWithFormat:@"(g_completedstatus == %@)",str_Status];
    [muary_TotalForAllActiveGoals addObjectsFromArray:[Goal MR_findAllWithPredicate:m]];
    double GoalTotal = 0.0;
    double ContributionTotal = 0.0;
    
    for (int i = 0; i<muary_TotalForAllActiveGoals.count; i++)
    {
        double current_goal_total = 0.0;
        
        Goal *TotalForAllActiveGoals = [muary_TotalForAllActiveGoals objectAtIndex:i];
        id a = TotalForAllActiveGoals.objectID;
        NSPredicate *m = [NSPredicate predicateWithFormat:@"(r_goal == %@)",a];
        
        NSMutableArray *muary_TotalOfContribution = [[NSMutableArray alloc]init];
        [muary_TotalOfContribution addObjectsFromArray:[Contribution MR_findAllWithPredicate:m]];
        
        
        if (![[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"MasterCurrencyCode"] isEqualToString:@"ALL"] && ![[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"MasterCurrencyCode"] isEqualToString:[NSString stringWithFormat:@"%@",TotalForAllActiveGoals.g_currency]])
        {
            NSMutableArray *muary_CurrencyConvert = [[NSMutableArray alloc]init];
            
            muary_CurrencyConvert = [[GoalManagerAppDelegate getdefaultvalue]objectForKey:@"CurrencyConvert"];
            
            NSLog(@"%@",muary_CurrencyConvert);
            
            if (muary_CurrencyConvert.count > 0) {
                
                NSString *str_MasterRate = [NSString stringWithFormat:@"USD%@",[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"MasterCurrencyCode"]];
                
                NSString *str_SubRate = [NSString stringWithFormat:@"USD%@",TotalForAllActiveGoals.g_currency];
                
                NSString* currentExchangeMasterRate = [NSString stringWithFormat:@"%@",[muary_CurrencyConvert valueForKey:str_MasterRate]];
                NSString* currentExchangeSubRate = [NSString stringWithFormat:@"%@",[muary_CurrencyConvert valueForKey:str_SubRate]];
                
                NSLog(@"%@",currentExchangeMasterRate);
                NSLog(@"%@",currentExchangeSubRate);
                
                if (currentExchangeMasterRate && currentExchangeSubRate) {
                    
                    double exchangeRateMasterValue = [currentExchangeMasterRate doubleValue];
                    double exchangeRateSubValue = [currentExchangeSubRate doubleValue];
                    
                    NSLog(@"Exchange rate is %lf", exchangeRateMasterValue);
                    NSLog(@"Exchange rate is %lf", exchangeRateSubValue);
                    
                    current_goal_total = ([TotalForAllActiveGoals.g_amount doubleValue] * exchangeRateMasterValue) / exchangeRateSubValue;
                    
                    for (int j = 0; j<muary_TotalOfContribution.count; j++)
                    {
                        Contribution *GoalContribution = [muary_TotalOfContribution objectAtIndex:j];
                        ContributionTotal += ([GoalContribution.c_amount doubleValue] * exchangeRateMasterValue) / exchangeRateSubValue;
                    }
                }
                
                BOOL isInternet1 = [GoalManagerAppDelegate connectedToNetwork];
                if (isInternet1 == TRUE)
                {

                    [self performSelectorInBackground:@selector(action_InternetTotal) withObject:nil];
                    
                    //                NSString *str_URL = [NSString stringWithFormat:@"http://rate-exchange.herokuapp.com/fetchRate?from=%@&to=%@",[NSString stringWithFormat:@"%@",TotalForAllActiveGoals.g_currency], [[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"MasterCurrencyCode"]];
                    //
                    //                NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString:str_URL]];
                    //
                    //                NSError* error;
                    //                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                    //
                    //                NSString * str_convert_rate= [json objectForKey:@"Rate"];
                    //
                    //
                    //                current_goal_total = [TotalForAllActiveGoals.g_amount doubleValue] * [str_convert_rate doubleValue];
                    //
                    //                for (int j = 0; j<muary_TotalOfContribution.count; j++)
                    //                {
                    //                    Contribution *GoalContribution = [muary_TotalOfContribution objectAtIndex:j];
                    //                    ContributionTotal += [GoalContribution.c_amount doubleValue] * [str_convert_rate doubleValue];
                    //                }
                }
                else
                {
                    
//                    NSString *str_MasterRate = [NSString stringWithFormat:@"USD%@",[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"MasterCurrencyCode"]];
//
//                    NSString *str_SubRate = [NSString stringWithFormat:@"USD%@",TotalForAllActiveGoals.g_currency];
//
//                    NSString* currentExchangeMasterRate = [NSString stringWithFormat:@"%@",[muary_CurrencyConvert valueForKey:str_MasterRate]];
//                    NSString* currentExchangeSubRate = [NSString stringWithFormat:@"%@",[muary_CurrencyConvert valueForKey:str_SubRate]];
//
//                    NSLog(@"%@",currentExchangeMasterRate);
//                    NSLog(@"%@",currentExchangeSubRate);
//
//                    if (currentExchangeMasterRate && currentExchangeSubRate) {
//
//                        double exchangeRateMasterValue = [currentExchangeMasterRate doubleValue];
//                        double exchangeRateSubValue = [currentExchangeSubRate doubleValue];
//
//                        NSLog(@"Exchange rate is %lf", exchangeRateMasterValue);
//                        NSLog(@"Exchange rate is %lf", exchangeRateSubValue);
//
//                        current_goal_total = ([TotalForAllActiveGoals.g_amount doubleValue] * exchangeRateMasterValue) / exchangeRateSubValue;
//
//                        for (int j = 0; j<muary_TotalOfContribution.count; j++)
//                        {
//                            Contribution *GoalContribution = [muary_TotalOfContribution objectAtIndex:j];
//                            ContributionTotal += ([GoalContribution.c_amount doubleValue] * exchangeRateMasterValue) / exchangeRateSubValue;
//                        }
//                    }
                    
                    //                    self.view_Totals.hidden = TRUE;
                    //                    [[GoalManagerAppDelegate getdefaultvalue]setObject:@"OFF" forKey:@"ShowTotals"];
                    //                    break;
                    //                    return;
                    
                }
            }
            else{
                self.view_Totals.hidden = TRUE;
                [[GoalManagerAppDelegate getdefaultvalue]setObject:@"OFF" forKey:@"ShowTotals"];
                break;
                return;
            }
            
            
        }
        else
        {
            current_goal_total = [TotalForAllActiveGoals.g_amount doubleValue];
            
            for (int j = 0; j<muary_TotalOfContribution.count; j++)
            {
                Contribution *GoalContribution = [muary_TotalOfContribution objectAtIndex:j];
                ContributionTotal += [GoalContribution.c_amount doubleValue];
            }
        }
        
        
        GoalTotal += current_goal_total;
        
    }
    
    NSString *str_ContributionTotal = [NSString stringWithFormat:@"%.2f",ContributionTotal];
    str_ContributionTotal=[GoalManagerAppDelegate Change_String_Formate:str_ContributionTotal];
    NSString *str_GoalTotal = [NSString stringWithFormat:@"%.2f",GoalTotal];
    str_GoalTotal=[GoalManagerAppDelegate Change_String_Formate:str_GoalTotal];
    
    NSLog(@"%.2f",GoalTotal);
    double total = 0.0;
    double recent = 0.0;
    double per = 0.0;
    
    if (GoalTotal == 0.00)
    {
        per = 0.00;
    }
    else
    {
        total=GoalTotal;
        
        recent=ContributionTotal;
        
        per=recent*100/total;
    }
    
    lbl_TotalForAllActiveGoals.text = [NSString stringWithFormat:@"%@ (%.2f%%) of %@ %@",str_ContributionTotal,per,str_GoalTotal,[[GoalManagerAppDelegate getdefaultvalue] valueForKey:@"MasterCurrencyCode"]];
    double len = 0.0;
    
    if (isiPhone6)
    {
        len=per*337/100;
    }
    else if (isiPhoneX)
    {
        len=per*337/100;
    }
    else if (isiPhone6Plus)
    {
        len=per*374/100;
    }
    else
    {
        len=per*280/100;
    }
    view_InnerTotalForAllActiveGoals.frame=CGRectMake(view_InnerTotalForAllActiveGoals.frame.origin.x,view_InnerTotalForAllActiveGoals.frame.origin.y,0,view_InnerTotalForAllActiveGoals.frame.size.height);
    
    //    CGRect frame = view_InnerTotalForAllActiveGoals.frame;
    //    if (isiPhone5)
    //        frame.size.width = len;
    //    else if (isiPhone6)
    //        frame.size.width = len;
    //    else if (isiPhone6Plus)
    //        frame.size.width = len;
    //    else
    //        frame.size.width = len;
    //
    //    view_InnerTotalForAllActiveGoals.frame = frame;
    
    [UIView animateWithDuration:3
                     animations:^
     {
         CGRect frame = view_InnerTotalForAllActiveGoals.frame;
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
         
         view_InnerTotalForAllActiveGoals.frame = frame;
         
     } completion:nil];
    
    
}

-(void)action_InternetTotal{
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    NSString *str_DateCurrency = [[NSString alloc]init];
    str_DateCurrency = [dateFormatter stringFromDate:[NSDate date]];
    
    
    if (![[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"DATECURRENCY"] isEqualToString:str_DateCurrency]){
        
        NSString* queryString = [NSString stringWithFormat:@"http://apilayer.net/api/live?access_key=8b0a198a1f6ac344c336996d9debf9f0"];
        
        //queryString = [queryString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        NSData* exchangeRateJSON = [[NSString stringWithContentsOfURL:[NSURL URLWithString:queryString]
                                                             encoding:NSUTF8StringEncoding
                                                                error:nil] dataUsingEncoding:NSUTF8StringEncoding];
        
        // Check that the JSON is valid
        if (exchangeRateJSON) {
            NSDictionary* exchangeRateData = [NSJSONSerialization JSONObjectWithData:exchangeRateJSON options:0 error:nil];
            NSLog(@"%@",exchangeRateData);
            // Check that the JSON contains valid data for the fields
            if (exchangeRateData && exchangeRateData[@"quotes"]) {
                //NSString *str_MasterRate = [NSString stringWithFormat:@"USD%@",[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"MasterCurrencyCode"]];
                NSMutableArray *muary = [[NSMutableArray alloc]init];
                muary = exchangeRateData[@"quotes"];
                
                [[GoalManagerAppDelegate getdefaultvalue]setObject:[muary mutableCopy] forKey:@"CurrencyConvert"];
                
                NSLog(@"%@",[[GoalManagerAppDelegate getdefaultvalue]objectForKey:@"CurrencyConvert"]);
                
                NSLog(@"%lu",(unsigned long)muary.count);
                
                [[GoalManagerAppDelegate getdefaultvalue]setObject:str_DateCurrency forKey:@"DATECURRENCY"];
                
                [self Total];
                //[self performSelectorInBackground:@selector(Total) withObject:nil];
                //                            NSString *str_SubRate = [NSString stringWithFormat:@"USD%@",TotalForAllActiveGoals.g_currency];
                //
                //                            NSLog(@"%@",str_MasterRate);
                //                            NSLog(@"%@",str_SubRate);
                //
                //                            NSString* currentExchangeMasterRate = exchangeRateData[@"quotes"][str_MasterRate];
                //                            NSString* currentExchangeSubRate = exchangeRateData[@"quotes"][str_SubRate];
                //
                //
                //
                //                            NSLog(@"%@",currentExchangeMasterRate);
                //                            NSLog(@"%@",currentExchangeSubRate);
                //
                //                            if (currentExchangeMasterRate && currentExchangeSubRate) {
                //
                //                                double exchangeRateMasterValue = [currentExchangeMasterRate doubleValue];
                //                                double exchangeRateSubValue = [currentExchangeSubRate doubleValue];
                //
                //                                NSLog(@"Exchange rate is %lf", exchangeRateMasterValue);
                //                                NSLog(@"Exchange rate is %lf", exchangeRateSubValue);
                //
                //                                current_goal_total = ([TotalForAllActiveGoals.g_amount doubleValue] * exchangeRateMasterValue) / exchangeRateSubValue;
                //
                //                                for (int j = 0; j<muary_TotalOfContribution.count; j++)
                //                                {
                //                                    Contribution *GoalContribution = [muary_TotalOfContribution objectAtIndex:j];
                //                                    ContributionTotal += ([GoalContribution.c_amount doubleValue] * exchangeRateMasterValue) / exchangeRateSubValue;
                //                                }
                //                            }
                //                        }
            }
        }
        
    }
    
    
    
}

#pragma mark All Delegates

#pragma mark - Core data functions

- (NSFetchedResultsController *)fetchedResultsController {
    if (!_fetchedResultsController )
    {
        NSString *str_Completed = @"Not Completed";
        
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
        
    }
    
    return _fetchedResultsController;
}

#pragma mark tableView code

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
        NSDate *date = [dateFormatter1 dateFromString:GoalDescription.g_targetdate];
        
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
            cell.lbl_OverdueText.text = [NSString stringWithFormat:NSLocalizedString(@"Goal overdue", nil)];
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM dd, yyyy"];
        NSString *localDateString = [dateFormatter stringFromDate:date];
        NSString *str_By = [NSString stringWithFormat:NSLocalizedString(@"By", nil)];
        cell.lbl_TargetDate.text = [NSString stringWithFormat:@"%@ %@",str_By,localDateString];
        
        if ([self.language isEqualToString:@"zh-Hans"]) {
            
            NSLog(@"%@",localDateString);
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            
            [dateFormatter setDateFormat:@"yyyy年M月d日'"];
            NSString *localDateString = [dateFormatter stringFromDate:date];
            cell.lbl_TargetDate.text = [NSString stringWithFormat:@"%@",localDateString];
            NSLog(@"%@",localDateString);
        }
        else{
            cell.lbl_TargetDate.text = [NSString stringWithFormat:@"%@ %@",str_By,localDateString];
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
        id a = GoalDescription.objectID;
        NSPredicate *m = [NSPredicate predicateWithFormat:@"(r_goal == %@)",a];
        
        NSMutableArray *muary_TotalOfContribution = [[NSMutableArray alloc]init];
        [muary_TotalOfContribution addObjectsFromArray:[Contribution MR_findAllWithPredicate:m]];
        
        double TotalOfContribution = 0.0;
        for (int i = 0; i<muary_TotalOfContribution.count; i++)
        {
            Contribution *GoalContribution = [muary_TotalOfContribution objectAtIndex:i];
            TotalOfContribution += [GoalContribution.c_amount doubleValue];
        }
        
        double goalTotal = [GoalDescription.g_amount doubleValue];
        NSString *str_GoalTotal = [NSString stringWithFormat:@"%.2f",goalTotal];
        str_GoalTotal=[GoalManagerAppDelegate Change_String_Formate:str_GoalTotal];
        
        NSString *str_ContributionTotal = [NSString stringWithFormat:@"%.2f",TotalOfContribution];
        str_ContributionTotal=[GoalManagerAppDelegate Change_String_Formate:str_ContributionTotal];
        
        double total=[GoalDescription.g_amount doubleValue];
        
        double recent=TotalOfContribution;
        
        double per=recent*100/total;
        
        cell.lbl_Amount.text = [NSString stringWithFormat:@"%@ (%.2f%%) of %@ %@",str_ContributionTotal,per,str_GoalTotal,GoalDescription.g_currency];
        
        NSLog(@"%.2f",per);
        
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
                             else if (isiPhoneX)
                                 frame.size.width = len;
                             else if (isiPhone6Plus)
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
    if (indexPath.row%2==0)
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
        
        NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row/2 inSection:indexPath.section];
        GoalOverview_ViewController *obj_GoalOverview_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"GoalOverview_ViewController"];
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
            Goal *delete_Goal = [self.fetchedResultsController objectAtIndexPath:index];
            
            NSString *str_ObjectID = [NSString stringWithFormat:@"%@",delete_Goal.objectID];
            [Scheduale_Event CancelExistingNotification:str_ObjectID];
            
            [[self.fetchedResultsController objectAtIndexPath:index] MR_deleteEntity];
            
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
                if (!error)
                {
                    [self viewWillAppear:NO];
                    [self action_TotalForAllActiveGoals:self];
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
    }
    
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    _fetchedResultsController = nil;
    [self.tbl_GoalLists reloadData];
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
        [self.tbl_GoalLists reloadData];
    }
    NSLog(@"Index = %ld - Title = %@", (long)buttonIndex, [actionSheet buttonTitleAtIndex:buttonIndex]);
}

#pragma mark - AdViewDelegates


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (alertView.tag == 1988)
    {
        if (buttonIndex == 1)
        {
            [Flurry logEvent:@"Click Upgrade on message box"];
            [Localytics tagEvent:@"Click Upgrade on message box"];
            Settings_ViewController *obj_Settings_ViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"Settings_ViewController"];
            [self.navigationController pushViewController:obj_Settings_ViewController animated:YES];
        }
    }
    else if (alertView.tag == 1234){
        
        if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"PasscodeSet"]isEqualToString:@"Yes"]){
            if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"Passcode"]isEqualToString:@"OFF"]){
                
                
                LockScreen_VC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LockScreen_VC"];
                vc.modalPresentationStyle = UIModalPresentationCurrentContext;
                vc.modalPresentationStyle = UIModalPresentationCustom;
                vc.view.backgroundColor = [UIColor whiteColor];
                vc.str_FromWhere = @"";
                [self.navigationController presentViewController:vc animated:FALSE completion:^{
                    [self.aView removeFromSuperview];
                }];
            }
        }
        else{
            [[GoalManagerAppDelegate getdefaultvalue]setObject:@"1" forKey:@"AppKilled"];
            exit(0);
        }
    }
}

-(IBAction)show_big_ad:(id)sender
{
    
}

- (void)createAndLoadInterstitial
{
    _interstitial =
    [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-5298130731078005/2952392171"];
    _interstitial.delegate=self;
    
    GADRequest *request = [GADRequest request];
    //request.testDevices = @[ @"e33953a7d4e4e4fbac2a3e08d60e4f9db7abcdfa",@"5ea9b4596c02afa71d125dd9f560d671d5935c3e"];
    [_interstitial loadRequest:request];
    
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    if ([[[GoalManagerAppDelegate getdefaultvalue]valueForKey:@"InitialScreen1"]isEqualToString:@"1"]) {
       [_interstitial presentFromRootViewController:self];
    }
    [[UIApplication sharedApplication]setStatusBarHidden:FALSE];
}




@end
