//
//  NSDetailViewController.h
//  SidebarDemo
//
//  Created by Andy on 4/15/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDetailViewController : UIViewController

@property (copy, nonatomic) NSString *url;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@end
