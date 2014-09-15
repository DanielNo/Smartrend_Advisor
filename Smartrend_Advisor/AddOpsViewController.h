//
//  AddOpsViewController.h
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/12/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InfoViewController,FPPopoverController;

@interface AddOpsViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *collectionView;
@property (strong,nonatomic) NSArray *AddOpsData;
@property (strong,nonatomic) InfoViewController *infoVC;
@property (strong,nonatomic) FPPopoverController *popoverVC;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
-(void)additionalOperations;


@end
