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

@interface FirstViewController (){
    AFHTTPRequestOperationManager *manager;
    CGRect itemSize;
    
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
    //cell.selected = YES;
    
    
    NSDictionary *posDict = [openPositionData objectAtIndex:indexPath.row];

    NSString *symbol = [posDict objectForKey:@"stock_symbol"];
    [infoVC.contentField1 setText:@""];

    NSString *entry = [[posDict objectForKey:@"entry_price_display"]leadingSpaces];
    [infoVC.contentField2 setText:entry];
    NSString *last = [[posDict objectForKey:@"last_price_display"]leadingSpaces];
    [infoVC.contentField3 setText:last];
    
    
    
    
    NSString *openDate = [[posDict objectForKey:@"open_date_display"]leadingSpaces];
    [infoVC.contentField4 setText:openDate];
    
    NSString *rtrn = [[posDict objectForKey:@"pct_gain_display"]leadingSpaces];
    [infoVC.contentField5 setText:rtrn];
    
    
    popoverVC.contentView.title = [[[openPositionData objectAtIndex:indexPath.row]objectForKey:@"company_name"]stringByAppendingString:[[posDict objectForKey:@"stock_symbol"] formatStockSymbol]];

    [infoVC.field6 removeFromSuperview];
    [infoVC.contentField6 removeFromSuperview];
    NSNumber *pctGain = [posDict objectForKey:@"pct_gain"];
    NSString *val = [pctGain stringValue];
    if ([pctGain doubleValue] >0) {
        [infoVC greenText];
    }
    else{
        [infoVC redText];
    }
    
    
    
    
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
        //NSLog(@"open positions : %@",responseObject);
        

        self.openPositionData = responseObject;
        NSLog(@"count %lu",[openPositionData count]);
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
    MenuTableViewController *controller = [[MenuTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:controller];
    
    //popover.arrowDirection = FPPopoverArrowDirectionAny;
    popover.tint = FPPopoverDefaultTint;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        popover.contentSize = CGSizeMake(300, 500);
    }
    else{
        popover.contentSize = CGSizeMake(200, 300);
    }
    popover.arrowDirection = FPPopoverNoArrow;
    popover.border = NO;
    
    //sender is the UIButton view
    [popover presentPopoverFromView:self.navBar];
    
    
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissedPopup) name:@"dismiss" object:nil];
    
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
    [refreshControl setAlpha:0];
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
