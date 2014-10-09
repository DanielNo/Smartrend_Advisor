//
//  MenuTableViewController.h
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/15/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DismissPopoverDelegate <NSObject>

@required;
-(void)pressed;


@end

@interface MenuTableViewController : UITableViewController


@property(nonatomic,assign)id<DismissPopoverDelegate>delegate;

@end
