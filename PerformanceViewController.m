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

@interface PerformanceViewController (){
    AFHTTPRequestOperationManager *manager;
    AFNetworkReachabilityManager *networkManager;
    CGRect itemSize;
}


@end

@implementation PerformanceViewController

@synthesize spinner,imageView,performanceData,statsCollectionView;

#pragma mark - collectionview methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"items : %lu",[performanceData count]);
    //return [performanceData count];
    return 20;
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    DataCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dataCell" forIndexPath:indexPath];
    cell.layer.borderColor = [UIColor blackColor].CGColor;
    cell.layer.borderWidth = 1.0f;
    switch (indexPath.item) {
        case (0):
            cell.label.text = @"";
            break;
        case (1):
            cell.label.text = @"STAD";
            break;
        case (2):
            cell.label.text = @"S&P500";
            break;
        case (3):
            cell.label.text = @"NASDAQ";
            break;
        case (4):
            cell.label.text = @"DAY";
            break;
        case (5):
            cell.label.text = [[[performanceData objectAtIndex:0]objectForKey:@"st_pl"]stringByAppendingString:@"%"];
            break;
        case (6):
            
            cell.label.text = [[[[performanceData objectAtIndex:0]objectForKey:@"sp_pl"]stringValue]stringByAppendingString:@"%"];
            break;
        case (7):
            cell.label.text = [[[[performanceData objectAtIndex:0]objectForKey:@"nasd_pl"]stringValue] stringByAppendingString:@"%"];
            break;
        case (8):
            cell.label.text = @"WEEK";
            break;
        case (9):
            cell.label.text = [[[performanceData objectAtIndex:1]objectForKey:@"st_pl"]stringByAppendingString:@"%"];
            break;
        case (10):
            cell.label.text = [[[[performanceData objectAtIndex:1]objectForKey:@"sp_pl"]stringValue]stringByAppendingString:@"%"];
            break;
        case (11):
            cell.label.text = [[[[performanceData objectAtIndex:1]objectForKey:@"nasd_pl"]stringValue] stringByAppendingString:@"%"];
            break;
        case (12):
            cell.label.text = @"MONTH";
            break;
        case (13):
            cell.label.text = [[[performanceData objectAtIndex:2]objectForKey:@"st_pl"]stringByAppendingString:@"%"];
            break;
        case (14):
            cell.label.text = [[[[performanceData objectAtIndex:2]objectForKey:@"sp_pl"]stringValue]stringByAppendingString:@"%"];
            break;
        case (15):
            cell.label.text = [[[[performanceData objectAtIndex:2]objectForKey:@"nasd_pl"]stringValue] stringByAppendingString:@"%"];
            break;
        case (16):
            cell.label.text = @"YTD";
            break;
        case (17):
            cell.label.text = [[[performanceData objectAtIndex:3]objectForKey:@"st_pl"]stringByAppendingString:@"%"];
            break;
        case (18):
            cell.label.text = [[[[performanceData objectAtIndex:3]objectForKey:@"sp_pl"]stringValue]stringByAppendingString:@"%"];
            break;
        case (19):
            cell.label.text = [[[[performanceData objectAtIndex:3]objectForKey:@"nasd_pl"]stringValue] stringByAppendingString:@"%"];
            break;
            
        default:
            break;
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

-(void)getDJIA{
        NSURLRequest *djia = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://images.comtex.com/finovus/charts/djia.png"]];
    
    [imageView setImageWithURLRequest:djia placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        imageView.image = image;
        
        
        
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        
    }];
    
    
}

-(void)getSP500{
        NSURLRequest *sp500 = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://images.comtex.com/finovus/charts/sp50.png"]];
    
    [imageView setImageWithURLRequest:sp500 placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        imageView.image = image;
        CGSize size = image.size;
        int height = size.height;
        int width = size.width;
        NSLog(@"dl image height : %i ",height);
        NSLog(@"dl image width : %i ",width);
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        
    }];
    
    int x = imageView.frame.size.height;
    NSLog(@"imageview height : %i ",x);
}

-(void)getNASDAQ{
    NSURLRequest *nasdaq = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://images.comtex.com/finovus/charts/nasd.png"]];
    
    [imageView setImageWithURLRequest:nasdaq placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        imageView.image = image;
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        
    }];
    
    
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
    
    //[self getDJIA];
    [self getNASDAQ];
    [self getSP500];
    [super viewDidLoad];

    int height2 = self.statsCollectionView.frame.size.height;

    NSLog(@"collection view height %i",height2);
    

   int h = self.statsCollectionView.frame.size.height;
        NSLog(@"collectionview height : %i ",h);
    
    // Do any additional setup after loading the view.
}

-(void)setupUI{
    
    [self.statsCollectionView registerNib:[UINib nibWithNibName:@"DataCollectionViewCell" bundle:[NSBundle mainBundle]]
        forCellWithReuseIdentifier:@"dataCell"];
    
    
    

}

-(void)createGraph{
    
}

-(void)viewDidAppear:(BOOL)animated{
    int height = (self.statsCollectionView.frame.size.height)/5;
    int width = self.statsCollectionView.frame.size.width/4;
    NSLog(@"height %i",height);
    NSLog(@"width %i",width);
    CGSize size = CGSizeMake(width, height);
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:size];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setMinimumLineSpacing:0.0f];
    [flowLayout setMinimumInteritemSpacing:0.0f];
    itemSize.size = flowLayout.itemSize;
    
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
