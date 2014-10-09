//
//  FirstViewController.h
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/4/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuTableViewController.h"
#import "FPPopoverController.h"

@class InfoViewController,FPPopoverController,CustomNavBar;

@interface FirstViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegateFlowLayout,FPPopoverControllerDelegate>



@property (weak, nonatomic) IBOutlet CustomNavBar *navBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (weak, nonatomic) IBOutlet UIButton *settingsBtn;
@property (weak, nonatomic) IBOutlet UILabel *STA;
@property (weak, nonatomic) IBOutlet UILabel *SP;
@property (weak, nonatomic) IBOutlet UILabel *dailyReturn;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet UIButton *dropMenu;
@property (strong,nonatomic) UIRefreshControl *refreshControl;
@property (strong,nonatomic) InfoViewController *infoVC;
@property (strong,nonatomic) FPPopoverController *popoverVC;
@property(strong,nonatomic) NSArray *openPositionData;
@property(strong,nonatomic) NSArray *performanceStatData;


@end
