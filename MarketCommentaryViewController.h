//
//  MarketCommentaryViewController.h
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/15/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"

@interface MarketCommentaryViewController : UIViewController<FPPopoverControllerDelegate>{
    
}

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;









@end
