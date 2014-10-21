//
//  UIViewController+Init.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 10/14/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "UIViewController+Init.h"
#import "TutorialViewController.h"

@implementation UIViewController (Init)



-(void)setupNavBar{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(settingsBtnPressed:)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

-(void)showTutorialView{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGSize statusbarSize = [[UIApplication sharedApplication] statusBarFrame].size;
    TutorialViewController *tutorialVC = [self.storyboard instantiateViewControllerWithIdentifier:@"tutorialVC"];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:tutorialVC.view];
    

    
    
    [self presentViewController:tutorialVC animated:NO completion:nil];
    

}


@end
