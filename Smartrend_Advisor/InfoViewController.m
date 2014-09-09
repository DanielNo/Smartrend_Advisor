//
//  InfoViewController.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/8/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize stockName,stockSymbol;





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //[self.view setFrame:];
    [self.view setBackgroundColor:[UIColor redColor]];
    CGSize viewSize = self.view.frame.size;
    CGFloat height = 40;
    
    
    //CGFloat xMiddle = 110;
    CGFloat xMiddle = (self.view.frame.size.width-20)/2;
    
    
    
    
    CGRect stockSymbolRect = CGRectMake(0,0 ,xMiddle/2 , height);
    CGRect stockNameRect = CGRectMake(xMiddle/2, 0, xMiddle*1.5, height);
    
    //self.view.frame
    
    
    stockSymbol = [[UILabel alloc]initWithFrame:stockSymbolRect];
    stockName = [[UILabel alloc]initWithFrame:stockNameRect];
    [stockSymbol setBackgroundColor:[UIColor blueColor]];
    [stockName setBackgroundColor:[UIColor yellowColor]];
    
    [self.view addSubview:stockSymbol];
    [self.view addSubview:stockName];
    
    [super viewDidLoad];
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
