//
//  FirstViewController.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/4/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController (){
    AFHTTPRequestOperationManager *manager;
    
}

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    manager = [[AFHTTPRequestOperationManager manager]initWithBaseURL:[NSURL URLWithString:@"http://api.comtex.com/finovus/"]];
    [self openPositions];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)openPositions{
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSURLCredential *creds = [[NSURLCredential alloc]initWithUser:@"api" password:@"ST2010api" persistence:NSURLCredentialPersistenceForSession];
    [manager setCredential:creds];
    
    [manager GET:@"finovus_open_positions" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"JSON : %@",responseObject);
        
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [error localizedDescription];
        NSLog(@"error : %@",error);
        
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
