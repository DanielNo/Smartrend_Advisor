//
//  AddOpsViewController.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/12/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "AddOpsViewController.h"
#import "companyCell.h"

#import "FPPopoverController.h"
#import "InfoViewController.h"
#import "MenuTableViewController.h"
#import "NSString+Formatting.h"

@interface AddOpsViewController (){
    AFHTTPRequestOperationManager *manager;
}

@end

@implementation AddOpsViewController
@synthesize AddOpsData,infoVC,popoverVC,refreshControl,spinner;


#pragma mark - Collectionview methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [AddOpsData count];
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = YES;
    
    
    NSDictionary *dict = [AddOpsData objectAtIndex:indexPath.row];
    

    NSString *symbol = [@" " stringByAppendingString:[dict objectForKey:@"symbol"]];
    
    NSString *entry = [dict objectForKey:@"entry_price_display"];
    [infoVC.contentField2 setText:[entry leadingSpaces]];
    
    
    [infoVC setFields:@"  Trade Type : " :@"  Entry price : " :@"  Open Date : " :@"  : " :@"  : "];
    
    
    NSString *openDate = [[dict objectForKey:@"date_display"]leadingSpaces];
    [infoVC.contentField3 setText:openDate];
    
    [popoverVC setShadowsHidden:YES];
    popoverVC.contentView.title = [[[AddOpsData objectAtIndex:indexPath.row]objectForKey:@"company_name"]stringByAppendingString:[[dict objectForKey:@"symbol"] formatStockSymbol]];
    
    int x = popoverVC.view.frame.size.height;
    NSLog(@"height - %i",x);
    
    //[popoverVC setContentSize:CGSizeMake(400,400 )];
    UIView *layoutView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [popoverVC presentPopoverFromView:layoutView];
    
    
    
    [self.view setAlpha:0.5];
    
    
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    companyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompanyCell" forIndexPath:indexPath];
    [cell.name setText: [[AddOpsData objectAtIndex:indexPath.row]objectForKey:@"symbol"]];
    
    
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
-(void)additionalOperations{
    [spinner startAnimating];
    
    
    
    [manager GET:@"finovus_additional_opps" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"additional operations: %@",responseObject);
        
        self.AddOpsData = responseObject;
        NSDictionary *response = [AddOpsData objectAtIndex:0];
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
        [self additionalOperations];
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
    
    [self additionalOperations];
    
    


    
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

@end
