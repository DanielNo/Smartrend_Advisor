//
//  FirstViewController.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/4/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "FirstViewController.h"
#import "OpenPositionCell.h"
#import "DailyReturnCell.h"

@interface FirstViewController (){
    AFHTTPRequestOperationManager *manager;
    
}

@end

@implementation FirstViewController
@synthesize openPositionData,performanceStatData;


#pragma mark - tableview methods
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath == 0) {
            DailyReturnCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        
        if (cell1==nil) {
            
        }
        return cell1;
        
        
    }
    else{
    
        
        OpenPositionCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
    
        if (cell2 == nil) {
            
            cell2.name.text = @"hi";
            
            
        }
    
        return cell2;
        
        
    }


}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 + [openPositionData count];
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
    
    
    [manager GET:@"finovus_open_positions" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"JSON : %@",responseObject);
        

        self.openPositionData = responseObject;

    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [error localizedDescription];
        NSLog(@"error : %@",error);
        
    }];
    
    
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    manager = [[AFHTTPRequestOperationManager manager]initWithBaseURL:[NSURL URLWithString:@"http://api.comtex.com/finovus/"]];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSURLCredential *creds = [[NSURLCredential alloc]initWithUser:@"api" password:@"ST2010api" persistence:NSURLCredentialPersistenceForSession];
    [manager setCredential:creds];
    
    [self openPositions];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
