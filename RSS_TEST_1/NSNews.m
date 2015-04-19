//
//  NSNews.m
//  SidebarDemo
//
//  Created by Andy on 4/13/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import "NSNews.h"

@implementation NSNews
-(id)initWithServerResponse:(NSDictionary*) responseObject {

    self = [super init];
    if (self) {
        
        self.title = [responseObject objectForKey:@"title"];
        
        NSString *linkString = [responseObject objectForKey:@"link"];
        
        if (linkString) {
            self.link = [NSURL URLWithString:linkString];

        }
       
        NSString *urlString = [responseObject objectForKey:@"imageUrl"];
        
        if (urlString) {
            self.imageUrl = [NSURL URLWithString:urlString];
        }else {
            self.imageUrl = nil;
        }
        
        
    }

    return self;

}
@end
/*
NSString *urlString = [myString absoluteString];
NSString *urlAddress =myString;//
NSURL *url = [NSURL URLWithString:urlString ];*/