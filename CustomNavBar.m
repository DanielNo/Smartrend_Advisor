//
//  CustomNavBar.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/11/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "CustomNavBar.h"

@implementation CustomNavBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSLog(@"nav bar");
    }
    return self;
}

//test

-(void)awakeFromNib{

    [self setBackgroundImage:[UIImage imageNamed:@"banner"] forBarMetrics:UIBarMetricsDefault];
    UIImage *img = [self backgroundImageForBarMetrics:UIBarMetricsDefault];
    

     UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings_icon"] style:UIBarButtonItemStyleBordered target:self action:@selector(someMethod)];
     
     [self.navItem setRightBarButtonItem:rightItem];
     
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    NSLog(@"draw");
}


@end
