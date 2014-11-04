//
//  IAPViewController.h
//  Smartrend_Advisor
//
//  Created by Daniel No on 11/3/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IAPViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *subscriptionTableView;

@end
