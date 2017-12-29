//
//  UserRepairTableViewCell.h
//  claidApp
//
//  Created by Zebei on 2017/12/27.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSImageBrowseView.h"
#import "UserRepairQueryLayout.h"


#define USER_REPAIR_TABLEVIEW_CELL @"UserRepairTableViewCell"

@protocol DSImageBrowseCellDelegate <NSObject>
- (void)didClick:(DSImageBrowseView *)imageView atIndex:(NSInteger)index;
- (void)longPress:(DSImageBrowseView *)imageView atIndex:(NSInteger)index;
@end

@interface UserRepairTableViewCell : UITableViewCell<DSImageBrowseDelegate>
@property (nonatomic, weak) id<DSImageBrowseCellDelegate> delegate;
@property (strong, nonatomic) DSImageBrowseView *imageBrowseView;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *infoTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
- (void)setLayout:(UserRepairQueryLayout *)layout;
@end
