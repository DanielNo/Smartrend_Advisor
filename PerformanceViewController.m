//
//  PerformanceViewController.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/12/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "PerformanceViewController.h"
#import "UIImageView+AFNetworking.h"
#import "DataCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "ImageCollectionViewCell.h"
#import "MenuTableViewController.h"
#import "LegendViewController.h"


@interface PerformanceViewController (){
    AFHTTPRequestOperationManager *manager;
    AFNetworkReachabilityManager *networkManager;
    CGRect itemSize;
    CGRect itemSize2;
    UIImage *placeholder;

}


@end

@implementation PerformanceViewController

@synthesize spinner,performanceData,statsCollectionView,imageCollectionView,urlArray,titleBanner,pageControl;
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageWidth = self.imageCollectionView.frame.size.width;
    self.pageControl.currentPage = self.imageCollectionView.contentOffset.x / pageWidth;
    
    switch (pageControl.currentPage) {
        case 0:
            titleBanner.text = @"Performance - S&P500";
            break;
        case 1:
            titleBanner.text = @"Performance - DJIA";
            break;
        case 2:
            titleBanner.text = @"Performance - NASDAQ";
            break;

            
        default:
            break;
    }
    
}

#pragma mark - collectionview methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //NSLog(@"items : %lu",[performanceData count]);
    //return [performanceData count];
    
    
    
    int items;
    
    if (collectionView.tag ==1) {
        items = 3;
    }
    else if (collectionView.tag ==2) {
        items = 20;
    }
    
    return items;
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (collectionView.tag ==1) {
        
        
        
        
        
        ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [cell.imageView setImageWithURL:[urlArray objectAtIndex:indexPath.item] placeholderImage:nil];
        
        
        
        

        return cell;
    }
    else if (collectionView.tag ==2){
        [collectionView setBackgroundColor:[UIColor blackColor]];
    
 
    DataCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dataCell" forIndexPath:indexPath];
    cell.layer.borderColor = [UIColor blackColor].CGColor;
    cell.layer.borderWidth = 1.2f;
    [cell.label setAdjustsFontSizeToFitWidth:YES];

    
    switch (indexPath.item) {
        case (0):
            cell.label.text = @"";
            [cell setBackgroundColor:[UIColor blackColor]];
            break;
        case (1):
            [cell setTitleCell:NSTextAlignmentRight];
            cell.label.text = @"ADVISOR";

            break;
        case (2):
           [cell setTitleCell:NSTextAlignmentRight];
            cell.label.text = @"S&P500";

            break;
        case (3):
            [cell setTitleCell:NSTextAlignmentRight];
            cell.label.text = @"NASDAQ";

            break;
        case (4):
            [cell setTitleCell:NSTextAlignmentLeft];
            cell.label.text = @"DAY";
            break;
        case (5):
            cell.label.text = [[[performanceData objectAtIndex:0]objectForKey:@"st_pl"]stringByAppendingString:@"%"];
            [cell setDataCell];
            break;
        case (6):
            [cell setDataCell];
            cell.label.text = [[[[performanceData objectAtIndex:0]objectForKey:@"sp_pl"]stringValue]stringByAppendingString:@"%"];
            break;
        case (7):
            [cell setDataCell];
            cell.label.text = [[[[performanceData objectAtIndex:0]objectForKey:@"nasd_pl"]stringValue] stringByAppendingString:@"%"];
            break;
        case (8):
            [cell setTitleCell:NSTextAlignmentLeft];
            cell.label.text = @"WEEK";

            break;
        case (9):
            [cell setDataCell];
            cell.label.text = [[[performanceData objectAtIndex:1]objectForKey:@"st_pl"]stringByAppendingString:@"%"];
            break;
        case (10):
            [cell setDataCell];
            cell.label.text = [[[[performanceData objectAtIndex:1]objectForKey:@"sp_pl"]stringValue]stringByAppendingString:@"%"];
            break;
        case (11):
            [cell setDataCell];
            cell.label.text = [[[[performanceData objectAtIndex:1]objectForKey:@"nasd_pl"]stringValue] stringByAppendingString:@"%"];
            break;
        case (12):
            [cell setTitleCell:NSTextAlignmentLeft];
            cell.label.text = @"MONTH";

            
            break;
        case (13):
            [cell setDataCell];
            cell.label.text = [[[performanceData objectAtIndex:2]objectForKey:@"st_pl"]stringByAppendingString:@"%"];
            break;
        case (14):
            [cell setDataCell];
            cell.label.text = [[[[performanceData objectAtIndex:2]objectForKey:@"sp_pl"]stringValue]stringByAppendingString:@"%"];
            break;
        case (15):
            [cell setDataCell];
            cell.label.text = [[[[performanceData objectAtIndex:2]objectForKey:@"nasd_pl"]stringValue] stringByAppendingString:@"%"];
            break;
        case (16):
            [cell setTitleCell:NSTextAlignmentLeft];
            cell.label.text = @"YTD";

            break;
        case (17):
            [cell setDataCell];
            cell.label.text = [[[performanceData objectAtIndex:3]objectForKey:@"st_pl"]stringByAppendingString:@"%"];
            break;
        case (18):
            [cell setDataCell];
            cell.label.text = [[[[performanceData objectAtIndex:3]objectForKey:@"sp_pl"]stringValue]stringByAppendingString:@"%"];
            break;
        case (19):
            [cell setDataCell];
            cell.label.text = [[[[performanceData objectAtIndex:3]objectForKey:@"nasd_pl"]stringValue] stringByAppendingString:@"%"];
            break;
            
        default:
            break;
    }
    
        return cell;
    }
    UICollectionViewCell *cell;
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (collectionView.tag == 1) {
        return itemSize2.size;
    }
    else if (collectionView.tag ==2){
        return itemSize.size;
    }
    
    return itemSize.size;
    
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    // (top,left,bottom,right) space
    
    return  UIEdgeInsetsMake(0 ,0,0 ,0 );
    
}


#pragma mark - class methods

-(void)performanceStats{
    [manager GET:@"finovus_performance_stats" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        //NSLog(@"performance stats: %@",responseObject);
        self.performanceData = responseObject;
    
        
        
        [spinner stopAnimating];

        [statsCollectionView reloadData];
        
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [error localizedDescription];
        NSLog(@"error : %@",error);
        
    }];
    
    
    
}




-(void)refreshData{
    //[self getGraphImages];
    [self performanceStats];
    
    
    
}



#pragma mark - view lifecycle


- (void)viewDidLoad
{

    manager = [[AFHTTPRequestOperationManager manager]initWithBaseURL:[NSURL URLWithString:@"http://api.comtex.com/finovus/"]];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSURLCredential *creds = [[NSURLCredential alloc]initWithUser:@"api" password:@"ST2010api" persistence:NSURLCredentialPersistenceForSession];
    [manager setCredential:creds];
    
    [self setupUI];
    [self performanceStats];
    
    //[self getGraphImages];

    
    
    [super viewDidLoad];


    

   int h = self.statsCollectionView.frame.size.height;
        NSLog(@"collectionview height : %i ",h);
    
    // Do any additional setup after loading the view.
}

-(void)setupUI{

    imageCollectionView.delegate = self;
    placeholder = [UIImage imageNamed:@"placeholder"];

    NSURL *sp500 = [[NSURL alloc]initWithString:@"http://images.comtex.com/finovus/charts/sp50.png"];
    
    NSURL *djia = [[NSURL alloc]initWithString:@"http://images.comtex.com/finovus/charts/djia.png"];
    
    NSURL *nasdaq = [[NSURL alloc]initWithString:@"http://images.comtex.com/finovus/charts/nasd.png"];
    urlArray = [NSArray arrayWithObjects:sp500,djia,nasdaq, nil];
    
    
   //  NSUInteger x = [imageArray count];
    //NSLog(@"img count : %lu",x);
    
    
    [self.statsCollectionView registerNib:[UINib nibWithNibName:@"DataCollectionViewCell" bundle:[NSBundle mainBundle]]
               forCellWithReuseIdentifier:@"dataCell"];
    [self.imageCollectionView registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:[NSBundle mainBundle]]
               forCellWithReuseIdentifier:@"imageCell"];
    self.imageCollectionView.pagingEnabled = YES;
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshData) name:@"reachable" object:nil];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    

}



-(void)viewDidAppear:(BOOL)animated{
    int height = (self.statsCollectionView.frame.size.height)/5;
    double width = self.statsCollectionView.frame.size.width/4;

    CGSize size = CGSizeMake(width, height);
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:size];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setMinimumLineSpacing:0.0f];
    [flowLayout setMinimumInteritemSpacing:0.0f];
    itemSize.size = flowLayout.itemSize;
    
    CGSize size2 = CGSizeMake(320, 220);
    UICollectionViewFlowLayout *flowLayout2 = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout2 setItemSize:size2];
    [flowLayout2 setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout2 setMinimumLineSpacing:0.0f];
    [flowLayout2 setMinimumInteritemSpacing:0.0f];
    itemSize2.size = flowLayout2.itemSize;
    
    
    [self.imageCollectionView setCollectionViewLayout:flowLayout2];
    [self.statsCollectionView setCollectionViewLayout:flowLayout];
    int height2 = self.statsCollectionView.frame.size.height;
    
    NSLog(@"collection view height %i",height2);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

@end
