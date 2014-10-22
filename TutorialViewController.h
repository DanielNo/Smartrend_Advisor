//
//  TutorialViewController.h
//  Smartrend_Advisor
//
//  Created by Daniel No on 10/17/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *tutorialCollectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end
