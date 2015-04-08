//
//  NSParser.m
//  RSS_TEST_1
//
//  Created by nazar on 4/6/15.
//  Copyright (c) 2015 Nazand. All rights reserved.
//

#import "NSParser.h"
#import "ViewController.h"

@implementation NSParser

+(instancetype)sharedInstance {

    static dispatch_once_t once;
    static id sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}




-(void)go {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *str = [defaults valueForKey:@"technology"];
    
    NSLog(@"%@",str);
}

-(NSDictionary*)extractNewsFromSources:(NSDictionary*)sources {

   
    
    return nil;
    
}

@end
