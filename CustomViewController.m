//
//  CustomViewController.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 10/22/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "CustomViewController.h"
#import "LegendViewController.h"
#import "FPPopoverController.h"
#import "AboutViewController.h"
#import "TutorialViewController.h"
#import "PushNotificationsViewController.h"
#import "MenuTableViewController.h"
#import "PerformanceViewController.h"
#import "ClosedViewController.h"
#import "FirstViewController.h"
#import "AddOpsViewController.h"
#import "MarketCommentaryViewController.h"

@interface CustomViewController ()
@property (strong,nonatomic) FPPopoverController *settingsPopover;

@end

@implementation CustomViewController
@synthesize settingsPopover;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeAlpha) name:@"tutorialDismissed" object:nil];
    // Do any additional setup after loading the view.
}

-(void)changeAlpha{
    [self.view setAlpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupNavBar{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(settingsBtnPressed:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
}

-(void)popoverControllerDidDismissPopover:(FPPopoverController *)popoverController{
    NSLog(@"delegate - dismiss popover");
    
    [self.view setAlpha:1.0];
}

-(void)presentedNewPopoverController:(FPPopoverController *)newPopoverController shouldDismissVisiblePopover:(FPPopoverController *)visiblePopoverController{
    
    
    // [self.view setAlpha:0.5];
    // NSLog(@"delegate - present new popover");
}


-(void)selectedTableRow:(NSUInteger)rowNum
{
    
    [self.view setAlpha:0.5];
    
    AboutViewController *aboutVC = [AboutViewController new];
    FPPopoverController *aboutPopover = [[FPPopoverController alloc]initWithViewController:aboutVC];
    aboutPopover.delegate = self;
    aboutPopover.contentView.title = @"Smartrend Advisor";
    [aboutPopover setArrowDirection:FPPopoverNoArrow];
    [aboutPopover adjustAboutContentSize];
    
    LegendViewController *legendVC = [LegendViewController new];
    FPPopoverController *legendPopover = [[FPPopoverController alloc]initWithViewController:legendVC];
    legendPopover.delegate = self;
    legendPopover.contentView.title = @"Legend";
    [legendPopover setArrowDirection:FPPopoverNoArrow];
    [legendPopover adjustLegendContentSize];
    
    
    TutorialViewController *tutorialVC = [[TutorialViewController alloc]init];
    FPPopoverController *tutorialPopover = [[FPPopoverController alloc]initWithViewController:tutorialVC];
    tutorialPopover.delegate = self;
    [tutorialPopover setArrowDirection:FPPopoverNoArrow];
    tutorialPopover.contentView.title = @"Tutorial";
    [tutorialPopover adjustTutorialContentSize];
    
    
    
    
    
    
    PushNotificationsViewController *pushVC = [PushNotificationsViewController new];
    FPPopoverController *pushNotificationPopover = [[FPPopoverController alloc]initWithViewController:pushVC];
    pushNotificationPopover.delegate = self;
    [pushNotificationPopover setArrowDirection:FPPopoverNoArrow];
    pushNotificationPopover.contentView.title = @"Settings";
    [pushNotificationPopover adjustPushContentSize];
    
    
    
    
    
    
    switch (rowNum) {
        case 0: //About
            [aboutPopover presentPopoverFromPoint:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/4.5)];
            break;
        case 1: //Legend
            [legendPopover presentPopoverFromPoint:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/4.5)];
            
            break;
        case 2: //Tutorial
            
            //[tutorialPopover presentPopoverFromPoint:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/4.5)];
            [self showTutorialView];
            break;
        case 3: //Settings
            [pushNotificationPopover presentPopoverFromPoint:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/4.5)];
            
            break;
            
        default:
            break;
    }
    
    [settingsPopover dismissPopoverAnimated:YES];
}


-(void)settingsBtnPressed:(id)sender{
    MenuTableViewController *controller = [[MenuTableViewController alloc] initWithStyle:UITableViewStylePlain];
    controller.delegate = self;
    
    settingsPopover = [[FPPopoverController alloc] initWithViewController:controller];
    
    settingsPopover.title = nil;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        settingsPopover.contentSize = CGSizeMake(300, 500);
    }
    else{
        settingsPopover.contentSize = CGSizeMake(140, 218);
    }
    settingsPopover.arrowDirection = FPPopoverNoArrow;
    settingsPopover.border = YES;
    
    
    UIView *layoutView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 55 ,0 ,0 )];
    [self.view addSubview:layoutView];
    
    if([self isKindOfClass:[PerformanceViewController class]])
    {
        [layoutView setFrame:CGRectMake(self.view.frame.size.width, -10, 0, 0)];
    }
    
    
    [settingsPopover presentPopoverFromView:layoutView];
    
    
}

-(void)showTutorialView{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGSize statusbarSize = [[UIApplication sharedApplication] statusBarFrame].size;
    TutorialViewController *tutorialVC = [self.storyboard instantiateViewControllerWithIdentifier:@"tutorialVC"];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:tutorialVC.view];
    
    
    
    
    [self presentViewController:tutorialVC animated:NO completion:nil];
    
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
