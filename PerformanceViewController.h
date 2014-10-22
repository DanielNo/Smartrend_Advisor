//
//  PerformanceViewController.h
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/12/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewController.h"

@interface PerformanceViewController : CustomViewController <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,FPPopoverControllerDelegate>


@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong,nonatomic) NSArray *performanceData;
@property (weak, nonatomic) IBOutlet UICollectionView *statsCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *titleBanner;

@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;
@property (strong,nonatomic) NSArray *urlArray;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end
