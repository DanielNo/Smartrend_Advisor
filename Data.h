//
//  Data.h
//  Smartrend_Advisor
//
//  Created by Daniel No on 10/23/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data : NSObject


@property (assign,nonatomic) BOOL pushNotification;

+ (Data*)sharedInstance;
-(void)savePush:(BOOL) b;
-(BOOL)loadPush;


@end
