//
//  UIViewController+Init.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 10/14/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "UIViewController+Init.h"

@implementation UIViewController (Init)



-(void)setupNavBar{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(settingsBtnPressed:)];
    self.navigationItem.rightBarButtonItem = rightButton;
}


@end
