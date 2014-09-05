//
//  FirstViewController.h
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/4/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegateFlowLayout>






@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property(strong,nonatomic) NSArray *openPositionData;
@property(strong,nonatomic) NSArray *performanceStatData;


@end
