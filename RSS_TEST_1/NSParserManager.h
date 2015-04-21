//
//  NSParser.h
//  SidebarDemo
//
//  Created by Andy on 4/12/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSParserManager : NSObject
+(instancetype)sharedInstance;
-(void)getNewsWithCategory:(NSDictionary*)category
                       key:(NSString*)keyCategory
                 onSuccess:(void(^)(NSArray *news)) success
                 onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;
@end
