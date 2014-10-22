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
@synthesize pageControl;


-(void)viewDidLoad{
    tutorialImagesArray = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"Tutorial_1"], [UIImage imageNamed:@"Tutorial_2"], [UIImage imageNamed:@"Tutorial_3"], [UIImage imageNamed:@"Tutorial_4"], [UIImage imageNamed:@"Tutorial_5"], nil];
    pageControl.numberOfPages = [tutorialImagesArray count];
    
    UINib *cellNib = [UINib nibWithNibName:@"TutorialCollectionViewCell" bundle:nil];
    [self.tutorialCollectionView registerNib:cellNib forCellWithReuseIdentifier:@"tutorialCell"];
    
    

    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGSize statusbarSize = [[UIApplication sharedApplication] statusBarFrame].size;
    
    CGRect collectionviewRect = CGRectMake(0,statusbarSize.height ,screenSize.width ,screenSize.height-37 );
    //[tutorialCollectionView setFrame:collectionviewRect];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    [flowLayout setItemSize:CGSizeMake(collectionviewRect.size.width, collectionviewRect.size.height)];
    [self.tutorialCollectionView setCollectionViewLayout:flowLayout];
    
    
    
    

    
    itemSize = collectionviewRect.size;
    [tutorialCollectionView setPagingEnabled:YES];
    
    
    
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageWidth = self.tutorialCollectionView.frame.size.width;
    self.pageControl.currentPage = self.tutorialCollectionView.contentOffset.x / pageWidth;
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
    cell.imageView.contentMode = UIViewContentModeScaleToFill;
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
