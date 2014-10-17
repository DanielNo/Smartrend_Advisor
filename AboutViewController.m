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
    NSLog(@"about view did load");
    [self.view setBackgroundColor:[UIColor colorWithRed:199/255.0f green:199/255.0f blue:199/255.0f alpha:1.0]];
    UILabel *advisorLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-20, self.view.frame.size.height/2.5)];
    [advisorLbl setFont:[UIFont systemFontOfSize:16]];
    [advisorLbl setNumberOfLines:10];
    //[advisorLbl setLineBreakMode:NSLineBreakByWordWrapping];
 
    NSString *aboutStr = @"\u2022 SmarTrend Advisor allows its users to follow its tested proprietary model’s buy, sell, short, and cover signals in real-time\n\u2022 Average trade length: 25 days\n\u2022 Buy, Sell, Short & Cover Signals: Receive detailed updates of when to buy, sell, short or cover stocks in real-time\n\u2022 View entry and exit points for each trade in real-time\n\u2022 Review daily market analysis";
    
    NSMutableParagraphStyle *style  = [[NSMutableParagraphStyle alloc] init];
    style.minimumLineHeight = 18.0f;
    style.maximumLineHeight = 22.0f;
    //style.maximumLineHeight = 30.0f;
    NSDictionary *attributtes = @{NSParagraphStyleAttributeName : style,};
    advisorLbl.attributedText = [[NSAttributedString alloc] initWithString:aboutStr
                                                             attributes:attributtes];
    
   [advisorLbl sizeToFit];
    [self.view addSubview:advisorLbl];
}






@end
