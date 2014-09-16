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

@interface ClosedViewController (){
AFHTTPRequestOperationManager *manager;
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
    
    NSString *spaces = @"  ";
    NSString *symbol = [@" " stringByAppendingString:[dict objectForKey:@"stock_symbol"]];
    NSString *entryPrice = [dict objectForKey:@"entry_price_display"];
    NSString *lastPrice = [dict objectForKey:@"last_price_display"];
    NSString *openDate = [dict objectForKey:@"open_date_display"];
    NSString *closeDate = [dict objectForKey:@"close_date_display"];
    NSString *pctGain = [dict objectForKey:@"pct_gain_display"];
    [infoVC.stockSymbol setText:symbol];
    [infoVC.entryPrice setText:entryPrice];
    
    
    [infoVC setFields:symbol :@"  Open Date : " :@"  : " :@"  : " :@"  : "];
    [infoVC.openDate setText:openDate];
    
    [popoverVC setShadowsHidden:YES];
    popoverVC.contentView.title = [[closedData objectAtIndex:indexPath.row]objectForKey:@"company_name"];
    int x = popoverVC.view.frame.size.height;
    NSLog(@"height - %i",x);
    
    //[popoverVC setContentSize:CGSizeMake(400,400 )];
    UIView *layoutView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [popoverVC presentPopoverFromView:layoutView];
    
    
    
    [self.view setAlpha:0.5];
    
    
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    companyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompanyCell" forIndexPath:indexPath];
    [cell.name setText: [[closedData objectAtIndex:indexPath.row]objectForKey:@"symbol"]];
    
    
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
-(void)closedPositions{
    [spinner startAnimating];
    
    
    
    [manager GET:@"finovus_closed_positions" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"closed positions: %@",responseObject);
        
        self.closedData = responseObject;
        NSDictionary *response = [closedData objectAtIndex:0];
        NSString *date = [response objectForKey:@"date_display"];
        NSString *companyName = [response objectForKey:@"company_name"];
        NSString *symbol = [response objectForKey:@"symbol"];
        NSString *action = [response objectForKey:@"action"];
        
        
        [spinner stopAnimating];
        [self.collectionView reloadData];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [error localizedDescription];
        NSLog(@"error : %@",error);
        
    }];
    
    
    
}

-(void)refreshCollectionView{
    NSLog(@"refresh");
    if([self isViewLoaded] && self.view.window){
        [self closedPositions];
        NSLog(@"active");
    }
    else{
        
        NSLog(@"inactive");
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
    
    [spinner setHidesWhenStopped:YES];
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl setAlpha:0];
    [refreshControl addTarget:self action:@selector(refreshCollectionView)
             forControlEvents:UIControlEventValueChanged];
    self.collectionView.alwaysBounceVertical = YES;
    infoVC = [InfoViewController new];
    popoverVC = [[FPPopoverController alloc]initWithViewController:infoVC];
    [popoverVC setArrowDirection:FPPopoverNoArrow];
    
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
