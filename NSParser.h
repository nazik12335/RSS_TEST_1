//
//  NSParser.h
//  RSS_TEST_1
//
//  Created by nazar on 4/6/15.
//  Copyright (c) 2015 Nazand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSParser : NSObject <NSXMLParserDelegate>

@property (strong, nonatomic) NSMutableData *data;

+(instancetype)sharedInstance;

-(void)go;
-(NSDictionary*)extractNewsFromSources:(NSDictionary*)sources;


@end
