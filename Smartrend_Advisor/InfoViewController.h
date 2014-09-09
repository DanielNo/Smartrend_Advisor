//
//  InfoViewController.h
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/8/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController

@property (strong,nonatomic) UILabel *stockSymbol;
@property (strong,nonatomic) UILabel *stockName;
@property (strong,nonatomic) UILabel *entryPrice;
@property (strong,nonatomic) UILabel *lastPrice;
@property (strong,nonatomic) UILabel *openDate;
@property (strong,nonatomic) UILabel *returnPercent;

@end
