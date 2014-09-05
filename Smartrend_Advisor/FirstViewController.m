//
//  FirstViewController.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/4/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "FirstViewController.h"
#import "companyCell.h"

@interface FirstViewController (){
    AFHTTPRequestOperationManager *manager;
    
}

@end

@implementation FirstViewController
@synthesize openPositionData,performanceStatData,flowLayout,spinner;


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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    companyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompanyCell" forIndexPath:indexPath];
    [cell.name setText: [[openPositionData objectAtIndex:indexPath.row]objectForKey:@"stock_symbol"]];

    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    CGSize itemSize;
    
    //use for iphone 6
    //itemSize.width = screenRect.size.width/3;
    int width = screenRect.size.width/3;
    //NSLog(@"width %i", width);
    
    itemSize.width = 105; // 106
    itemSize.height = 49;
    
    
    return itemSize;
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    // (top,left,bottom,right) space
    
    return  UIEdgeInsetsMake(0 ,0,0 ,0 );
    
}



#pragma mark - class methods

-(void)performanceStats{
    [manager GET:@"finovus_performance_stats" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"JSON : %@",responseObject);
        self.performanceStatData = responseObject;
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [error localizedDescription];
        NSLog(@"error : %@",error);
        
    }];
    
    
    
}

-(void)openPositions{
    
    [spinner startAnimating];
    
    [manager GET:@"finovus_open_positions" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"JSON : %@",responseObject);
        

        self.openPositionData = responseObject;
        NSLog(@"count %i",[openPositionData count]);
        [self.collectionView reloadData];
        [spinner stopAnimating];

    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [error localizedDescription];
        NSLog(@"error : %@",error);
        
    }];
    
    
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{

    [spinner setHidesWhenStopped:YES];
    
    manager = [[AFHTTPRequestOperationManager manager]initWithBaseURL:[NSURL URLWithString:@"http://api.comtex.com/finovus/"]];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSURLCredential *creds = [[NSURLCredential alloc]initWithUser:@"api" password:@"ST2010api" persistence:NSURLCredentialPersistenceForSession];
    [manager setCredential:creds];
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
