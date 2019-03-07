//
//  ConfirmPin_VC.m
//  MoneyBoxFREE
//
//  Created by Maulik on 27/07/18.
//  Copyright © 2018 whitelotuscorporation. All rights reserved.
//

#import "ConfirmPin_VC.h"

@interface ConfirmPin_VC ()

@end

@implementation ConfirmPin_VC

@synthesize btn_0,btn_1,btn_2,btn_3,btn_4,btn_5,btn_6,btn_7,btn_8,btn_9,btn_clear,btn_delete;

@synthesize view_Lock;

@synthesize lbl_1,lbl_2,lbl_3,lbl_4;

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *border_color=[UIColor colorWithRed:61.0/255.0 green:63.0/255.0 blue:83.0/255.0 alpha:1.0];
    
    self.navigationController.navigationBar.hidden=YES;
    float border_width=2.0;
    float corner_redius = 0.0;
    if (isiPhoneX || isiPhone6Plus) {
        corner_redius=37.5;
    }
    else{
        corner_redius=33.0;
    }
    
    [btn_clear setExclusiveTouch:YES];
    [btn_delete setExclusiveTouch:YES];
    NSArray *ary_button=[NSArray arrayWithObjects:btn_1,btn_2,btn_3,btn_4,btn_5,btn_6,btn_7,btn_8,btn_9,btn_0, nil];
    for(int i=0;i<ary_button.count;i++)
    {
        UIButton *btn=[ary_button objectAtIndex:i];
        btn.clipsToBounds=YES;
        btn.layer.cornerRadius=corner_redius;
        btn.layer.borderColor=[border_color CGColor];
        btn.layer.borderWidth=border_width;
        [btn setExclusiveTouch:YES];
    }
    
    ary_label=[NSArray arrayWithObjects:lbl_1,lbl_2,lbl_3,lbl_4, nil];
    
    border_width=1.5;
    corner_redius=7.0;
    
    for(int i=0;i<ary_label.count;i++)
    {
        UILabel *lbl=[ary_label objectAtIndex:i];
        lbl.clipsToBounds=YES;
        lbl.layer.cornerRadius=corner_redius;
        lbl.layer.borderColor=[border_color CGColor];
        lbl.layer.borderWidth=border_width;
        lbl.backgroundColor=[UIColor clearColor];
    }
    
    str_PinCode=@"";
    btn_delete.enabled=NO;
    btn_clear.enabled=NO;
    
    self.lbl_Heading.text = NSLocalizedString(@"Enable Passcode Lock", nil);
    self.lbl_SubHeading.text = NSLocalizedString(@"Please confirm your 4-digit code", nil);
    
    
    [self.btn_delete setTitle:NSLocalizedString(@"Delete",nil) forState:UIControlStateNormal];
    [self.btn_clear setTitle:NSLocalizedString(@"Clear",nil) forState:UIControlStateNormal];
    
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.view addGestureRecognizer:swipeRight];
    
    
    
}
    
- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(IBAction) action_Enter_Pin:(UIButton *)sender
{
    if(sender.tag==10)
        str_PinCode=@"";
    else if(sender.tag==11)
        str_PinCode = [str_PinCode substringToIndex:[str_PinCode length] - 1];
    else
        str_PinCode=[str_PinCode stringByAppendingString:sender.currentTitle];
    
    if(str_PinCode.length>0)
    {
        btn_delete.enabled=YES;
        btn_clear.enabled=YES;
    }
    else
    {
        btn_delete.enabled=NO;
        btn_clear.enabled=NO;
    }
    
    for(int i=0;i<ary_label.count;i++)
    {
        UILabel *lbl=[ary_label objectAtIndex:i];
        
        if(str_PinCode.length>i)
            lbl.backgroundColor=[UIColor colorWithRed:61.0/255.0 green:63.0/255.0 blue:83.0/255.0 alpha:1.0];
        else
            lbl.backgroundColor=[UIColor clearColor];
    }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
    
    if(str_PinCode.length==4 && [str_PinCode isEqualToString:self.str_PinNumber]){
        for (UIViewController* viewController in self.navigationController.viewControllers)
        {
            if ([viewController isKindOfClass:[Settings_ViewController class]] )
            {
                
                [Localytics tagEvent:@"Settings Passcode On"];
                [Flurry logEvent:@"Settings Passcode On"];
                
                [FIRAnalytics logEventWithName:@"Settings_Passcode_On"
                                    parameters:nil];
                
                [Localytics tagEvent:@"Passcode setup successfully"];
                [Flurry logEvent:@"Passcode setup successfully"];
                
                [FIRAnalytics logEventWithName:@"Passcode_setup_successfully"
                                    parameters:nil];
                
                [[GoalManagerAppDelegate getdefaultvalue]setObject:str_PinCode forKey:@"PinNumber"];
                [[GoalManagerAppDelegate getdefaultvalue]setObject:@"Yes" forKey:@"PasscodeSet"];
                [[GoalManagerAppDelegate getdefaultvalue]setObject:@"ON" forKey:@"Passcode"];
                
                NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"HH:mm:ss"];
                
                // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
                
                NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
                NSString *str_PasscodeOnTime = [[NSString alloc]init];
                str_PasscodeOnTime = [dateFormatter stringFromDate:[NSDate date]];
                
                [[GoalManagerAppDelegate getdefaultvalue]setObject:str_PasscodeOnTime forKey:@"PasscodeOnTime"];
                
                Settings_ViewController *obj_Settings_ViewController = (Settings_ViewController*)viewController;
                
                if ([self.str_FromWhere isEqualToString:@"FromTouchID"]) {
                    obj_Settings_ViewController.str_OpenTouchID = @"OpenTouchID";
                }
                
                
                [self.navigationController popToViewController:obj_Settings_ViewController animated:YES];
            }
        }
    }
    else if(str_PinCode.length==4 && ![str_PinCode isEqualToString:self.str_PinNumber]){
        [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(action_Animation) userInfo:nil repeats:NO];
    }
    //        [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(Hide_Lock_Screen) userInfo:nil repeats:NO];
    //    else if(str_PinCode.length==4 && ![str_PinCode isEqualToString:@"1234"])
    //        [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(action_Animation) userInfo:nil repeats:NO];
}
-(void) Hide_Lock_Screen
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void) action_Animation
{
    str_PinCode=@"";
    CABasicAnimation *animation =
    [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDuration:0.09];
    [animation setRepeatCount:3];
    [animation setAutoreverses:YES];
    [animation setFromValue:[NSValue valueWithCGPoint:
                             CGPointMake([view_Lock center].x - 10.0f, [view_Lock center].y)]];
    [animation setToValue:[NSValue valueWithCGPoint:
                           CGPointMake([view_Lock center].x + 10.0f, [view_Lock center].y)]];
    [[view_Lock layer] addAnimation:animation forKey:@"position"];
    
    [self action_Enter_Pin:btn_clear];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (IBAction)action_Back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
