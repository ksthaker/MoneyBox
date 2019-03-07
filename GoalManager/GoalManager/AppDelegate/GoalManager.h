//
//  GoalManager.h
//  GoalManager
//
//  Created by apple on 10/11/14.
//  Copyright (c) 2014 whitelotuscorporation. All rights reserved.
//

#ifndef GoalManager_GoalManager_h
#define GoalManager_GoalManager_h

//For Checking a Phone

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define isiPhone5  ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE
#define isiPhone4  ([[UIScreen mainScreen] bounds].size.height == 480)?TRUE:FALSE
#define isiPhone6  ([[UIScreen mainScreen] bounds].size.height == 667)?TRUE:FALSE
#define isiPhone6Plus  ([[UIScreen mainScreen] bounds].size.height == 736)?TRUE:FALSE
#define isiPhoneX  ([[UIScreen mainScreen] bounds].size.height == 812)?TRUE:FALSE

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// StoryBoard for IPhone 4 And IPhone 4S

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#define storyBoard4 [UIStoryboard storyboardWithName:@"IPhone4" bundle:nil]
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// StoryBoard for IPhone 5 And IPhone 5S

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#define storyBoard5 [UIStoryboard storyboardWithName:@"IPhone5" bundle:nil]
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// StoryBoard for IPhone 6

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#define storyBoard6 [UIStoryboard storyboardWithName:@"IPhone6" bundle:nil]
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// StoryBoard for IPhone 6 Plus

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#define storyBoard6Plus [UIStoryboard storyboardWithName:@"IPhone6Plus" bundle:nil]
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#define storyBoardX [UIStoryboard storyboardWithName:@"IPhoneX" bundle:nil]
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




//Color
#define NavigationColor [UIColor colorWithRed:46.0/255.0 green:49.0/255.0 blue:61.0/255.0 alpha:1.0]


#define Goal11 [NSString stringWithFormat:NSLocalizedString(@"Goal Error 1", nil)]

#define OK [NSString stringWithFormat:NSLocalizedString(@"OK", nil)]

#define CANCEL1 [NSString stringWithFormat:NSLocalizedString(@"CANCEL", nil)]

#define SHARE1 [NSString stringWithFormat:NSLocalizedString(@"SHARE", nil)]

#define GoalIsCreated [NSString stringWithFormat:NSLocalizedString(@"Goal is created!", nil)]

#define Doyouwanttoshareyourgoalwithyourfriends [NSString stringWithFormat:NSLocalizedString(@"Do you want to share your goal with your friends?", nil)]

#define Alert1 [NSString stringWithFormat:NSLocalizedString(@"Alert", nil)]

#define SessionExpired1 [NSString stringWithFormat:NSLocalizedString(@"Your Facebook session has expired please go in setting and Turn Allow facebook sharing ON", nil)]

#define SessionExpired2 [NSString stringWithFormat:NSLocalizedString(@"Your Twitter session has expired please go in setting and Turn Allow Twitter Sharing ON", nil)]

#define SessionExpired3 [NSString stringWithFormat:NSLocalizedString(@"Your Facebook and Twitter session has expired please go in setting and Turn Allow facebook sharing and Allow Twitter Sharing ON", nil)]

#define GoalAchieved [NSString stringWithFormat:NSLocalizedString(@"Goal Achieved!", nil)]

#define Yourgoaliscompleted [NSString stringWithFormat:NSLocalizedString(@"Your goal is completed. Do you want to share your accomplishment with your friends?", nil)]

#define Contribution11 [NSString stringWithFormat:NSLocalizedString(@"Contribution Error 1", nil)]

#define ContributionAdded [NSString stringWithFormat:NSLocalizedString(@"Contribution Added!", nil)]

#define Doyouwanttoshareyourcontribution [NSString stringWithFormat:NSLocalizedString(@"Do you want to share your contribution with your friends?\nMaybe they can help you!", nil)]

#define Milestoneachieved [NSString stringWithFormat:NSLocalizedString(@"Milestone achieved!", nil)]

#define Doyouwanttosharemilestone [NSString stringWithFormat:NSLocalizedString(@"Do you want to share milestone you achieved?\nMay be they can help you!", nil)]

#endif
