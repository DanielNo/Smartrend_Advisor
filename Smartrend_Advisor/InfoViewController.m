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
@synthesize contentField1,contentField2,contentField3,contentField4,contentField5,contentField6,field1,field2,field3,field4,field5,field6;





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
    
    NSLog(@"popover height %i",popoverHeight);
    CGFloat xCenter = (self.view.frame.size.width-20)/2;
    
    
    
    
    CGRect fieldRect1 = CGRectMake(0, 0, width,height );
    CGRect fieldRect2 = CGRectMake(0, height, width,height );
    CGRect fieldRect3 = CGRectMake(0, height*2, width,height );
    CGRect fieldRect4 = CGRectMake(0, height*3, width,height );
    CGRect fieldRect5 = CGRectMake(0, height*4, width,height );
    CGRect fieldRect6 = CGRectMake(0, height*5, width,height );
    
    
    
    
    CGRect content1Rect = CGRectMake(width,0 ,width , height);
    CGRect content2Rect = CGRectMake(width,height , width,height );
    CGRect content3Rect = CGRectMake(width,height*2 , width,height );
    CGRect content4Rect = CGRectMake(width, height*3 , width,height );
    CGRect content5Rect = CGRectMake(width, height*4, width,height );
    CGRect content6Rect = CGRectMake(width, height*5, width,height );
    
    
    
    //self.view.frame
    
    
    contentField1 = [[UILabel alloc]initWithFrame:content1Rect];
    //stockName = [[UILabel alloc]initWithFrame:stockNameRect];
    contentField2 = [[UILabel alloc]initWithFrame:content2Rect];
    contentField3 = [[UILabel alloc]initWithFrame:content3Rect];
    contentField4 = [[UILabel alloc]initWithFrame:content4Rect];
    contentField5 = [[UILabel alloc]initWithFrame:content5Rect];
    contentField6 = [[UILabel alloc]initWithFrame:content6Rect];
    field1 = [[UILabel alloc]initWithFrame:fieldRect1];
    field2 = [[UILabel alloc]initWithFrame:fieldRect2];
    field3 = [[UILabel alloc]initWithFrame:fieldRect3];
    field4 = [[UILabel alloc]initWithFrame:fieldRect4];
    field5 = [[UILabel alloc]initWithFrame:fieldRect5];
    field6 = [[UILabel alloc]initWithFrame:fieldRect6];
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
    field6.layer.borderColor = borderColor;
    field6.layer.borderWidth = borderWidth;
    
    contentField1.layer.borderColor = borderColor;
    contentField1.layer.borderWidth = borderWidth;
    contentField2.layer.borderColor = borderColor;
    contentField2.layer.borderWidth = borderWidth;
    contentField3.layer.borderColor = borderColor;
    contentField3.layer.borderWidth = borderWidth;
    contentField4.layer.borderColor = borderColor;
    contentField4.layer.borderWidth = borderWidth;
    contentField5.layer.borderColor = borderColor;
    contentField5.layer.borderWidth = borderWidth;
    contentField6.layer.borderColor = borderColor;
    contentField6.layer.borderWidth = borderWidth;
    
    [contentField1 setTextAlignment:NSTextAlignmentLeft];
    [contentField2 setTextAlignment:NSTextAlignmentLeft];
    [contentField3 setTextAlignment:NSTextAlignmentLeft];
    [contentField4 setTextAlignment:NSTextAlignmentLeft];
    [contentField5 setTextAlignment:NSTextAlignmentLeft];
    [contentField6 setTextAlignment:NSTextAlignmentLeft];
    
    /*
    [stockSymbol setBackgroundColor:[UIColor blueColor]];
    [stockName setBackgroundColor:[UIColor yellowColor]];
    [entryPrice setBackgroundColor:[UIColor whiteColor]];
    [lastPrice setBackgroundColor:[UIColor grayColor]];
    [openDate setBackgroundColor:[UIColor purpleColor]];
    [returnPercent setBackgroundColor:[UIColor orangeColor]];
    */
    
    
    [self.view addSubview:contentField1];
    //[self.view addSubview:stockName];
    [self.view addSubview:contentField2];
    [self.view addSubview:contentField3];
    [self.view addSubview:contentField4];
    [self.view addSubview:contentField5];
    [self.view addSubview:contentField6];
    [self.view addSubview:field1];
    [self.view addSubview:field2];
    [self.view addSubview:field3];
    [self.view addSubview:field4];
    [self.view addSubview:field5];
    [self.view addSubview:field6];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)greenText{
    [contentField5 setTextColor:[UIColor colorWithRed:27/255.0f green:126/255.0f blue:1/255.0f alpha:1.0]];
}

-(void)redText{
    [contentField5 setTextColor:[UIColor redColor]];
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
