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


-(void)setTitleCell:(NSTextAlignment)alignment{
    [self.label setTextColor:[UIColor whiteColor]];
    [self setBackgroundColor:[UIColor colorWithRed:64/255.0f green:19/255.0f blue:140/255.0f alpha:1.0]];
    self.label.textAlignment = alignment;
}

-(void)setDataCell{
    
    [self.label setTextColor:[UIColor blackColor]];
    [self setBackgroundColor:[UIColor colorWithRed:229/255.0f green:229.0/255.0f blue:239/255.0f alpha:1.0]];
    self.label.textAlignment = NSTextAlignmentRight;
}

@end
