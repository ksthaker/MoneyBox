//
//  InAppRageIAPHelper.m
//  InAppRage
//
//  Created by Ray Wenderlich on 2/28/11.
//  Copyright 2011 Ray Wenderlich. All rights reserved.
//

#import "InAppRageIAPHelper.h"

@implementation InAppRageIAPHelper

static InAppRageIAPHelper * _sharedHelper;

+ (InAppRageIAPHelper *) sharedHelper 
{
    
    if (_sharedHelper != nil) 
    {
        return _sharedHelper;
    }
    _sharedHelper = [[InAppRageIAPHelper alloc] init];
    return _sharedHelper;
    
}

- (id)init 
{

    NSSet *productIdentifiers = [NSSet setWithObjects:
                                 @"com.andrey.MoneyBoxFullVersion",
                                 nil];

//    NSSet *productIdentifiers = [NSSet setWithObjects:
//                                @"com.wilanjem.job.unlimited",nil];
    
    
//    NSSet *productIdentifiers = [NSSet setWithObjects:
//                                 @"com.greenoakapps.insultbot.mafia",
//                                 @"com.greenoakapps.insultbot.arabian",
//                                 @"com.greenoakapps.insultbot.childish",
//                                 @"com.greenoakapps.insultbot.redneck",
//                                 @"com.greenoakapps.insultbot.pirate",
//                                 @"com.greenoakapps.insultbot.shakespeare",nil];
//    

    
    
    if ((self = [super initWithProductIdentifiers:productIdentifiers])) 
    {                
        
    }
    return self;
    
}

@end
