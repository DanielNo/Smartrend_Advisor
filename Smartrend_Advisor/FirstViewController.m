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

@interface FirstViewController (){
    AFHTTPRequestOperationManager *manager;
    
}

@end

@implementation FirstViewController
@synthesize openPositionData,performanceStatData,flowLayout,spinner,SP,STA,refreshControl,dropMenu,dailyReturn,infoVC,popoverVC;


#pragma mark - collection view methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    /*
    int x = [openPositionData count];
    
    if (x%3 == 0) {
        return x/3;
    }
    else {
        return x/3 + 1;
    }
    */
    return 1;
    
    
    
    
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSLog(@"items : %i",[openPositionData count]);
    
    
    //return 2;
    return [openPositionData count];
    
    
    
    
    
}

//       -----------------

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = YES;
    
    
    NSDictionary *posDict = [openPositionData objectAtIndex:indexPath.row];


    NSString *symbol = [posDict objectForKey:@"stock_symbol"];
    [infoVC.stockSymbol setText:symbol];
    [infoVC.stockName setText:[posDict objectForKey:@"company_name"]];
    NSString *entry = [@"Entry Price : " stringByAppendingString:[posDict objectForKey:@"entry_price_display"]];
    [infoVC.entryPrice setText:entry];
    NSString *last = [@"Last Price : " stringByAppendingString:[posDict objectForKey:@"last_price_display"]];
    [infoVC.lastPrice setText:last];
    
    
    
    
    NSString *openDate = [@"Open Date : " stringByAppendingString:[posDict objectForKey:@"open_date_display"]];
    [infoVC.openDate setText:openDate];
    
    NSString *rtrn = [@"Return : " stringByAppendingString:[posDict objectForKey:@"pct_gain_display"]];
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

-(void)startRefresh{
    NSLog(@"refresh");
    [spinner setColor:[UIColor clearColor]];
    [self performanceStats];
    [self openPositions];
    
    

    
    [refreshControl endRefreshing];
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    
    infoVC = [InfoViewController new];
    popoverVC = [[FPPopoverController alloc]initWithViewController:infoVC];
    [popoverVC setArrowDirection:FPPopoverNoArrow];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissedPopup) name:@"dismiss" object:nil];
    self.collectionView.alwaysBounceVertical = YES;
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(startRefresh)
             forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:refreshControl];

    CGRect staRect,SP500Rect;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    CGSize labelSize;
    

    labelSize.width = screenRect.size.width/2;
    labelSize.height = screenRect.size.height/12;
    
    staRect.size = labelSize;
    
    [STA setFrame:staRect];
    [SP setFrame:staRect];
    
    
    [spinner setHidesWhenStopped:YES];
    [spinner setColor:[UIColor whiteColor]];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
