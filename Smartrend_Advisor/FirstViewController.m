//
//  FirstViewController.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/4/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "FirstViewController.h"
#import "companyCell.h"

#import "FPPopoverController.h"
#import "InfoViewController.h"
#import "CustomNavBar.h"

@interface FirstViewController (){
    AFHTTPRequestOperationManager *manager;
    
}

@end

@implementation FirstViewController
@synthesize openPositionData,performanceStatData,flowLayout,spinner,SP,STA,refreshControl,dropMenu,dailyReturn,infoVC,popoverVC,settingsBtn,navBar;


#pragma mark - collection view methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"items : %i",[openPositionData count]);
    return [openPositionData count];
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = YES;
    
    
    NSDictionary *posDict = [openPositionData objectAtIndex:indexPath.row];

    NSString *spaces = @"  ";
    NSString *symbol = [@" " stringByAppendingString:[posDict objectForKey:@"stock_symbol"]];
    [infoVC.stockSymbol setText:symbol];
    [infoVC.stockName setText:[posDict objectForKey:@"company_name"]];
    NSString *entry = [spaces stringByAppendingString:[posDict objectForKey:@"entry_price_display"]];
    [infoVC.entryPrice setText:entry];
    NSString *last = [spaces stringByAppendingString:[posDict objectForKey:@"last_price_display"]];
    [infoVC.lastPrice setText:last];
    
    [infoVC setFields:symbol :@" Entry Price :" :@" Last Price : " :@" Open Date : " :@" Return % : "];
    
    
    NSString *openDate = [spaces stringByAppendingString:[posDict objectForKey:@"open_date_display"]];
    [infoVC.openDate setText:openDate];
    
    NSString *rtrn = [spaces stringByAppendingString:[posDict objectForKey:@"pct_gain_display"]];
    [infoVC.returnPercent setText:rtrn];
    
    [popoverVC setShadowsHidden:YES];
    popoverVC.contentView.title = symbol;
    popoverVC.contentView.title = [[openPositionData objectAtIndex:indexPath.row]objectForKey:@"company_name"];
    
    
    
    
    
    
    [popoverVC presentPopoverFromView:dailyReturn];

    
    
    [self.view setAlpha:0.5];
    
    
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    companyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompanyCell" forIndexPath:indexPath];
    [cell.name setText: [[openPositionData objectAtIndex:indexPath.row]objectForKey:@"stock_symbol"]];
    
    
    cell.contentView.backgroundColor = (indexPath.row % 2 == 0) ? [UIColor colorWithRed:226/255.0f green:227/255.0f blue:254/255.0f alpha:1] : [UIColor whiteColor];

    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    CGSize itemSize;
    
    //use for iphone 6
    //itemSize.width = screenRect.size.width/3;
    int width = screenRect.size.width/3;
    //NSLog(@"width %i", width);
    
    itemSize.width = 106; // 106
    itemSize.height = 49;
    
    
    return itemSize;
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    // (top,left,bottom,right) space
    
    return  UIEdgeInsetsMake(0 ,0,0 ,0 );
    
}



#pragma mark - class methods

-(void)dismissedPopup{
    NSLog(@"received");
    [self.view setAlpha:1.0];
}

-(void)performanceStats{
    [spinner startAnimating];

    
    
    [manager GET:@"finovus_performance_stats" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        //NSLog(@"performance stats: %@",responseObject);
        
        self.performanceStatData = responseObject;
        NSDictionary *response = [performanceStatData objectAtIndex:0];
        NSString *st= [[response objectForKey:@"st_pl"] stringByAppendingString:@"%"];
        NSNumber *sp = [response objectForKey:@"sp_pl"] ;
        
        
        [self.STA setText:st];
        [self.SP setText:[[sp stringValue] stringByAppendingString:@"%"]];


        
        
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [error localizedDescription];
        NSLog(@"error : %@",error);
        
    }];
    
    
    
}

-(void)openPositions{
    [spinner startAnimating];
    
    [manager GET:@"finovus_open_positions" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        //NSLog(@"open positions : %@",responseObject);
        

        self.openPositionData = responseObject;
        NSLog(@"count %i",[openPositionData count]);
        [self.collectionView reloadData];
        [spinner stopAnimating];

    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [error localizedDescription];
        NSLog(@"error : %@",error);
        
    }];
    
    
    
}

-(void)refreshCollectionView{
    NSLog(@"refresh");


    if([self isViewLoaded] && self.view.window){
        [self performanceStats];
        [self openPositions];
        NSLog(@"active");
    }
    else{
        
        NSLog(@"inactive");
    }


    [refreshControl endRefreshing];
}

-(void)settingsBtnPressed:(id)sender{
    
    
    
    
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissedPopup) name:@"dismiss" object:nil];
    self.collectionView.alwaysBounceVertical = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshCollectionView) name:@"foreground" object:nil];
    

    
    
    
    manager = [[AFHTTPRequestOperationManager manager]initWithBaseURL:[NSURL URLWithString:@"http://api.comtex.com/finovus/"]];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSURLCredential *creds = [[NSURLCredential alloc]initWithUser:@"api" password:@"ST2010api" persistence:NSURLCredentialPersistenceForSession];
    [manager setCredential:creds];
    
    
    [self performanceStats];
    [self openPositions];
    
    
    
   
    
    
    
    
    
    [super viewDidLoad];
    
   
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)setupUI{
    
   
    
    infoVC = [InfoViewController new];
    popoverVC = [[FPPopoverController alloc]initWithViewController:infoVC];
    [popoverVC setArrowDirection:FPPopoverNoArrow];


    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl setAlpha:0];
    [refreshControl addTarget:self action:@selector(refreshCollectionView)
             forControlEvents:UIControlEventValueChanged];
    [settingsBtn addTarget:self action:@selector(settingsBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.collectionView addSubview:refreshControl];
    
    [spinner setHidesWhenStopped:YES];
    [spinner setColor:[UIColor grayColor]];
    

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
