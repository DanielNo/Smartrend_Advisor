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
#import "MenuTableViewController.h"
#import "NSString+Formatting.h"
#import "TradeTypeView.h"
#import "UIViewController+Init.h"
#import "AboutViewController.h"
#import "LegendViewController.h"


@interface FirstViewController (){
    AFHTTPRequestOperationManager *manager;
    AFNetworkReachabilityManager *networkManager;
    CGRect itemSize;
    UIImage *buyIMG;
    UIImage *shortIMG;
    UIColor *green;
    UILabel *noOpenPositions;
    FPPopoverController *settingsPopover;
}
@property (weak, nonatomic) IBOutlet UILabel *openPositionsLbl;

@end

@implementation FirstViewController
@synthesize openPositionData,performanceStatData,flowLayout,spinner,SP,STA,refreshControl,dailyReturn,infoVC,popoverVC,openPositionsLbl;

-(void)popoverControllerDidDismissPopover:(FPPopoverController *)popoverController{
    NSLog(@"delegate - dismiss popover");

    [self.view setAlpha:1.0];
}

-(void)presentedNewPopoverController:(FPPopoverController *)newPopoverController shouldDismissVisiblePopover:(FPPopoverController *)visiblePopoverController{

    
   // [self.view setAlpha:0.5];
    NSLog(@"delegate - present new popover");
}



#pragma mark - collection view methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //NSLog(@"items : %lu",[openPositionData count]);
    return [openPositionData count];
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    
    
    NSDictionary *posDict = [openPositionData objectAtIndex:indexPath.item];

    NSString *symbol = [posDict objectForKey:@"stock_symbol"];
    //[infoVC.contentField1 setText:@""];

    NSString *entry = [[posDict objectForKey:@"entry_price_display"] leadingSpaces];
    [infoVC.contentField2 setText:entry];
    NSString *last = [[posDict objectForKey:@"last_price_display"]leadingSpaces];
    [infoVC.contentField3 setText:last];
    NSString *tradeType = [posDict objectForKey:@"trade_type"];
    
    
    
    
    NSString *openDate = [[posDict objectForKey:@"open_date_display"]leadingSpaces];
    [infoVC.contentField4 setText:openDate];
    
    NSString *rtrn = [[posDict objectForKey:@"pct_gain_display"]leadingSpaces];
    [infoVC.contentField5 setText:rtrn];
    
    
    popoverVC.contentView.title = [[[openPositionData objectAtIndex:indexPath.item]objectForKey:@"company_name"]stringByAppendingString:[[symbol removeAllWhitespace] formatStockSymbol]];
   

    [infoVC.field6 removeFromSuperview];
    [infoVC.contentField6 removeFromSuperview];
    NSNumber *pctGain = [posDict objectForKey:@"pct_gain"];
    NSString *val = [pctGain stringValue];
    if ([tradeType compare:@"1"]==NSOrderedSame && [pctGain doubleValue] >0) {
        [infoVC greenText];
        [popoverVC.contentView.titleLabel setTextColor:green];
    }
    else if([tradeType compare:@"1"]==NSOrderedSame  && [pctGain doubleValue] <0){
        [infoVC redText];
        [popoverVC.contentView.titleLabel setTextColor:[UIColor redColor]];
    }
    
    if ([tradeType compare:@"1"]==NSOrderedSame) {
        [infoVC.contentField1.tradeImage setImage:[UIImage imageNamed:@"symbol_buy"]];
         [infoVC.contentField1.stockTicker setText:@"(Buy)"];
    }
    else{
        [infoVC.contentField1.tradeImage setImage:[UIImage imageNamed:@"symbol_short"]];
        [infoVC.contentField1.stockTicker setText:@"(Short)"];
    }

    
    
    
    [popoverVC presentPopoverFromView:dailyReturn];

    
    
    [self.view setAlpha:0.5];
    
    
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *posDict = [openPositionData objectAtIndex:indexPath.item];
    companyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompanyCell" forIndexPath:indexPath];
    
    
    

    [cell.name setText: [[openPositionData objectAtIndex:indexPath.row]objectForKey:@"stock_symbol"]];
    NSString *tradeType = [[openPositionData objectAtIndex:indexPath.row] objectForKey:@"trade_type"];
    
    
    
    cell.contentView.backgroundColor = (indexPath.row % 2 == 0) ? [UIColor colorWithRed:226/255.0f green:227/255.0f blue:254/255.0f alpha:1] : [UIColor whiteColor];

    if ([tradeType caseInsensitiveCompare:@"1"]==NSOrderedSame) {
        [cell.imageView setImage:buyIMG];
    }
    else{
        [cell.imageView setImage:shortIMG];
    }
    NSNumber *pctGain = [posDict objectForKey:@"pct_gain"];
    if ( [pctGain doubleValue] >=0) {
        [cell.name setTextColor:green];
    }
    else if([pctGain doubleValue] <0){
        [cell.name setTextColor:[UIColor redColor]];
    }
    
    
    
    
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
    [noOpenPositions setAlpha:0.0];
    [spinner startAnimating];
    
    [manager GET:@"finovus_open_positions" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        //NSLog(@"open positions : %@",responseObject);
        

        self.openPositionData = responseObject;
        //NSLog(@"open positions count %lu",[openPositionData count]);
        [self.collectionView reloadData];
        [spinner stopAnimating];

    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [error localizedDescription];
        NSLog(@"error : %@",error);
        
        //NSInteger x = error.code;
        //NSLog(@"error code %lu",(long)x);
        
        if (error.code == 18446744073709550605) {
            NSLog(@"internal server error from api");
            [noOpenPositions setAlpha:1.0];
        }
        
        
        [spinner stopAnimating];
        
    }];
    
    
    
}

-(void)refreshCollectionView{
    if([self isViewLoaded] && self.view.window){
        [self performanceStats];
        [self openPositions];
    }
    else{
    }


    [refreshControl endRefreshing];
}

-(void)dismissedPopup{

}


-(void)selectedTableRow:(NSUInteger)rowNum
{
    
      [self.view setAlpha:0.5];
    
    AboutViewController *aboutVC = [AboutViewController new];
    FPPopoverController *aboutPopover = [[FPPopoverController alloc]initWithViewController:aboutVC];
  
    
    
    aboutPopover.delegate = self;
    
    
    aboutPopover.contentView.title = @"Smartrend Advisor";
    [aboutPopover setArrowDirection:FPPopoverNoArrow];
    [aboutPopover setShadowsHidden:YES];
    [aboutPopover adjustAboutContentSize];
    
    LegendViewController *legendVC = [LegendViewController new];
    FPPopoverController *legendPopover = [[FPPopoverController alloc]initWithViewController:legendVC];
    legendPopover.delegate = self;
    legendPopover.contentView.title = @"Legend";
    [legendPopover setArrowDirection:FPPopoverNoArrow];
    [legendPopover setShadowsHidden:YES];
    [legendPopover adjustLegendContentSize];
    
    
  
    NSLog(@"selected row : %d",rowNum);
    switch (rowNum) {
        case 0: //About
            [aboutPopover presentPopoverFromPoint:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/4.5)];
            //[self.view setAlpha:0.5];
            break;
        case 1: //Legend
            [legendPopover presentPopoverFromPoint:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/4.5)];
            [self.view setAlpha:0.5];
            
            break;
        case 2: //Tutorial

            
            break;
        case 3: //Settings
            
            break;
            
        default:
            break;
    }
    
    NSLog(@"select table row");
    
    [settingsPopover dismissPopoverAnimated:YES];
}

-(void)settingsBtnPressed:(id)sender{
    MenuTableViewController *controller = [[MenuTableViewController alloc] initWithStyle:UITableViewStylePlain];
    controller.delegate = self;
    
    settingsPopover = [[FPPopoverController alloc] initWithViewController:controller];
    
    //settingsPopover.delegate = self;
    
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

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    NSString *deviceType = [UIDevice currentDevice].model;
    //NSLog(@"DEVICE TYPE %@", deviceType);
    
    int w = [[UIScreen mainScreen]bounds].size.width;
    int h = [[UIScreen mainScreen]bounds].size.height;
    
   // NSLog(@"width : %i height : %i",w,h);
    
    [self setupUI];
    
    
    
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

    [self setupNavBar];
    green = [UIColor colorWithRed:27/255.0f green:126/255.0f blue:1/255.0f alpha:1.0];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissedPopup) name:@"dismiss" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshCollectionView) name:@"foreground" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshCollectionView) name:@"reachable" object:nil];
    
    buyIMG = [UIImage imageNamed:@"symbol_buy"];
    shortIMG = [UIImage imageNamed:@"symbol_short"];
    
    self.collectionView.alwaysBounceVertical = YES;
    
    
    

    
    
    
    
    
    infoVC = [InfoViewController new];
    popoverVC = [[FPPopoverController alloc]initWithViewController:infoVC];
    [popoverVC setArrowDirection:FPPopoverNoArrow];
    popoverVC.delegate = self;

    CGFloat borderWidth = 1.0;
    CGColorRef borderColor = [UIColor blackColor].CGColor;
    STA.layer.borderColor = borderColor;
    STA.layer.borderWidth = borderWidth;
    SP.layer.borderColor = borderColor;
    SP.layer.borderWidth = borderWidth;
    
    refreshControl = [[UIRefreshControl alloc] init];
    //[refreshControl setAlpha:0];
    
    [refreshControl addTarget:self action:@selector(refreshCollectionView)
             forControlEvents:UIControlEventValueChanged];

    
    
    [self.collectionView addSubview:refreshControl];
    
    [spinner setHidesWhenStopped:YES];
    [spinner setColor:[UIColor grayColor]];
    
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    int width = screenRect.size.width/3;
    itemSize.size.width = width;
    itemSize.size.height = 49;
    
    [infoVC setFields:@" Trade Type: " :@" Entry Price:" :@" Last Price: " :@" Open Date: " :@" Return %: "];
    [popoverVC setShadowsHidden:YES];
    CGRect openPosRect;
    openPosRect.size = CGSizeMake(self.view.frame.size.width, 100);
    openPosRect.origin = CGPointMake(openPositionsLbl.frame.origin.x,openPositionsLbl.frame.origin.y );
    noOpenPositions = [[UILabel alloc]initWithFrame:openPosRect];
    [noOpenPositions setText:@"No Open Positions Available"];
    [noOpenPositions setTextColor:[UIColor whiteColor]];
    [noOpenPositions setTextAlignment:NSTextAlignmentCenter];
    [noOpenPositions setAlpha:0.0];
    [self.view addSubview:noOpenPositions];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
