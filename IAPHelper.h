//
//  IAPHelper.h
//  Smartrend_Advisor
//
//  Created by Daniel No on 10/31/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RequestProductsCompletionHandler)(BOOL success, NSArray * products);

@interface IAPHelper : NSObject

- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers;
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;

@end
