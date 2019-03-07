//
//  Cell_AboutApp.h
//  MoneyBoxFREE
//
//  Created by apple on 10/01/17.
//  Copyright © 2017 whitelotuscorporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell_AboutApp : UITableViewCell
{
    UIImageView *imgView_Symbol;
    
    UILabel *lbl_Title;
    UILabel *lbl_Arrow;
    UILabel *line_label;
}

@property(nonnull,retain)IBOutlet UIImageView *imgView_Symbol;

@property(nonnull,retain)IBOutlet UILabel *lbl_Title;
@property(nonnull,retain)IBOutlet UILabel *lbl_Arrow;
@property(nonnull,retain)IBOutlet UILabel *line_label;
@end
