//
//  FirstViewController.h
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/4/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>







@property(strong,nonatomic) NSArray *openPositionData;
@property(strong,nonatomic) NSArray *performanceStatData;


@end
