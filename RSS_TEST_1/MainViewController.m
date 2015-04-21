//
//  ViewController.m
//  SidebarDemo
//
//  Created by Simon on 28/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "NSParserManager.h"
#import "NSNews.h"
#import "NSDetailViewController.h"
#import "NSNewsCell.h"
#import "NSPreferencesTableViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MainViewController ()

@property (strong, nonatomic) NSDictionary *favoritesToShow;
@property (strong, nonatomic) NSMutableArray *newsArray;

@property (strong, nonatomic)NSDictionary *allCategoriesToShow;
@property (strong, nonatomic)NSMutableDictionary *categoriesToShow;
@property (strong, nonatomic)NSArray *keysArray;
@property (strong, nonatomic)NSArray *valuesArray;
@property (strong, nonatomic)NSDictionary *favorites;
@property (strong, nonatomic)NSDictionary *nonFavorites;
@end

@implementation MainViewController

#pragma mark = Load View

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.title = @"News";
    
    self.newsArray = [NSMutableArray array];
    self.categoriesToShow = [NSMutableDictionary dictionary];
    self.keysArray = [NSArray array];
    self.valuesArray = [NSArray array];
    self.keyCat = @"Politics";
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController) {
        [self.sidebarButton setTarget:self.revealViewController];
        [self.sidebarButton setAction:@selector(revealToggle:)];
        //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
   
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor blackColor];
   

    
    if ([defaults objectForKey:@"lastUpdate"]) {
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:[defaults objectForKey:@"lastUpdate"] attributes:attrsDictionary];
        refreshControl.attributedTitle = attributedTitle;

    
    }else {
         NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:@"You haven't refresh before" attributes:attrsDictionary];
        refreshControl.attributedTitle = attributedTitle;
    }

    //refreshControl.backgroundColor = [UIColor purpleColor];
     [refreshControl addTarget:self action:@selector(getRssFeedFromServer) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    // Find out the path of categories.plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"categories" ofType:@"plist"];
    
    // Load the file content and read the data into arrays
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    self.allCategoriesToShow = [dict objectForKey:@"Categories"];
    self.categoriesToShow = [self.allCategoriesToShow objectForKey:@"Sport"];
    self.keysArray = [self.allCategoriesToShow allKeys];
    self.valuesArray = [self.allCategoriesToShow allValues];

    self.favorites = self.allCategoriesToShow;
    

    [defaults setObject:self.favorites forKey:@"favorites"];
    [defaults setObject:self.keysArray forKey:@"keysArray"];
    [defaults setObject:self.nonFavorites forKey:@"non-favorites"];
    [defaults synchronize];

    // Load the nib file
    UINib *nib = [UINib nibWithNibName:@"NSNewsCell" bundle:nil];
    // Register this nib, that contains the cell
    [self.tableView registerNib:nib forCellReuseIdentifier:@"NSNewsCell"];
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.favoritesToShow = [defaults objectForKey:@"favorites"];
}

#pragma mark - API

-(void)getRssFeedFromServer {
    
    if (self.refreshControl) {

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, HH:mm"];  //h:mm a - am/pm format
        NSString *title = [NSString stringWithFormat:@"Last update: %@",[formatter stringFromDate:[NSDate date]]];
        [defaults setObject:title forKey:@"lastUpdate"];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:[defaults objectForKey:@"lastUpdate"] attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
    }
    
       [[NSParserManager sharedInstance]getNewsWithCategory:self.favoritesToShow
                                                        key:self.keyCat
                                                  onSuccess:^(NSArray *news) {
                                                      NSLog(@"Success");

                                                      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                                          
                                                          [self.newsArray removeAllObjects];
                                                          [self.newsArray addObjectsFromArray:[news copy]];
                                                          
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              [self.tableView reloadData];
                                                              [self.refreshControl endRefreshing];
                                                              
                                                          });
                                                      });
                                                      
 
                                                      
                                                      
                                                      /*
                                                      NSMutableArray *newPath = [NSMutableArray array];

                                                      for (int i = (int)[self.newsArray count] - (int)[news count]; i<[self.newsArray count]; i++) {
                                                          [newPath addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                                                      }
                                                      [self.tableView beginUpdates];
                                                      [self.tableView insertRowsAtIndexPaths:newPath withRowAnimation:UITableViewRowAnimationTop];
                                                      [self.tableView endUpdates];*/
                                                      
                                                  }
                                                  onFailure:^(NSError *error, NSInteger statusCode) {
                                                      NSLog(@"error = %@, code = %ld",[error localizedDescription],(long)statusCode);
                                                      [self.refreshControl endRefreshing];
                                                  }];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    
    
   if ([self.newsArray count] >= 1) {
        return [self.newsArray count];

    }else {

    
    
    
    
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    messageLabel.text = @"No data is currently available.Please pull down to refresh";
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
    [messageLabel sizeToFit];
    
    self.tableView.backgroundView = messageLabel;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return 0;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 81.f;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
    // AFTER
    NSNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NSNewsCell"];
    if (!cell) {
        cell = [[NSNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NSNewsCell"];
    }

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    NSNews *news = [self.newsArray objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = news.title;
    cell.thumbnailView.layer.cornerRadius = cell.thumbnailView.frame.size.height /2;
    cell.thumbnailView.layer.masksToBounds = YES;
    cell.thumbnailView.layer.borderWidth = 0;
    NSURLRequest *request = [NSURLRequest requestWithURL:news.imageUrl];
    __weak NSNewsCell *weakCell = cell;
    
    cell.thumbnailView.image = nil;
    if (news.imageUrl) {
        [cell.imageView setImageWithURLRequest:request
                              placeholderImage:nil
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                           weakCell.thumbnailView.image = image;
                                          
                                           [weakCell layoutSubviews];
                                       } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                           
                                       }];

    }else {
        cell.thumbnailView.image = [UIImage imageNamed:@"placeholder.png"];

    }
    
   /*
        cell.titleLabel.text = news.title;
    //cell.thumbnailView.layer.borderWidth = 3.0f;
    //cell.thumbnailView.layer.borderColor = [UIColor whiteColor].CGColor;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *imageData = [NSData dataWithContentsOfURL:news.imageUrl];
        if (imageData) {
            UIImage *image = [UIImage imageWithData:imageData];
            if (image) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSNewsCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell) {
                        cell.thumbnailView.image = image;
                        cell.thumbnailView.layer.cornerRadius = cell.thumbnailView.frame.size.height /2;
                        cell.thumbnailView.layer.masksToBounds = YES;
                        cell.thumbnailView.layer.borderWidth = 0;
                    }
                });

            }
        }
        
    });
    
*/
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        if ([self.newsArray count] > 1) {
            NSNews *news2 = [self.newsArray objectAtIndex:indexPath.row];
            [[segue destinationViewController] setDetailTitle:news2.title];
            [[segue destinationViewController] setDetailImageUrl:news2.imageUrl];
            [[segue destinationViewController] setDetaiLink:news2.link];
        }
        
        
        
        //NSString *string = news2.link;
        //NSLog(@"link before %@",string);
       // NSURL *url = [NSURL URLWithString:string];
        //NSLog(@"url before %@",url);

        
        
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   [self performSegueWithIdentifier:@"showDetail" sender:self];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
