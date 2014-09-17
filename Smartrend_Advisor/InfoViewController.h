//
//  InfoViewController.h
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/8/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController

/*
@property (strong,nonatomic) UILabel *stockSymbol;
@property (strong,nonatomic) UILabel *stockName;
@property (strong,nonatomic) UILabel *entryPrice;
@property (strong,nonatomic) UILabel *lastPrice;
@property (strong,nonatomic) UILabel *openDate;
@property (strong,nonatomic) UILabel *returnPercent;
*/

@property (strong,nonatomic) UILabel *contentField1;
@property (strong,nonatomic) UILabel *contentField2;
@property (strong,nonatomic) UILabel *contentField3;
@property (strong,nonatomic) UILabel *contentField4;
@property (strong,nonatomic) UILabel *contentField5;
@property (strong,nonatomic) UILabel *contentField6;

@property (strong,nonatomic) UILabel *field1;
@property (strong,nonatomic) UILabel *field2;
@property (strong,nonatomic) UILabel *field3;
@property (strong,nonatomic) UILabel *field4;
@property (strong,nonatomic) UILabel *field5;

-(void)setFields:(NSString *)name1 :(NSString *)name2 :(NSString *)name3 :(NSString *)name4 :(NSString *)name5;
-(void)redText;
-(void)greenText;


@end
