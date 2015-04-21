//
//  NSPreferencesTableViewController.m
//  RSS_TEST_1
//
//  Created by nazar on 4/7/15.
//  Copyright (c) 2015 Nazand. All rights reserved.
//hey

#import "NSPreferencesTableViewController.h"
#import "NSParserManager.h"
#import "MainViewController.h"
@interface NSPreferencesTableViewController ()
{
    NSArray *menuItems;
    NSArray *keyItems;
}
@property (strong, nonatomic)NSArray *favorites;

@end


@implementation NSPreferencesTableViewController

#pragma mark - Load View

-(void)loadView {
    [super loadView];
    
    
}
-(void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    menuItems = @[@"Політика",@"Спорт",@"Світ",@"Технології",@"Культура",@"Мистецтво"];
    
    keyItems = @[@"Politics",@"Sport",@"World",@"Technology",@"Culture",@"Art"];
    
    
    
    //NSLog(@"array =%@",[self.valuesArray objectAtIndex:2]);
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    
        
    
    // Load preferences
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.favorites = [defaults objectForKey:@"keysArray"];
  

}
-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:YES];
    
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    if ([segue.identifier isEqualToString:@"showNews"]) {
        UINavigationController *navController = segue.destinationViewController;
        MainViewController *mainController = [navController childViewControllers].firstObject;
NSString *keyOfCategory = [NSString stringWithFormat:@"%@", [keyItems objectAtIndex:indexPath.row]];
        mainController.keyCat = keyOfCategory;
    }
    
   // UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
 //   destViewController.title = indexPath.
}
-(void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    [self performSegueWithIdentifier:@"showNews" sender:self];
}
#pragma mark - UITableViewDataSource
/*
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.favorites count];
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        return @"Favorites";
   
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [NSString stringWithFormat:@"Section %lu, Row %lu",indexPath.section,indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.favorites objectAtIndex:indexPath.row]];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
*/
/*
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return 20;
    else
    return 1;//[self.keysArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     NSString *identifier = [NSString stringWithFormat:@"Section %lu, Row %lu",indexPath.section,indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
       cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
            }
    if (indexPath.section == 0) {
        
    }else  if (indexPath.section == 1){

        //cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.keysArray objectAtIndex:indexPath.row]];
    }
    
    return cell;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Favorites";
    }else {
    return @"Choose categories:";
    }
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
//NSGroup *sourceGroup
}*/
@end
