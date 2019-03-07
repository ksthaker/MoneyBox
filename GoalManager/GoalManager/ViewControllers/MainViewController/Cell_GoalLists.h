//
//  Cell_GoalLists.h
//  GoalManager
//
//  Created by apple on 10/11/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell_GoalLists : UITableViewCell
{
    UIImageView *imgView_GoalLogo;
    
    UILabel *lbl_Title;
    UILabel *lbl_TargetDate;
    UILabel *lbl_Amount;
    UILabel *lbl_OverdueText;
    UILabel *lbl_NoImage;
    
    UIView *view_CompletedStage;
    UIView *view_CompletedStageOuter;
    UIView *view_MainShadow;
    
}

@property(nonatomic,retain)IBOutlet UIImageView *imgView_GoalLogo;

@property(nonatomic,retain)IBOutlet UILabel *lbl_Title;
@property(nonatomic,retain)IBOutlet UILabel *lbl_TargetDate;
@property(nonatomic,retain)IBOutlet UILabel *lbl_Amount;
@property(nonatomic,retain)IBOutlet UILabel *lbl_OverdueText;
@property(nonatomic,retain)IBOutlet UILabel *lbl_NoImage;

@property(nonatomic,retain)IBOutlet UIView *view_CompletedStage;
@property(nonatomic,retain)IBOutlet UIView *view_CompletedStageOuter;

@property(nonatomic,retain)IBOutlet UIView *view_MainShadow;@end
