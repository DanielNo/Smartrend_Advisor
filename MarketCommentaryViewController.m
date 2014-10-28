//
//  MarketCommentaryViewController.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/15/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "MarketCommentaryViewController.h"
#import "FPPopoverController.h"
#import "MenuTableViewController.h"
#import "LegendViewController.h"

@interface MarketCommentaryViewController (){
    AFHTTPRequestOperationManager *manager;
    AFNetworkReachabilityManager *networkManager;
}

@end

@implementation MarketCommentaryViewController

@synthesize spinner,textView; //techCommentary;

#pragma mark - class methods

-(void)marketCommentary{
    [spinner startAnimating];
    
    [manager GET:@"finovus_market_commentary" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"market commentary : %@",responseObject);
        


        
        
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [error localizedDescription];
        NSLog(@"error : %@",error);
        
    }];
}

-(void)technicalCommentary{
    [spinner startAnimating];
    
    [manager GET:@"finovus_technical_commentary" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){

        NSLog(@"technical commentary : %@",responseObject);
        
        NSString *str = [[responseObject objectAtIndex:0]objectForKey:@"commentary_text"];
        
        [textView setText:str];
        
        

        [spinner stopAnimating];        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [error localizedDescription];
        NSLog(@"error : %@",error);
        
    }];
}

-(void)refreshData{
    if([self isViewLoaded] && self.view.window){
        [self technicalCommentary];
    }
    else{
        
    }
    
    
    //[refreshControl endRefreshing];
    
}


#pragma mark - view lifecycle

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
    [self setupUI];
    
    
    
    [textView flashScrollIndicators];
    
    manager = [[AFHTTPRequestOperationManager manager]initWithBaseURL:[NSURL URLWithString:@"http://api.comtex.com/finovus/"]];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSURLCredential *creds = [[NSURLCredential alloc]initWithUser:@"api" password:@"ST2010api" persistence:NSURLCredentialPersistenceForSession];
    [manager setCredential:creds];
    
    
    [self marketCommentary];
    [self technicalCommentary];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setupUI{

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshData) name:@"foreground" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshData) name:@"reachable" object:nil];
    
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
