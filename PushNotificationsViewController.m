//
//  PushNotificationsViewController.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 10/17/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "PushNotificationsViewController.h"

@implementation PushNotificationsViewController{
    UILabel *pushLbl;
    UISwitch *pushSwitch;
    Data *data;
}



-(void)viewDidLoad{
    data = [Data sharedInstance];
    

    [self.view setBackgroundColor:[UIColor colorWithRed:199/255.0f green:199/255.0f blue:199/255.0f alpha:1.0]];
    CGRect pushLblRect = CGRectMake(10,15 ,200 ,40 );
    CGRect pushSwitchRect = CGRectMake(pushLblRect.size.width + 30,20,100 ,0 );
    pushLbl = [[UILabel alloc]initWithFrame:pushLblRect];
    [pushLbl setText:@"Enable Push Notifications"];
    
    pushSwitch = [[UISwitch alloc]initWithFrame:pushSwitchRect];
    [pushSwitch addTarget:self action:@selector(togglePushNotifications:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pushLbl];
    [self.view addSubview:pushSwitch];
    
    [self loadPushNotificationSwitch];

}


-(void)loadPushNotificationSwitch{
    //[pushSwitch setOn:YES animated:NO];
    [pushSwitch setOn:[[data loadPush] boolValue] animated:NO];
}


-(void)togglePushNotifications:(id)sender{
    [data savePush:[NSNumber numberWithBool:pushSwitch.on]];

}

@end
