//
//  IAPViewController.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 11/3/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "IAPViewController.h"
#import "SubscriptionHelper.h"
#import <StoreKit/StoreKit.h>

@interface IAPViewController (){
    NSArray *subscriptionsArray;
    
    
    SubscriptionHelper *sharedSubscriptionHelper;
    
}

@end

@implementation IAPViewController
@synthesize subscriptionTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    subscriptionTableView.delegate = self;
    subscriptionTableView.dataSource = self;
    sharedSubscriptionHelper = [SubscriptionHelper sharedInstance];
    
    [sharedSubscriptionHelper requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            subscriptionsArray = products;
            NSLog(@"success");
            [self.subscriptionTableView reloadData];
        }
        
    }];

    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 5
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return subscriptionsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    SKProduct * product = (SKProduct *) subscriptionsArray[indexPath.row];
    cell.textLabel.text = product.productIdentifier;
    
    NSLog(@"product localized title : %@",product.localizedTitle);
    NSLog(@"product identifier : %@",product.productIdentifier);
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SKProduct * product = (SKProduct *) subscriptionsArray[indexPath.row];
    
    
    [sharedSubscriptionHelper buyProduct:product];
    
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
