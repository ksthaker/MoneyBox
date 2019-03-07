//
//  AboutApp_ViewController.m
//  MoneyBoxFREE
//
//  Created by apple on 10/01/17.
//  Copyright © 2017 whitelotuscorporation. All rights reserved.
//

#import "AboutApp_ViewController.h"
#import "Cell_AboutApp.h"
#import "GoalManager.h"
#import "GoalManagerAppDelegate.h"
#import "Cell_AboutAppPromotion.h"
@interface AboutApp_ViewController ()

@end

@implementation AboutApp_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"About App", nil);
    
    UIImage* image2 = [UIImage imageNamed:@"navbar_cancel.png"];
    CGRect frameimg2 = CGRectMake(0, 0,22,22);
    UIButton *someButton2 = [[UIButton alloc] initWithFrame:frameimg2];
    [someButton2 setBackgroundImage:image2 forState:UIControlStateNormal];
    [someButton2 addTarget:self action:@selector(action_Back:)
          forControlEvents:UIControlEventTouchUpInside];
    [someButton2 setSelected:YES];
    
    UIBarButtonItem *btn_Close= [[UIBarButtonItem alloc]initWithCustomView:someButton2];
    
    NSArray *arr_Cancel= [[NSArray alloc] initWithObjects:btn_Close,nil];
    self.navigationItem.leftBarButtonItems = arr_Cancel;
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    // Setting the swipe direction.
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *majorVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    self.lbl_Name.text = [NSString stringWithFormat:@"Plan, visualize, track and achieve your savings goals\nv.%@",majorVersion];
    
    self.muary_AboutApp =[NSMutableArray arrayWithObjects:
                          [NSDictionary dictionaryWithObjectsAndKeys:
                           @"fb",@"image",NSLocalizedString(@"facebook.com/getmoneyboxapp", nil),@"name",
                           nil],
                          [NSDictionary dictionaryWithObjectsAndKeys:
                           @"web",@"image",NSLocalizedString(@"moneybox.mobi", nil),@"name",
                           nil],
                          [NSDictionary dictionaryWithObjectsAndKeys:
                           @"mail",@"image",NSLocalizedString(@"Send Feedback", nil),@"name",
                           nil],
                          [NSDictionary dictionaryWithObjectsAndKeys:
                           @"tell_friend",@"image",NSLocalizedString(@"Tell a friend", nil),@"name",
                           nil],
                          [NSDictionary dictionaryWithObjectsAndKeys:
                           @"rate",@"image",NSLocalizedString(@"Rate this App", nil),@"name",
                           nil],nil];
    
    
    self.muary_AboutAppLink =[NSMutableArray arrayWithObjects:
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"debitapp",@"imagelink",NSLocalizedString(@"Debt Free Box - Pay off debts with Snowball method", nil),@"maintitle",NSLocalizedString(@"Pay off debts! Fast and simple!", nil),@"subtitle",@"https://itunes.apple.com/us/app/debt-free-box-snowball/id1240710873?ls=1&mt=8",@"link",@"Open_Debt_Free_Box",@"event",
                               nil],
                              
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"budgetboxapp",@"imagelink",NSLocalizedString(@"Budget Box - Expense Tracker", nil),@"maintitle",NSLocalizedString(@"Track your money", nil),@"subtitle",@"https://itunes.apple.com/us/app/budget-box-expense-tracker/id1234941976?ls=1&mt=8",@"link",@"Open_Budget_Box",@"event",
                               nil],
                              [NSDictionary dictionaryWithObjectsAndKeys:
                               @"billyboxapp",@"imagelink",NSLocalizedString(@"Billy Box: Bills Monitor", nil),@"maintitle",NSLocalizedString(@"Pay bills. On time. Save.", nil),@"subtitle",@"https://itunes.apple.com/us/app/billy-box-bills-monitor/id1343796211?ls=1&mt=8",@"link",@"Open_Billy_Box",@"event",
                               nil],nil];
    
    self.imgView_Logo.layer.cornerRadius = 15;
    self.imgView_Logo.clipsToBounds = YES;
    self.imgView_Logo_debit_app.layer.cornerRadius = 15;
    self.imgView_Logo_debit_app.clipsToBounds = YES;
    self.get_debit_app.layer.cornerRadius = 5;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
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




#pragma mark UISwipeGestureRecognizer METHOD

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark All Delegate Methods

#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        return self.muary_AboutApp.count;
    }
    else
    {
        return self.muary_AboutAppLink.count;
    }
}

-(nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *customTitleView = [ [UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 40)];
    customTitleView.backgroundColor=[UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];
    
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 0, tableView.bounds.size.width-15, 40)];
    
    if (section == 0) {
        titleLabel.text=[NSString stringWithFormat:@"FEEDBACK"];
    }
    else{
        titleLabel.text=[NSString stringWithFormat:@"MORE FROM US"];
    }
    
    
    
    
    
    titleLabel.textColor=[UIColor colorWithRed:155.0/255.0 green:173.0/255.0 blue:179.0/255.0 alpha:1.0];
    titleLabel.font=[UIFont fontWithName:@"SFUIDisplay-Medium" size:11];
    titleLabel.backgroundColor=[UIColor clearColor];
    [customTitleView addSubview:titleLabel];
    return customTitleView;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *simpleTableIdentifier = @"Cell_AboutApp";
        
        Cell_AboutApp *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        cell.lbl_Title.text = [[self.muary_AboutApp objectAtIndex:indexPath.row]valueForKey:@"name"];
        
        cell.imgView_Symbol.image = [UIImage imageNamed:[[self.muary_AboutApp objectAtIndex:indexPath.row]valueForKey:@"image"]];
        
        
        if (indexPath.row == self.muary_AboutApp.count - 1)
        {
            cell.line_label.hidden = true;
        }
        else
        {
            cell.line_label.hidden = false;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else{
        static NSString *simpleTableIdentifier = @"Cell_AboutAppPromotion";
        
        Cell_AboutAppPromotion *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
//        cell.lbl_TitleLink.text = [[self.muary_AboutAppLink objectAtIndex:indexPath.row]valueForKey:@"maintitle"];
//        cell.lbl_SubTitleLink.text = [[self.muary_AboutAppLink objectAtIndex:indexPath.row]valueForKey:@"subtitle"];
        
        NSString *str1 = [[self.muary_AboutAppLink objectAtIndex:indexPath.row]valueForKey:@"maintitle"];
        
        NSString *cardName = [[self.muary_AboutAppLink objectAtIndex:indexPath.row]valueForKey:@"subtitle"];
        
        NSString *text = [NSString stringWithFormat:@"%@\n%@",str1,cardName];
        
        
        // Define general attributes for the entire text
        UIFont *font = [[UIFont alloc]init];
        
        
        if (isiPhone6 || isiPhoneX || isiPhone6Plus) {
            font = [UIFont fontWithName:@"SFUIDisplay-Light" size:14.0];
        }
        else{
            font = [UIFont fontWithName:@"SFUIDisplay-Light" size:12.0];
        }
        
        
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0],
                                  NSFontAttributeName: font
                                  };
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text attributes:attribs];
        
        
        UIFont *boldFont = [[UIFont alloc]init];
        
        
        if (isiPhone6 || isiPhoneX || isiPhone6Plus) {
            boldFont = [UIFont fontWithName:@"SFUIDisplay-Medium" size:15.0];
        }
        else{
            boldFont = [UIFont fontWithName:@"SFUIDisplay-Medium" size:13.0];
        }
        NSRange range = [text rangeOfString:str1];
        [attributedText setAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0],
                                        NSFontAttributeName:boldFont} range:range];
        
        cell.lbl_TitleLink.attributedText = attributedText;
        
        [cell.lbl_TitleLink sizeToFit];
        
        cell.imgView_SymbolLink.image = [UIImage imageNamed:[[self.muary_AboutAppLink objectAtIndex:indexPath.row]valueForKey:@"imagelink"]];
        
        cell.btn_Get.tag = indexPath.row;
        
        cell.imgView_SymbolLink.layer.cornerRadius = 15;
        cell.imgView_SymbolLink.clipsToBounds = YES;
        
        cell.btn_GetSmall.layer.cornerRadius = 5;
        cell.btn_GetSmall.clipsToBounds = YES;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0)
        {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://www.facebook.com/getmoneyboxapp"]];
        }
        else if (indexPath.row == 1)
        {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://moneybox.mobi/"]];
        }
        else if (indexPath.row == 2)
        {
            if ([MFMailComposeViewController canSendMail])
            {
                MFMailComposeViewController *mailComposeViewController = [[MFMailComposeViewController alloc] init];
                mailComposeViewController.mailComposeDelegate = self;
                
                [mailComposeViewController setToRecipients:[NSArray arrayWithObjects:@"getmoneyboxapp@gmail.com", nil]];
                [mailComposeViewController setSubject:[[NSString alloc] initWithFormat:@"Money Box Feedback"]];
                //            [mailComposeViewController setMessageBody:[[NSString alloc] initWithFormat:@"Please see attachment for Transactions of account %@",account_ExportData.name]isHTML:YES];
                
                mailComposeViewController.delegate = self;
                //            NSDate *TodaysDate = [NSDate date];
                //            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                //            [dateFormatter setDateFormat:@"MM.dd.yy"];
                //            NSString *str_TodaysDate = [dateFormatter stringFromDate:TodaysDate];
                //
                //            NSString *str_csvName=[[NSString alloc] initWithFormat:@"%@-%@.csv",account_ExportData.name,str_TodaysDate];
                //            NSMutableData *csvData = [NSMutableData dataWithContentsOfFile:[self get_CSV_FilePath:str_csvName]];
                //            [mailComposeViewController addAttachmentData:csvData mimeType:@"application/text" fileName:str_csvName];
                
                
                [[mailComposeViewController navigationBar] setTintColor: [UIColor whiteColor]];
                
                [self.navigationController presentViewController:mailComposeViewController animated:YES completion:^{
                    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
                }];
            }
            else
            {
                UIAlertView *alert_Send=[[UIAlertView alloc] initWithTitle:nil message:@"Please add an email account from ios device setting" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert_Send show];
            }
            
        }
        
        else if (indexPath.row == 3)
        {
            if(![MFMessageComposeViewController canSendText])
            {
                UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [warningAlert show];
                return;
            }
            
            NSArray *recipents = @[];
            NSString *message = [NSString stringWithFormat:@"Check out Money Box Savings Goals App: http://onelink.to/moneybox"];
            
            MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
            messageController.messageComposeDelegate = self;
            [messageController setRecipients:recipents];
            [messageController setBody:message];
            
            // Present message view controller on screen
            [self presentViewController:messageController animated:YES completion:nil];
            
        }
        else if (indexPath.row == 4)
        {
            NSString *appId = @"959555672";
            NSString *templateReviewURL = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=APP_ID";
            NSString *templateReviewURLiOS7 = @"itms-apps://itunes.apple.com/app/idAPP_ID";
            //NSString *templateReviewURLiOS8 = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=APP_ID&onlyLatestVersion=false&pageNumber=0&sortOrdering=1&type=Purple+Software";
            NSString *templateReviewURLNew = @"https://itunes.apple.com/us/app/money-box-savings-goals/idAPP_ID?mt=8&action=write-review";
            NSString *reviewURL = [templateReviewURL stringByReplacingOccurrencesOfString:@"APP_ID" withString:appId];
            NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?bundleId=%@", appId]];
            NSData* data = [NSData dataWithContentsOfURL:url];
            NSDictionary* lookup = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            if ([lookup[@"resultCount"] integerValue] == 1)
            {
                NSString* appStoreVersion = lookup[@"results"][0][@"version"];
                NSLog(@"%@",appStoreVersion);
            }
            
            float systemversion = [[[UIDevice currentDevice] systemVersion] floatValue];
            if (systemversion >= 7.0 && systemversion < 8.0)
            {
                reviewURL = [templateReviewURLiOS7 stringByReplacingOccurrencesOfString:@"APP_ID" withString:appId];
            }
            else if (systemversion >= 8.0)
            {
                reviewURL = [templateReviewURLNew stringByReplacingOccurrencesOfString:@"APP_ID" withString:appId];
            }
            NSLog(@"%@",reviewURL);
            //            itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=YOUR_APP_ID&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:reviewURL]];
        }
    }
    else{
        
    }
    
    if (tableView == self.tbl_AboutApp) {
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        if (isiPhone4)
        {
            return 40;
        }
        else
        {
            return 44;
        }
    }
    else{
        return 80;
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
        {
            break;
        }
        case MFMailComposeResultFailed:
            break;
        default:
            break;
    }
    
   
    [controller dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result)
    {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)action_Get:(UIButton *)sender
{
    [Localytics tagEvent:[[self.muary_AboutAppLink objectAtIndex:sender.tag]valueForKey:@"event"]];
    [Flurry logEvent:[[self.muary_AboutAppLink objectAtIndex:sender.tag]valueForKey:@"event"]];
    [FIRAnalytics logEventWithName:[[self.muary_AboutAppLink objectAtIndex:sender.tag]valueForKey:@"event"]
                        parameters:nil];
    
    if([[UIDevice currentDevice].systemVersion floatValue] >= 10.0)
    {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[[self.muary_AboutAppLink objectAtIndex:sender.tag]valueForKey:@"link"]]
                                          options:[NSDictionary dictionary]
                                completionHandler:nil];
    }
    else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[self.muary_AboutAppLink objectAtIndex:sender.tag]valueForKey:@"link"]]];
    }

}
@end
