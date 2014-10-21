//
//  TutorialViewController.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 10/17/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "TutorialViewController.h"

#import "TutorialCollectionViewCell.h"

@implementation TutorialViewController{
    CGSize itemSize;
    NSArray *tutorialImagesArray;
}

@synthesize tutorialCollectionView;


-(void)viewDidLoad{

    
    

    
    itemSize = self.tutorialCollectionView.frame.size;
    [tutorialCollectionView setBackgroundColor:[UIColor yellowColor]];
    [tutorialCollectionView setPagingEnabled:YES];
        
    
    
    tutorialImagesArray = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"Tutorial_1"], [UIImage imageNamed:@"Tutorial_2"], [UIImage imageNamed:@"Tutorial_3"], [UIImage imageNamed:@"Tutorial_4"], [UIImage imageNamed:@"Tutorial_5"], nil];
    
}

- (IBAction)dismissTutorial:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [tutorialImagesArray count];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TutorialCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tutorialCell" forIndexPath:indexPath];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.imageView.image= [tutorialImagesArray objectAtIndex:indexPath.item];
    
    return cell;
}


#pragma mark - UICollectionviewFlowLayout delegate methods

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return itemSize;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    // (top,left,bottom,right) space
    
    return  UIEdgeInsetsMake(0 ,0,0 ,0 );
    
}



@end
