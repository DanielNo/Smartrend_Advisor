//
//  PerformanceViewController.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/12/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "PerformanceViewController.h"
#import "UIImageView+AFNetworking.h"

@interface PerformanceViewController (){
    AFHTTPRequestOperationManager *manager;
}


@end

@implementation PerformanceViewController

@synthesize spinner,imageView;


#pragma mark - class methods

-(void)performanceStats{
    [manager GET:@"finovus_performance_stats" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        //NSLog(@"performance stats: %@",responseObject);
        //self.performanceStatData = responseObject;
        [spinner stopAnimating];

        
        
        
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
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        
    }];
    
    
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
    [super viewDidLoad];
    manager = [[AFHTTPRequestOperationManager manager]initWithBaseURL:[NSURL URLWithString:@"http://api.comtex.com/finovus/"]];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    NSURLCredential *creds = [[NSURLCredential alloc]initWithUser:@"api" password:@"ST2010api" persistence:NSURLCredentialPersistenceForSession];
    [manager setCredential:creds];
    [self setupUI];
    //[self performanceStats];
    
    // Do any additional setup after loading the view.
}

-(void)setupUI{
    
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
