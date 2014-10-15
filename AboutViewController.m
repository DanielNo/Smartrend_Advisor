//
//  AboutViewController.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 10/14/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController

-(void)viewDidLoad{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UILabel *advisorLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-20, self.view.frame.size.height/2.5)];
    [advisorLbl setFont:[UIFont systemFontOfSize:14]];
    [advisorLbl setNumberOfLines:0];
    //[advisorLbl setLineBreakMode:NSLineBreakByWordWrapping];
    //[advisorLbl sizeToFit];
    
    
    
    [advisorLbl setText:@"SmarTrend Advisor allows its users to follow its tested proprietary model’s buy, sell, short, and cover signals in real-time\nAverage trade length: 25 days\nBuy, Sell, Short & Cover Signals: Receive detailed updates of when to buy, sell, short or cover stocks in real-time\nView entry and exit points for each trade in real-time\nReview daily market analysis"];
    [self.view addSubview:advisorLbl];
}






@end
