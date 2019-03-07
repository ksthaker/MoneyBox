//
//  Cell_AboutAppPromotion.h
//  MoneyBoxFREE
//
//  Created by Maulik on 16/03/18.
//  Copyright © 2018 whitelotuscorporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell_AboutAppPromotion : UITableViewCell
{
    UIImageView *imgView_SymbolLink;
    
    UILabel *lbl_TitleLink;
    UILabel *lbl_SubTitleLink;
    UIButton *btn_Get;
}

@property(nonnull,retain)IBOutlet UIImageView *imgView_SymbolLink;

@property(nonnull,retain)IBOutlet UILabel *lbl_TitleLink;
@property(nonnull,retain)IBOutlet UILabel *lbl_SubTitleLink;
@property(nonnull,retain)IBOutlet UIButton *btn_Get;

@property (weak, nonatomic) IBOutlet UIButton *btn_GetSmall;

@end
