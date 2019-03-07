//
//  Cell_ContributionsList.h
//  GoalManager
//
//  Created by apple on 11/11/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell_ContributionsList : UITableViewCell
{
    UILabel *lbl_Note;
    UILabel *lbl_Amount;
    UILabel *lbl_Date;
    UILabel *lbl_Arrow;
}
@property(nonatomic,retain)IBOutlet UILabel *lbl_Note;
@property(nonatomic,retain)IBOutlet UILabel *lbl_Amount;
@property(nonatomic,retain)IBOutlet UILabel *lbl_Date;
@property(nonatomic,retain)IBOutlet UILabel *lbl_Arrow;
@end
