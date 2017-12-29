//
//  ViewRepairTableViewCell.h
//  claidApp
//
//  Created by Zebei on 2017/12/23.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSImageBrowseView.h"
#import "ViewRepairLayout.h"

#define VIEW_REPAIR_TABLEVIEW_CELL @"ViewRepairTableViewCell"

@protocol DSImageBrowseCellDelegate <NSObject>

- (void)didClick:(DSImageBrowseView *)imageView atIndex:(NSInteger)index;
- (void)longPress:(DSImageBrowseView *)imageView atIndex:(NSInteger)index;
//按钮点击
- (void)dealWithButton:(id)sender;
- (void)refuseWithButton:(id)sender;
@end

@interface ViewRepairTableViewCell : UITableViewCell <DSImageBrowseDelegate>
@property (nonatomic, weak) id<DSImageBrowseCellDelegate> delegate;
@property (strong, nonatomic) DSImageBrowseView *imageBrowseView;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *infoTextLabel;
@property (strong, nonatomic) IBOutlet UIButton *dealWithbutton;
@property (strong, nonatomic) IBOutlet UIButton *refuseButton;
- (void)setLayout:(ViewRepairLayout *)layout;

@end
