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

@interface AddOpsViewController (){
    AFHTTPRequestOperationManager *manager;
}

@end

@implementation AddOpsViewController
@synthesize AddOpsData,collectionView,infoVC,popoverVC;


#pragma mark - Collectionview methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = YES;
    
    
    NSDictionary *posDict = [AddOpsData objectAtIndex:indexPath.row];
    
    NSString *spaces = @"  ";
    NSString *symbol = [@" " stringByAppendingString:[posDict objectForKey:@"stock_symbol"]];
    [infoVC.stockSymbol setText:symbol];
    [infoVC.stockName setText:[posDict objectForKey:@"company_name"]];
    NSString *entry = [spaces stringByAppendingString:[posDict objectForKey:@"entry_price_display"]];
    [infoVC.entryPrice setText:entry];
    NSString *last = [spaces stringByAppendingString:[posDict objectForKey:@"last_price_display"]];
    [infoVC.lastPrice setText:last];
    
    [infoVC setFields:symbol :@" Entry Price :" :@" Last Price : " :@" Open Date : " :@" Return % : "];
    
    
    NSString *openDate = [spaces stringByAppendingString:[posDict objectForKey:@"open_date_display"]];
    [infoVC.openDate setText:openDate];
    
    NSString *rtrn = [spaces stringByAppendingString:[posDict objectForKey:@"pct_gain_display"]];
    [infoVC.returnPercent setText:rtrn];
    
    [popoverVC setShadowsHidden:YES];
    popoverVC.contentView.title = symbol;
    popoverVC.contentView.title = [[AddOpsData objectAtIndex:indexPath.row]objectForKey:@"company_name"];
    
    NSNumber *pctGain = [posDict objectForKey:@"pct_gain"];
    NSString *val = [pctGain stringValue];
    //NSLog(@"val : %@",val);
    if ([pctGain doubleValue] >0) {
        [infoVC greenText];
    }
    else{
        [infoVC redText];
    }
    
    
    
    
    [popoverVC presentPopoverFromView:collectionView];
    
    
    
    [self.view setAlpha:0.5];
    
    
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    companyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompanyCell" forIndexPath:indexPath];
    [cell.name setText: [[AddOpsData objectAtIndex:indexPath.row]objectForKey:@"stock_symbol"]];
    
    
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
    //[spinner startAnimating];
    
    
    
    [manager GET:@"finovus_additional_opps" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        //NSLog(@"performance stats: %@",responseObject);
        
        self.AddOpsData = responseObject;
        NSDictionary *response = [AddOpsData objectAtIndex:0];
        NSString *date = [response objectForKey:@"date_display"];
        NSString *companyName = [response objectForKey:@"company_name"];
        NSString *symbol = [response objectForKey:@"symbol"];
        NSString *action = [response objectForKey:@"action"];
        
        
        
        
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [error localizedDescription];
        NSLog(@"error : %@",error);
        
    }];
    
    
    
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
    infoVC = [InfoViewController new];
    popoverVC = [[FPPopoverController alloc]initWithViewController:infoVC];
    [popoverVC setArrowDirection:FPPopoverNoArrow];
    
    manager = [[AFHTTPRequestOperationManager manager]initWithBaseURL:[NSURL URLWithString:@"http://api.comtex.com/finovus/"]];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSURLCredential *creds = [[NSURLCredential alloc]initWithUser:@"api" password:@"ST2010api" persistence:NSURLCredentialPersistenceForSession];
    [manager setCredential:creds];
    
    [self additionalOperations];
    
    // Do any additional setup after loading the view.
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
