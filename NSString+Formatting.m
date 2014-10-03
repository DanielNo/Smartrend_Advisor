//
//  NSString+Formatting.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 9/17/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "NSString+Formatting.h"

@implementation NSString (Formatting)

-(NSString *)formatStockSymbol{
    return [NSString stringWithFormat:@" (%@)",self];
    
}

- (NSString *) removeAllWhitespace
{
    return [self stringByReplacingOccurrencesOfString:@"\\s" withString:@""
                                              options:NSRegularExpressionSearch
                                                range:NSMakeRange(0, [self length])];
}

-(NSString *)leadingSpaces{
    return [@"  " stringByAppendingString:self];
}

@end
