//
//  NSDetailViewController.m
//  SidebarDemo
//
//  Created by Andy on 4/15/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import "NSDetailViewController.h"
#import "NSNews.h"

@interface NSDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *gtitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *showMoreButton;

@end

@implementation NSDetailViewController

-(void)viewDidLoad {

    [super viewDidLoad];
    
    self.showMoreButton.titleLabel.adjustsFontSizeToFitWidth = YES;
   

    //NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    //NSLog(@"self url %@",self.url);
    //Load the request in the UIWebView.
    //[self.webView loadRequest:requestObj];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.gtitle.text = [NSString stringWithFormat:@"%@",self.detailTitle];
    
    if (self.detailImageUrl) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:self.detailImageUrl];
            if (imageData) {
                UIImage *image = [UIImage imageWithData:imageData];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        self.imageView.image = image;
                    });
                }
            }
            
        });

    }else {
        self.imageView.image = [UIImage imageNamed:@"placeholder.png"];
    }
    
    
}

@end
