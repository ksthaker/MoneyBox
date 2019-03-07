//
//  Cell_GoalLists.m
//  GoalManager
//
//  Created by apple on 10/11/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import "Cell_GoalLists.h"

@implementation Cell_GoalLists
@synthesize imgView_GoalLogo;
@synthesize lbl_Amount,lbl_TargetDate,lbl_Title,lbl_NoImage;
@synthesize view_CompletedStage, lbl_OverdueText,view_CompletedStageOuter,view_MainShadow;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
