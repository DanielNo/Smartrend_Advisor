//
//  DailyReturnCell.h
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/4/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyReturnCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *STA;
@property (weak, nonatomic) IBOutlet UILabel *SP500;
@property (weak, nonatomic) IBOutlet UILabel *DJIA;
@property (weak, nonatomic) IBOutlet UILabel *NASDAQ;


@end
