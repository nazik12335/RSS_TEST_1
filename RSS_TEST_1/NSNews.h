//
//  NSNews.h
//  SidebarDemo
//
//  Created by Andy on 4/13/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNews : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSURL *imageUrl;

-(id)initWithServerResponse:(NSDictionary*)responseObject;

@end
