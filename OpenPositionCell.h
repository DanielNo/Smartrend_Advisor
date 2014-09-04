//
//  OpenPositionCell.h
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/4/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenPositionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *tradeType;

@property (weak, nonatomic) IBOutlet UILabel *openPrice;
@property (weak, nonatomic) IBOutlet UILabel *endPrice;
@property (weak, nonatomic) IBOutlet UILabel *returnField;







@end
