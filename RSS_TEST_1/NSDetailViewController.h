//
//  NSDetailViewController.h
//  SidebarDemo
//
//  Created by Andy on 4/15/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDetailViewController : UIViewController

@property (strong, nonatomic) NSString *detailTitle;
@property (strong, nonatomic) NSURL *detaiLink;
@property (strong, nonatomic) NSURL *detailImageUrl;

@end
