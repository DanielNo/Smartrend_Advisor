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

@interface FirstViewController (){
    AFHTTPRequestOperationManager *manager;
    AFNetworkReachabilityManager *networkManager;
    CGRect itemSize;
    UIImage *buyIMG;
    UIImage *shortIMG;
    
}

@end

@implementation FirstViewController
@synthesize openPositionData,performanceStatData,flowLayout,spinner,SP,STA,refreshControl,dropMenu,dailyReturn,infoVC,popoverVC,settingsBtn,navBar;


#pragma mark - collection view methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"items : %lu",[openPositionData count]);
    return [openPositionData count];
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    
    
    NSDictionary *posDict = [openPositionData objectAtIndex:indexPath.item];

    NSString *symbol = [posDict objectForKey:@"stock_symbol"];
    //[infoVC.contentField1 setText:@""];

    NSString *entry = [[posDict objectForKey:@"entry_price_display"]leadingSpaces];
    [infoVC.contentField2 setText:entry];
    NSString *last = [[posDict objectForKey:@"last_price_display"]leadingSpaces];
    [infoVC.contentField3 setText:last];
    NSString *tradeType = [posDict objectForKey:@"trade_type"];
    
    
    
    
    NSString *openDate = [[posDict objectForKey:@"open_date_display"]leadingSpaces];
    [infoVC.contentField4 setText:openDate];
    
    NSString *rtrn = [[posDict objectForKey:@"pct_gain_display"]leadingSpaces];
    [infoVC.contentField5 setText:rtrn];
    
    
    popoverVC.contentView.title = [[[openPositionData objectAtIndex:indexPath.item]objectForKey:@"company_name"]stringByAppendingString:[[posDict objectForKey:@"stock_symbol"] formatStockSymbol]];
   

    [infoVC.field6 removeFromSuperview];
    [infoVC.contentField6 removeFromSuperview];
    NSNumber *pctGain = [posDict objectForKey:@"pct_gain"];
    NSString *val = [pctGain stringValue];
    if ([tradeType compare:@"1"]==NSOrderedSame && [pctGain doubleValue] >0) {
        [infoVC greenText];
        [popoverVC.contentView.titleLabel setTextColor:[UIColor colorWithRed:27/255.0f green:126/255.0f blue:1/255.0f alpha:1.0]];
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
    
    
    
    /*
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"symbol_buy"];
    
    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
    
    NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:@"yo "];
    [myString appendAttributedString:attachmentString];
    
    infoVC.contentField1.attributedText = myString;
    */
    
    
    
    
    
    
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
        [cell.name setTextColor:[UIColor colorWithRed:27/255.0f green:126/255.0f blue:1/255.0f alpha:1.0]];
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

-(void)dismissedPopup{
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
        NSLog(@"open positions : %@",responseObject);
        

        self.openPositionData = responseObject;
        NSLog(@"open positions count %lu",[openPositionData count]);
        [self.collectionView reloadData];
        [spinner stopAnimating];

    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [error localizedDescription];
        NSLog(@"error : %@",error);
        
    }];
    
    
    
}

-(void)refreshCollectionView{
    
    NSLog(@"refresh1");
    if([self isViewLoaded] && self.view.window){
        [self performanceStats];
        [self openPositions];
        NSLog(@"active1");
    }
    else{
        
        NSLog(@"inactive1");
    }


    [refreshControl endRefreshing];
}

-(void)settingsBtnPressed:(id)sender{
    MenuTableViewController *controller = [[MenuTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    FPPopoverController *settingsPopover = [[FPPopoverController alloc] initWithViewController:controller];
    
    //popover.arrowDirection = FPPopoverArrowDirectionAny;

    settingsPopover.title = nil;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        settingsPopover.contentSize = CGSizeMake(300, 500);
    }
    else{
        settingsPopover.contentSize = CGSizeMake(200, 218);
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

    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissedPopup) name:@"dismiss" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshCollectionView) name:@"foreground" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshCollectionView) name:@"reachable" object:nil];
    
    buyIMG = [UIImage imageNamed:@"symbol_buy"];
    shortIMG = [UIImage imageNamed:@"symbol_short"];
    
    self.collectionView.alwaysBounceVertical = YES;
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(settingsBtnPressed:)];
    
    self.navigationItem.rightBarButtonItem = rightButton;
    
    infoVC = [InfoViewController new];
    popoverVC = [[FPPopoverController alloc]initWithViewController:infoVC];
    [popoverVC setArrowDirection:FPPopoverNoArrow];

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
    [settingsBtn addTarget:self action:@selector(settingsBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.collectionView addSubview:refreshControl];
    
    [spinner setHidesWhenStopped:YES];
    [spinner setColor:[UIColor grayColor]];
    
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    int width = screenRect.size.width/3;
    itemSize.size.width = width;
    itemSize.size.height = 49;
    
    [infoVC setFields:@" Trade Type : " :@" Entry Price :" :@" Last Price : " :@" Open Date : " :@" Return % : "];
    [popoverVC setShadowsHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
