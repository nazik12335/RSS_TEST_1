//
//  ViewController.m
//  RSS_TEST_1
//
//  Created by nazar on 4/6/15.
//  Copyright (c) 2015 Nazand. All rights reserved.
//

#import "ViewController.h"
#import "NSParser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [defaults objectForKey:@"favorites"];
    NSLog(@"viewDidLoad %@",name);
    
}
-(void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [defaults objectForKey:@"favorites"];
    NSLog(@"viewWillAppear %@",name);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
