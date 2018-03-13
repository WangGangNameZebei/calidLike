//
//  CommunityPropertyTableViewCell.h
//  claidApp
//
//  Created by Zebei on 2018/3/3.
//  Copyright © 2018年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>
#define COMMUNITY_PROPERTY_TABLEVIEW_CELL @"CommunityPropertyTableViewCell"
@interface CommunityPropertyTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;

@end
