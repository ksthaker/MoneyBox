//
//  Cell_PlannedSavingsFrequency.h
//  GoalManager
//
//  Created by apple on 12/11/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell_PlannedSavingsFrequency : UITableViewCell
{
    UILabel *lbl_Frequency;
    UILabel *lbl_Checkmark;
    
    UIButton *btn_SelectFrequency;
    
    UIView *view_Line;
}
@property(nonatomic,retain)IBOutlet UILabel *lbl_Frequency;
@property(nonatomic,retain)IBOutlet UILabel *lbl_Checkmark;

@property(nonatomic,retain)IBOutlet UIButton *btn_SelectFrequency;

@property(nonatomic,retain)IBOutlet UIView *view_Line;
@end
