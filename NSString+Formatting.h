//
//  NSString+Formatting.h
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/17/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Formatting)
-(NSString *)formatStockSymbol;
-(NSString *)leadingSpaces;
- (NSString *) removeAllWhitespace;

@end
