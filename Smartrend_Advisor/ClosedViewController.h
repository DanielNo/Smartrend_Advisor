//
//  ClosedViewController.h
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/12/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InfoViewController,FPPopoverController;

@interface ClosedViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong,nonatomic) NSArray *closedData;
@property (strong,nonatomic) InfoViewController *infoVC;
@property (strong,nonatomic) FPPopoverController *popoverVC;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong,nonatomic) UIRefreshControl *refreshControl;

-(void)closedPositions;

@end
