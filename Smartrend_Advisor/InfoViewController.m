//
//  InfoViewController.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/8/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "InfoViewController.h"
#import "FPPopoverController.h"


@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize stockName,stockSymbol,entryPrice,lastPrice,openDate,returnPercent;





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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    CGSize viewSize = self.view.frame.size;
    CGFloat height = popoverHeight; // get value of contentview
    CGFloat width = viewSize.width-20;
    
    NSLog(@"popover height %i",popoverHeight);
    //CGFloat xMiddle = 110;
    CGFloat xMiddle = (self.view.frame.size.width-20)/2;
    
    
    
    
    CGRect stockSymbolRect = CGRectMake(0,0 ,width , height);
    CGRect entryPriceRect = CGRectMake(0,height , width,height );
    CGRect lastPriceRect = CGRectMake(0,height*2 , width,height );
    CGRect openDateRect = CGRectMake(0, height*3 , width,height );
    CGRect returnPercentRect = CGRectMake(0, height*4, width,height );
    
    
    
    
    
    //self.view.frame
    
    
    stockSymbol = [[UILabel alloc]initWithFrame:stockSymbolRect];
    //stockName = [[UILabel alloc]initWithFrame:stockNameRect];
    entryPrice = [[UILabel alloc]initWithFrame:entryPriceRect];
    lastPrice = [[UILabel alloc]initWithFrame:lastPriceRect];
    openDate = [[UILabel alloc]initWithFrame:openDateRect];
    returnPercent = [[UILabel alloc]initWithFrame:returnPercentRect];
    
    [stockSymbol setTextAlignment:NSTextAlignmentCenter];
    [entryPrice setTextAlignment:NSTextAlignmentCenter];
    [lastPrice setTextAlignment:NSTextAlignmentCenter];
    [openDate setTextAlignment:NSTextAlignmentCenter];
    [returnPercent setTextAlignment:NSTextAlignmentCenter];
    
    /*
    [stockSymbol setBackgroundColor:[UIColor blueColor]];
    [stockName setBackgroundColor:[UIColor yellowColor]];
    [entryPrice setBackgroundColor:[UIColor whiteColor]];
    [lastPrice setBackgroundColor:[UIColor grayColor]];
    [openDate setBackgroundColor:[UIColor purpleColor]];
    [returnPercent setBackgroundColor:[UIColor orangeColor]];
    */
    
    
    [self.view addSubview:stockSymbol];
    //[self.view addSubview:stockName];
    [self.view addSubview:entryPrice];
    [self.view addSubview:lastPrice];
    [self.view addSubview:openDate];
    [self.view addSubview:returnPercent];
    
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
