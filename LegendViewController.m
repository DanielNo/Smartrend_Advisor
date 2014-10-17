//
//  LegendViewController.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 10/15/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "LegendViewController.h"
@interface LegendViewController(){
    
}
@property(nonatomic,strong) UIImageView *buyImageView;
@property(nonatomic,strong) UIImageView *sellImageView;
@property(nonatomic,strong) UIImageView *coverImageView;
@property(nonatomic,strong) UIImageView *shortImageView;
@property(nonatomic,strong) UILabel *buyLbl;
@property(nonatomic,strong) UILabel *sellLbl;
@property(nonatomic,strong) UILabel *coverLbl;
@property(nonatomic,strong) UILabel *shortLbl;



@end


@implementation LegendViewController
@synthesize buyLbl,sellLbl,coverLbl,shortLbl,buyImageView,sellImageView,shortImageView,coverImageView;





-(void)viewDidLoad{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    float height = self.view.frame.size.height/4;
    float width = self.view.frame.size.width/2;
    
    int imageWidth = 30;
    int imageHeight = 30;
    
    int labelWidth = 100;
    
    int spacing = 5;
    
    UIImage *buyImg = [UIImage imageNamed:@"symbol_buy"];
    UIImage *sellImg = [UIImage imageNamed:@"symbol_sell"];
    UIImage *shortImg = [UIImage imageNamed:@"symbol_short"];
    UIImage *coverImg = [UIImage imageNamed:@"symbol_cover"];
    
    CGRect buyImgRect = CGRectMake(0, 0, imageWidth,imageHeight );
    CGRect sellImgRect = CGRectMake(0, imageHeight, imageWidth,imageHeight );
    CGRect shortImgRect = CGRectMake(0, imageHeight*2, imageWidth,imageHeight );
    CGRect coverImgRect = CGRectMake(0, imageHeight*3, imageWidth,imageHeight );
    
    CGRect buyLblRect = CGRectMake(imageWidth + spacing,0 , labelWidth,imageHeight );
    CGRect sellLblRect = CGRectMake(imageWidth + spacing,imageHeight , labelWidth,imageHeight );
    CGRect shortLblRect = CGRectMake(imageWidth + spacing,imageHeight*2 , labelWidth,imageHeight );
    CGRect coverLblRect = CGRectMake(imageWidth + spacing,imageHeight*3 , labelWidth,imageHeight );
    
    
    buyLbl = [[UILabel alloc]initWithFrame:buyLblRect];
    sellLbl = [[UILabel alloc]initWithFrame:sellLblRect];
    shortLbl = [[UILabel alloc]initWithFrame:shortLblRect];
    coverLbl = [[UILabel alloc]initWithFrame:coverLblRect];
    
    [buyLbl setText:@"Buy Signal"];
    [sellLbl setText:@"Sell Signal"];
    [shortLbl setText:@"Short Signal"];
    [coverLbl setText:@"Cover Signal"];
    
    buyImageView = [[UIImageView alloc]initWithFrame:buyImgRect];
    sellImageView = [[UIImageView alloc]initWithFrame:sellImgRect];
    shortImageView = [[UIImageView alloc]initWithFrame:shortImgRect];
    coverImageView = [[UIImageView alloc]initWithFrame:coverImgRect];
    
    
    
    
    [buyImageView setImage:buyImg];
    [sellImageView setImage:sellImg];
    [shortImageView setImage:shortImg];
    [coverImageView setImage:coverImg];
    
    [self.view addSubview:buyLbl];
    [self.view addSubview:sellLbl];
    [self.view addSubview:shortLbl];
    [self.view addSubview:coverLbl];
    [self.view addSubview:buyImageView];
    [self.view addSubview:sellImageView];
    [self.view addSubview:shortImageView];
    [self.view addSubview:coverImageView];
    

    
    
    
    
    
}









@end
