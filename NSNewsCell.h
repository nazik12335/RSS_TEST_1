//
//  NSNewsCell.h
//  RSS_TEST_1
//
//  Created by nazar on 4/18/15.
//  Copyright (c) 2015 Nazand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSNewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
