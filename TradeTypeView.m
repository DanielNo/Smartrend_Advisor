//
//  TradeTypeView.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 10/3/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "TradeTypeView.h"

@implementation TradeTypeView

@synthesize tradeImage,stockTicker;


-(instancetype)init{
    
    CGRect imgRect = CGRectMake(0,0 ,self.frame.size.width/2 ,self.frame.size.height );
    CGRect textRect = CGRectMake(0,0 ,self.frame.size.width/2 ,self.frame.size.height );
    tradeImage = [[UIImageView alloc]init];
    stockTicker = [[UILabel alloc]init];
    
    
    [tradeImage setFrame:imgRect];
    [stockTicker setFrame:textRect];
    
    
    
    [self addSubview:tradeImage];
    [self addSubview:stockTicker];
    NSLog(@"tradetypeview init");
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //CGRect imgRect = CGRectMake(0,0 ,self.frame.size.width/2 ,self.frame.size.height );
        CGRect imgRect = CGRectMake(10,self.frame.size.height/6 ,30,30 );
        
        CGRect textRect = CGRectMake(self.frame.size.width/3,0 ,self.frame.size.width/2 ,self.frame.size.height );
        tradeImage = [[UIImageView alloc]init];
        stockTicker = [[UILabel alloc]init];
        
        [tradeImage setFrame:imgRect];
        [stockTicker setFrame:textRect];
        
        
        
        [self addSubview:tradeImage];
        [self addSubview:stockTicker];
        NSLog(@"tradetypeview init");
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    
    // Drawing code
}


@end
