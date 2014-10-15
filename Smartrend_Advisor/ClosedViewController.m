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
#import "TradeTypeView.h"
#import "UIViewController+Init.h"
#import "LegendViewController.h"

@interface ClosedViewController (){
AFHTTPRequestOperationManager *manager;
    AFNetworkReachabilityManager *networkManager;
    CGRect itemSize;
    UIImage *sellIMG;
    UIImage *coverIMG;
    UIColor *cellColor;
    UIColor *green;
    FPPopoverController *settingsPopover;
}
@end

@implementation ClosedViewController
@synthesize closedData,infoVC,popoverVC,refreshControl,spinner;

-(void)popoverControllerDidDismissPopover:(FPPopoverController *)popoverController{
    NSLog(@"dismissed");
    [self.view setAlpha:1.0];
}

-(void)presentedNewPopoverController:(FPPopoverController *)newPopoverController shouldDismissVisiblePopover:(FPPopoverController *)visiblePopoverController{
    NSLog(@"presented");
    [self.view setAlpha:0.5];
}

#pragma mark - Collectionview methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"items : %lu",[closedData count]);
    return [closedData count];
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = YES;
    
    
    NSDictionary *dict = [closedData objectAtIndex:indexPath.row];
    
    NSString *symbol = [[dict objectForKey:@"stock_symbol"] removeAllWhitespace];
    NSString *entryPrice = [dict objectForKey:@"entry_price_display"];
    NSString *lastPrice = [dict objectForKey:@"last_price_display"];
    NSString *openDate = [dict objectForKey:@"open_date_display"];
    NSString *closeDate = [dict objectForKey:@"close_date_display"];
    NSString *pctGainDisplay = [dict objectForKey:@"pct_gain_display"];
    NSString *tradeType = [dict objectForKey:@"trade_type"];
    NSNumber *pctGain = [dict objectForKey:@"pct_gain"];
    
    
    

    
    [infoVC.contentField2 setText:[openDate leadingSpaces]];
    [infoVC.contentField3 setText:[closeDate leadingSpaces]];
    [infoVC.contentField4 setText:[entryPrice leadingSpaces]];
    [infoVC.contentField5 setText:[lastPrice leadingSpaces]];
    [infoVC.contentField6 setText:[pctGainDisplay leadingSpaces]];
    
    popoverVC.contentView.title = [[[closedData objectAtIndex:indexPath.row]objectForKey:@"company_name"]stringByAppendingString:[symbol formatStockSymbol]];
    
    int x = popoverVC.view.frame.size.height;
    NSLog(@"height - %i",x);
    
    //[popoverVC setContentSize:CGSizeMake(400,400 )];
    
    
    
    
    if ([pctGain doubleValue] >=0.0) {
        [popoverVC.contentView.titleLabel setTextColor:green];
        [infoVC.contentField6 setTextColor:green];
    }
    else{
     [popoverVC.contentView.titleLabel setTextColor:[UIColor redColor]];
         [infoVC.contentField6 setTextColor:[UIColor redColor]];
     
     }
     
    if ([tradeType compare:@"1"]==NSOrderedSame) {
        [infoVC.contentField1.tradeImage setImage:[UIImage imageNamed:@"symbol_sell"]];
        [infoVC.contentField1.stockTicker setText:@"(Sell)"];
    }
    else{
        [infoVC.contentField1.tradeImage setImage:[UIImage imageNamed:@"symbol_cover"]];
        [infoVC.contentField1.stockTicker setText:@"(Cover)"];
    }
    
    
    
    
    UIView *layoutView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 100)];
    [popoverVC presentPopoverFromView:layoutView];
    
    

    
    
    [self.view setAlpha:0.5];
    
    
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    companyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompanyCell" forIndexPath:indexPath];
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    [cell.name setText: [[closedData objectAtIndex:indexPath.item]objectForKey:@"stock_symbol"]];
    
    NSString *tradeType = [[closedData objectAtIndex:indexPath.item ] objectForKey:@"trade_type"];
    NSNumber *pctGain = [[closedData objectAtIndex:indexPath.item]objectForKey:@"pct_gain"];
    
    
    if ([pctGain doubleValue] >=0.0) {
       
        [cell.name setTextColor:green];

    }
    else
    {
        
        [cell.name setTextColor:[UIColor redColor]];
       
        
    }
    
    
    
    
    //1 = sell else = cover
    cell.imageView.image =  [tradeType compare:@"1"] == NSOrderedSame ? sellIMG : coverIMG;
    
    /*
    if ([tradeType compare:@"1"] == NSOrderedSame) {
        [cell.imageView setImage:sellIMG];
        
    }
    else{
        [cell.imageView setImage:coverIMG];
    }
    */
    
    cell.contentView.backgroundColor = (indexPath.row % 2 == 0) ? cellColor : [UIColor whiteColor];
    
    
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
        
        NSLog(@"closed positions: %@",responseObject);
  
        
        self.closedData = responseObject;
        
              NSLog(@"closed positions count %lu",[closedData count]);
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
    [self setupNavBar];
    green = [UIColor colorWithRed:77/255.0f green:184/255.0f blue:72/255.0f alpha:1.0];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissedPopup) name:@"dismiss" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshCollectionView) name:@"foreground" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshCollectionView) name:@"reachable" object:nil];
    
    coverIMG = [UIImage imageNamed:@"symbol_cover"];
    sellIMG = [UIImage imageNamed:@"symbol_sell"];
    cellColor = [UIColor colorWithRed:226/255.0f green:227/255.0f blue:254/255.0f alpha:1];
    
    
    [spinner setHidesWhenStopped:YES];
    refreshControl = [[UIRefreshControl alloc] init];
    //[refreshControl setAlpha:0];
    [refreshControl addTarget:self action:@selector(refreshCollectionView)
             forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:refreshControl];
    
    self.collectionView.alwaysBounceVertical = YES;
    infoVC = [InfoViewController new];
    
    
    popoverVC = [[FPPopoverController alloc]initWithViewController:infoVC];
    popoverVC.delegate = self;
    [popoverVC setArrowDirection:FPPopoverNoArrow];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    int width = screenRect.size.width/3;
    itemSize.size.width = width;
    itemSize.size.height = 49;
    
    [popoverVC setShadowsHidden:YES];
    [infoVC setFields:@"  Trade Type: " :@"  Open Date: " :@"  Close Date: " :@"  Entry Price: " :@"  Last Price: "];
    [infoVC.field6 setText:@"  Return %: "];
    [popoverVC adjustClosedContentSize];
}

-(void)settingsBtnPressed:(id)sender{
    MenuTableViewController *controller = [[MenuTableViewController alloc] initWithStyle:UITableViewStylePlain];
    controller.delegate = self;
    
    settingsPopover = [[FPPopoverController alloc] initWithViewController:controller];
    
    //popover.arrowDirection = FPPopoverArrowDirectionAny;
    
    settingsPopover.title = nil;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        settingsPopover.contentSize = CGSizeMake(300, 500);
    }
    else{
        settingsPopover.contentSize = CGSizeMake(150, 218);
    }
    settingsPopover.arrowDirection = FPPopoverNoArrow;
    settingsPopover.border = YES;
    
    
    UIView *layoutView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width*6/8, 55 ,0 ,0 )];
    [layoutView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:layoutView];
    
    
    
    [settingsPopover presentPopoverFromView:layoutView];
    
    
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
