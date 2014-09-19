//
//  ClosedViewController.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/12/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "ClosedViewController.h"
#import "companyCell.h"

#import "FPPopoverController.h"
#import "InfoViewController.h"
#import "MenuTableViewController.h"
#import "NSString+Formatting.h"

@interface ClosedViewController (){
AFHTTPRequestOperationManager *manager;
    CGRect itemSize;
}
@end

@implementation ClosedViewController
@synthesize closedData,infoVC,popoverVC,refreshControl,spinner;


#pragma mark - Collectionview methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [closedData count];
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = YES;
    
    
    NSDictionary *dict = [closedData objectAtIndex:indexPath.row];
    
    NSString *symbol = [dict objectForKey:@"stock_symbol"];
    NSString *entryPrice = [dict objectForKey:@"entry_price_display"];
    NSString *lastPrice = [dict objectForKey:@"last_price_display"];
    NSString *openDate = [dict objectForKey:@"open_date_display"];
    NSString *closeDate = [dict objectForKey:@"close_date_display"];
    NSString *pctGain = [dict objectForKey:@"pct_gain_display"];
    NSString *tradeType = [dict objectForKey:@"trade_type"];
    
    
    
    

    
    [infoVC.contentField2 setText:[openDate leadingSpaces]];
    [infoVC.contentField3 setText:[closeDate leadingSpaces]];
    [infoVC.contentField4 setText:[entryPrice leadingSpaces]];
    [infoVC.contentField5 setText:[lastPrice leadingSpaces]];
    [infoVC.contentField6 setText:[pctGain leadingSpaces]];
    
    popoverVC.contentView.title = [[[closedData objectAtIndex:indexPath.row]objectForKey:@"company_name"]stringByAppendingString:[symbol formatStockSymbol]];
    
    int x = popoverVC.view.frame.size.height;
    NSLog(@"height - %i",x);
    
    //[popoverVC setContentSize:CGSizeMake(400,400 )];
    UIView *layoutView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 100)];
    [popoverVC presentPopoverFromView:layoutView];
    
    
    
    [self.view setAlpha:0.5];
    
    
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    companyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompanyCell" forIndexPath:indexPath];
    [cell.name setText: [[closedData objectAtIndex:indexPath.row]objectForKey:@"stock_symbol"]];
    
    
    cell.contentView.backgroundColor = (indexPath.row % 2 == 0) ? [UIColor colorWithRed:226/255.0f green:227/255.0f blue:254/255.0f alpha:1] : [UIColor whiteColor];
    
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return itemSize.size;
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    // (top,left,bottom,right) space
    
    return  UIEdgeInsetsMake(0 ,0,0 ,0 );
    
}

#pragma mark - class methods
-(void)closedPositions{
    [spinner startAnimating];
    
    
    
    [manager GET:@"finovus_closed_positions" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
       // NSLog(@"closed positions: %@",responseObject);
        
        self.closedData = responseObject;
        
        
        [spinner stopAnimating];
        [self.collectionView reloadData];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [error localizedDescription];
        NSLog(@"error : %@",error);
        
    }];
    
    
    
}

-(void)refreshCollectionView{
    NSLog(@"refresh2");
    if([self isViewLoaded] && self.view.window){
        [self closedPositions];
        NSLog(@"active2");
    }
    else{
        
        NSLog(@"inactive2");
    }
    
    
    [refreshControl endRefreshing];
}

-(void)dismissedPopup{
    [self.view setAlpha:1.0];
}


#pragma mark - View Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    
    
    
    
    manager = [[AFHTTPRequestOperationManager manager]initWithBaseURL:[NSURL URLWithString:@"http://api.comtex.com/finovus/"]];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSURLCredential *creds = [[NSURLCredential alloc]initWithUser:@"api" password:@"ST2010api" persistence:NSURLCredentialPersistenceForSession];
    [manager setCredential:creds];
    
    [self closedPositions];
    
    
    
    
    
    // Do any additional setup after loading the view.
}

-(void)setupUI{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissedPopup) name:@"dismiss" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshCollectionView) name:@"foreground" object:nil];
    [spinner setHidesWhenStopped:YES];
    refreshControl = [[UIRefreshControl alloc] init];
    //[refreshControl setAlpha:0];
    [refreshControl addTarget:self action:@selector(refreshCollectionView)
             forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:refreshControl];
    
    self.collectionView.alwaysBounceVertical = YES;
    infoVC = [InfoViewController new];
    popoverVC = [[FPPopoverController alloc]initWithViewController:infoVC];
    [popoverVC setArrowDirection:FPPopoverNoArrow];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    int width = screenRect.size.width/3;
    itemSize.size.width = width;
    itemSize.size.height = 49;
    
    [popoverVC setShadowsHidden:YES];
    [infoVC setFields:@"  Trade Type : " :@"  Open Date : " :@"  Close Date : " :@"  Entry Price : " :@"  Last Price : "];
    [infoVC.field6 setText:@"  Return % : "];
    [popoverVC adjustClosedContentSize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
