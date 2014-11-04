//
//  SubscriptionHelper.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 11/3/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "SubscriptionHelper.h"

@implementation SubscriptionHelper



+ (SubscriptionHelper *)sharedInstance {
    static dispatch_once_t once;
    static SubscriptionHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      @"1_Month",@"3_Months",
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

@end
