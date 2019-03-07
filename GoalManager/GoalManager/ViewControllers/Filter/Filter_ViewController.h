//
//  Filter_ViewController.h
//  MoneyBoxFREE
//
//  Created by apple on 29/04/15.
//  Copyright (c) 2015 whitelotuscorporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Filter_ViewController : UIViewController
{
    UIButton *btn_Alphabetically;
    UIButton *btn_ByDueDate;
}
@property(nonatomic,retain)IBOutlet UIButton *btn_Alphabetically;
@property(nonatomic,retain)IBOutlet UIButton *btn_ByDueDate;

@property(nonatomic,retain)NSString *str_FromWhere;

-(IBAction)action_SelectSortingType:(UIButton *)sender;
@end
