//
//  InfoViewController.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/8/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "InfoViewController.h"
#import "FPPopoverController.h"
#import <QuartzCore/QuartzCore.h>


@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize stockName,stockSymbol,entryPrice,lastPrice,openDate,returnPercent,field1,field2,field3,field4,field5;





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
    CGFloat width = (viewSize.width-20)/2;
    
    NSLog(@"popover height %f",popoverHeight);
    CGFloat xCenter = (self.view.frame.size.width-20)/2;
    
    
    
    
    CGRect fieldRect1 = CGRectMake(0, 0, width,height );
    CGRect fieldRect2 = CGRectMake(0, height, width,height );
    CGRect fieldRect3 = CGRectMake(0, height*2, width,height );
    CGRect fieldRect4 = CGRectMake(0, height*3, width,height );
    CGRect fieldRect5 = CGRectMake(0, height*4, width,height );
    
    
    
    
    
    
    CGRect stockSymbolRect = CGRectMake(width,0 ,width , height);
    CGRect entryPriceRect = CGRectMake(width,height , width,height );
    CGRect lastPriceRect = CGRectMake(width,height*2 , width,height );
    CGRect openDateRect = CGRectMake(width, height*3 , width,height );
    CGRect returnPercentRect = CGRectMake(width, height*4, width,height );
    
    
    
    
    
    //self.view.frame
    
    
    stockSymbol = [[UILabel alloc]initWithFrame:stockSymbolRect];
    //stockName = [[UILabel alloc]initWithFrame:stockNameRect];
    entryPrice = [[UILabel alloc]initWithFrame:entryPriceRect];
    lastPrice = [[UILabel alloc]initWithFrame:lastPriceRect];
    openDate = [[UILabel alloc]initWithFrame:openDateRect];
    returnPercent = [[UILabel alloc]initWithFrame:returnPercentRect];
    field1 = [[UILabel alloc]initWithFrame:fieldRect1];
    field2 = [[UILabel alloc]initWithFrame:fieldRect2];
    field3 = [[UILabel alloc]initWithFrame:fieldRect3];
    field4 = [[UILabel alloc]initWithFrame:fieldRect4];
    field5 = [[UILabel alloc]initWithFrame:fieldRect5];
    CGFloat borderWidth = 1.0;
    CGColorRef borderColor = [UIColor blackColor].CGColor;
    
    field1.layer.borderColor = borderColor;
    field1.layer.borderWidth = borderWidth;
    field2.layer.borderColor = borderColor;
    field2.layer.borderWidth = borderWidth;
    field3.layer.borderColor = borderColor;
    field3.layer.borderWidth = borderWidth;
    field4.layer.borderColor = borderColor;
    field4.layer.borderWidth = borderWidth;
    field5.layer.borderColor = borderColor;
    field5.layer.borderWidth = borderWidth;
    
    stockSymbol.layer.borderColor = borderColor;
    stockSymbol.layer.borderWidth = borderWidth;
    entryPrice.layer.borderColor = borderColor;
    entryPrice.layer.borderWidth = borderWidth;
    lastPrice.layer.borderColor = borderColor;
    lastPrice.layer.borderWidth = borderWidth;
    openDate.layer.borderColor = borderColor;
    openDate.layer.borderWidth = borderWidth;
    returnPercent.layer.borderColor = borderColor;
    returnPercent.layer.borderWidth = borderWidth;
    
    [stockSymbol setTextAlignment:NSTextAlignmentLeft];
    [entryPrice setTextAlignment:NSTextAlignmentLeft];
    [lastPrice setTextAlignment:NSTextAlignmentLeft];
    [openDate setTextAlignment:NSTextAlignmentLeft];
    [returnPercent setTextAlignment:NSTextAlignmentLeft];
    
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
    [self.view addSubview:field1];
    [self.view addSubview:field2];
    [self.view addSubview:field3];
    [self.view addSubview:field4];
    [self.view addSubview:field5];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setFields:(NSString *)name1 :(NSString *)name2 :(NSString *)name3 :(NSString *)name4 :(NSString *)name5{
    [field1 setText:name1];
    [field2 setText:name2];
    [field3 setText:name3];
    [field4 setText:name4];
    [field5 setText:name5];
    
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
