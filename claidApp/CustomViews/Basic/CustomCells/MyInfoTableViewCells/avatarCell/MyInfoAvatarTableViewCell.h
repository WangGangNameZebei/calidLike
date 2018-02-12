//
//  MyInfoAvatarTableViewCell.h
//  claidApp
//
//  Created by Zebei on 2018/2/1.
//  Copyright © 2018年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MY_INFO_AVTAR_TABLEVIEW_CELL @"MyInfoAvatarTableViewCell"

@protocol myInfoAvatarTableViewCellDelegate <NSObject>
@optional
- (void)myInfoAvatarTableViewCellDelegate:(id)data;
@end

@interface MyInfoAvatarTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (nonatomic, assign) id <myInfoAvatarTableViewCellDelegate> delegate;
@end
