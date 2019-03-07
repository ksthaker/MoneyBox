//
//  Cell_Currency.h
//  GoalManager
//
//  Created by apple on 12/11/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell_Currency : UITableViewCell
{
    UILabel *lbl_CureencySymbol;
    UILabel *lbl_CurrencyCode;
    
}
@property(nonatomic,retain)IBOutlet UILabel *lbl_CureencySymbol;
@property(nonatomic,retain)IBOutlet UILabel *lbl_CurrencyCode;
@end
