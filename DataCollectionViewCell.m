//
//  DataCollectionViewCell.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/29/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "DataCollectionViewCell.h"

@implementation DataCollectionViewCell
@synthesize label;


-(void)awakeFromNib{
    [self.label sizeToFit];
}

-(void)alignLeft{
    self.label.textAlignment = NSTextAlignmentLeft;
}

@end
