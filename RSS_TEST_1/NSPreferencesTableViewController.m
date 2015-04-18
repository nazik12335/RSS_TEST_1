//
//  NSPreferencesTableViewController.m
//  RSS_TEST_1
//
//  Created by nazar on 4/7/15.
//  Copyright (c) 2015 Nazand. All rights reserved.
//hey

#import "NSPreferencesTableViewController.h"
#import "NSParserManager.h"
@interface NSPreferencesTableViewController ()

@end


@implementation NSPreferencesTableViewController

#pragma mark - Load View

-(void)loadView {
    [super loadView];
    
    
}
-(void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    //NSLog(@"array =%@",[self.valuesArray objectAtIndex:2]);
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    
        
    /*
    // Load preferences
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.favorites = [defaults objectForKey:@"favorites"];
    self.nonFavorites = [defaults objectForKey:@"non-favorites"];
    NSLog(@"%@",self.favorites);
*/
}
-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:YES];
    
    
}
#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"allCategoriesToShow %lu",[self.allCategoriesToShow count]);
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
        //cell.textLabel.text = [NSString stringWithFormat:@"Favorite #%lu",indexPath.row];
        //cell.textLabel.text = [NSString stringWithFormat:@"%@",];
        
        
        
    }else  if (indexPath.section == 1){

        //cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.keysArray objectAtIndex:indexPath.row]];
        //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[self.valuesArray objectAtIndex:indexPath.row]];
    }
   // cell.textLabel.text = [NSString stringWithFormat:@"Row %lu, Section %lu",indexPath.row,indexPath.section];
    
    return cell;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Favorites";
    }else {
    return @"Choose categories:";
    }
}
/*-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}*/
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
//NSGroup *sourceGroup
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
