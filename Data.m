//
//  Data.m
//  Smartrend_Advisor
//
//  Created by Daniel No on 10/23/14.
//  Copyright (c) 2014 Comtex. All rights reserved.
//

#import "Data.h"



static Data* _sharedInstance = nil;

@implementation Data{
    NSUserDefaults *defaults;
}

@synthesize pushNotification;


+ (Data*)sharedInstance
{
    @synchronized(self)
    {
        if(_sharedInstance == nil)
        {
            _sharedInstance = [[super allocWithZone:NULL] init];
            
        }
    }
    return _sharedInstance;
}



+(id)alloc
{
    @synchronized([Data class])
    {
        
        _sharedInstance = [super alloc];
        return _sharedInstance;
    }
    
    
    return nil;
}

- (id)init
{
    self = [super init];
    if ( self != nil )
    {
        defaults = [NSUserDefaults standardUserDefaults];
        
        
        
    }
    
    
    return self;
}

-(void)savePush:(NSNumber *) b{
    self.pushNotification = b;
    [defaults setObject:pushNotification forKey:@"push"];
    [defaults synchronize];
}


-(NSNumber *)loadPush{
    NSNumber *b;
    if ([defaults objectForKey:@"push"]) {
        b = [defaults objectForKey:@"push"];
        NSLog(@"push enabled : %i",[b boolValue]);
    }
    else if([defaults objectForKey:@"push"] == nil)
    {
        NSLog(@"default setting : Push notification on");
        b = [NSNumber numberWithBool:YES];
    }
    self.pushNotification = b;
    return b;
}















@end
