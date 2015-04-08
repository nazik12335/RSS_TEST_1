//
//  NSPreferencesTableViewController.m
//  RSS_TEST_1
//
//  Created by nazar on 4/7/15.
//  Copyright (c) 2015 Nazand. All rights reserved.
//hey

#import "NSPreferencesTableViewController.h"
#import "NSParser.h"

@interface NSPreferencesTableViewController ()
@property (weak, nonatomic)NSDictionary *allCategoriesToShow;
@property (weak, nonatomic)NSMutableDictionary *categoriesToShow;
@end


@implementation NSPreferencesTableViewController

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    //NSDictionary *sources = [NSDictionary dictionaryWithObjectsAndKeys:@"http://k.img.com.ua/rss/ru/technews.xml",@"technology", nil];
    NSString *strr = @"test saving NSUserDefaults";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:strr forKey:@"favorites"];

    [defaults synchronize];
}
-(void)viewDidLoad {
    [super viewDidLoad];
    self.categoriesToShow = [NSMutableDictionary dictionary];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"categories" ofType:@"plist"];
    
    // Load the file content and read the data into arrays
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    self.allCategoriesToShow = [dict objectForKey:@"Categories"];
    self.categoriesToShow = [self.allCategoriesToShow objectForKey:@"Sport"];
    NSString *name = [self.categoriesToShow objectForKey:@"fakty.ua"];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100; //[[NSParser sharedInstance] ];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
static NSString *identifier = @"Cell";
    // Find out the path of categories.plist
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
       cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.categoriesToShow allKeys]];;

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
