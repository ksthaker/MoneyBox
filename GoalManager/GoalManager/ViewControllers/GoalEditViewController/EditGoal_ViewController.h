//
//  EditGoal_ViewController.h
//  GoalManager
//
//  Created by apple on 12/11/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Goal.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "VPImageCropperViewController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface EditGoal_ViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,VPImageCropperDelegate,UIActionSheetDelegate,GADInterstitialDelegate>
{
    BOOL isSetReminder;
    BOOL isInternet;
    BOOL isEdit;
    NSInteger integer_SelectFrequency;
    NSInteger integer_SelectedReminderDay;
}
@property(nonatomic,weak)IBOutlet UITextField *txt_TitleOfGoal;
@property(nonatomic,weak)IBOutlet UITextField *txt_GoalAmount;
@property(nonatomic,weak)IBOutlet UITextField *txt_SavingsAccount;

@property(nonatomic,weak)IBOutlet UILabel *lbl_TargetDateArrow;
@property(nonatomic,weak)IBOutlet UILabel *lbl_CurrencyArrow;
@property(nonatomic,weak)IBOutlet UILabel *lbl_FrequencyArrow;

@property(nonatomic,weak)IBOutlet UILabel *lbl_DailyRemindMeArrow;
@property(nonatomic,weak)IBOutlet UILabel *lbl_WeeklyReminderDayArrow;
@property(nonatomic,weak)IBOutlet UILabel *lbl_WeeklyRemindeMeArrow;

@property(nonatomic,weak)IBOutlet UILabel *lbl_MonthlyReminderDateArrow;
@property(nonatomic,weak)IBOutlet UILabel *lbl_MonthlyRemindeMeArrow;

@property(nonatomic,weak)IBOutlet UILabel *lbl_Currency;
@property(nonatomic,weak)IBOutlet UILabel *lbl_TargetDate;
@property(nonatomic,weak)IBOutlet UILabel *lbl_SavingFrequency;

@property(nonatomic,weak)IBOutlet UILabel *lbl_DailyRemindMe;
@property(nonatomic,weak)IBOutlet UILabel *lbl_WeeklyReminderDay;
@property(nonatomic,weak)IBOutlet UILabel *lbl_WeeklyRemindeMe;

@property(nonatomic,weak)IBOutlet UILabel *lbl_MonthlyReminderDate;
@property(nonatomic,weak)IBOutlet UILabel *lbl_MonthlyRemindeMe;

@property(nonatomic,weak)IBOutlet UILabel *lbl_Line;

@property(nonatomic,weak)IBOutlet UIButton *btn_Currency;
@property(nonatomic,weak)IBOutlet UIButton *btn_TargetDate;
@property(nonatomic,weak)IBOutlet UIButton *btn_SavingFrequency;

@property(nonatomic,retain)NSString * language;

@property(nonatomic,weak)IBOutlet UIButton *btn_DailyRemindMe;

@property(nonatomic,weak)IBOutlet UIButton *btn_WeeklyReminderDay;
@property(nonatomic,weak)IBOutlet UIButton *btn_WeeklyRemindeMe;

@property(nonatomic,weak)IBOutlet UIButton *btn_MonthlyReminderDate;
@property(nonatomic,weak)IBOutlet UIButton *btn_MonthlyRemindeMe;

@property(nonatomic,weak)IBOutlet UIButton *btn_GoalPicture;

@property(nonatomic,weak)IBOutlet UIButton *btn_DoneDatePicker;
@property(nonatomic,weak)IBOutlet UIButton *btn_CancelDatePicker;

@property(nonatomic,weak)IBOutlet UIButton *btn_DonePickerView;
@property(nonatomic,weak)IBOutlet UIButton *btn_CancelPickerView;

@property(nonatomic,weak)IBOutlet UISwitch *switch_SetReminder;

@property(nonatomic,weak)IBOutlet UIView *view_SetReminderDaily;
@property(nonatomic,weak)IBOutlet UIView *view_SetReminderMonthly;
@property(nonatomic,weak)IBOutlet UIView *view_SetReminderWeekly;

@property(nonatomic,weak)IBOutlet UIView *view_SetDate;
@property(nonatomic,weak)IBOutlet UIView *view_SetDateMonthly;
@property(nonatomic,weak)IBOutlet UIView *view_Sahdow;

@property(nonatomic,weak)IBOutlet UIDatePicker *datePicker_Date;
@property(nonatomic,weak)IBOutlet UIPickerView *pickerView_ReminderDateMonthly;

@property(nonatomic,retain)IBOutlet UIImageView *imgView_GoalPicture;
@property(nonatomic,retain)IBOutlet UIImageView *imgView_InitialScreen;

@property(nonatomic,retain)IBOutlet UILabel *lbl_add_photo;
@property(nonatomic,retain)IBOutlet UIButton *btn_delete;

@property(nonatomic,retain)NSMutableArray *muary_PlannedSavingsFrequency;
@property(nonatomic,retain)NSMutableArray *muary_PlannedSavingsFrequency2;

@property(nonatomic,retain)NSMutableArray *muary_ReminderDay;
@property(nonatomic,retain)NSMutableArray *muary_ReminderDay2;

@property(nonatomic,retain)NSMutableArray *muary_ReminderDates;

@property(nonatomic,retain)NSString *str_SelectedCurrencySymbol;
@property(nonatomic,retain)NSString *str_PlannedSavingFrequency;
@property(nonatomic,retain)NSString *str_SetSavingReminder;
@property(nonatomic,retain)NSString *str_TargetDate;
@property(nonatomic,retain)NSString *str_ReminderTime;
@property(nonatomic,retain)NSString *str_ReminderDate;

@property(nonatomic,retain)NSString *str_Monday;
@property(nonatomic,retain)NSString *str_Tuesday;
@property(nonatomic,retain)NSString *str_Wednesday;
@property(nonatomic,retain)NSString *str_Thursday;
@property(nonatomic,retain)NSString *str_Friday;
@property(nonatomic,retain)NSString *str_Saturday;
@property(nonatomic,retain)NSString *str_Sunday;

@property(nonatomic,retain)UIImage *img_GoalLogo;

@property (strong, nonatomic)NSManagedObjectContext *editingContext;
@property (strong, nonatomic)Goal *currentGoal;

@property(nonatomic, strong) GADInterstitial *interstitial;
@property(nonatomic,retain)IBOutlet TPKeyboardAvoidingScrollView *scroll_AddGoal;

@property(nonatomic,retain)NSString *str_PlannedFrequencyChanged;

@end
