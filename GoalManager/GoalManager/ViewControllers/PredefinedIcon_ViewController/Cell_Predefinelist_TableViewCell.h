//
//  Cell_Predefinelist_TableViewCell.h
//  GoalManager
//
//  Created by apple on 22/12/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell_Predefinelist_TableViewCell : UITableViewCell

{
    UIImageView *img_defineicon;
    UILabel *lbl_definename;
}

@property (nonatomic, retain) IBOutlet UIImageView *img_defineicon;
@property (nonatomic, retain) IBOutlet UILabel *lbl_definename;

@end
