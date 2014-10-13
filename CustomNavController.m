//
//  CustomNavController.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/12/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "CustomNavController.h"

@interface CustomNavController ()

@end

@implementation CustomNavController

/*

-(void)settingsBtnPressed:(id)sender{
    MenuTableViewController *controller = [[MenuTableViewController alloc] initWithStyle:UITableViewStylePlain];
    controller.delegate = self;
    
    settingsPopover = [[FPPopoverController alloc] initWithViewController:controller];
    
    //popover.arrowDirection = FPPopoverArrowDirectionAny;
    
    settingsPopover.title = nil;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        settingsPopover.contentSize = CGSizeMake(300, 500);
    }
    else{
        settingsPopover.contentSize = CGSizeMake(150, 218);
    }
    settingsPopover.arrowDirection = FPPopoverNoArrow;
    settingsPopover.border = YES;
    
    
    UIView *layoutView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*6/8, 55 ,0 ,0 )];
    [layoutView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:layoutView];
    
    
    
    [settingsPopover presentPopoverFromView:layoutView];
    
    
}

*/


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)awakeFromNib{
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"banner"] forBarMetrics:UIBarMetricsDefault];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(settingsBtnPressed:)];
    
    self.navigationItem.leftBarButtonItem = rightButton;

    [self.navigationItem setRightBarButtonItem:rightButton];


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
