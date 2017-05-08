//
//  MycradInfoTableViewCell.h
//  claidApp
//
//  Created by kevinpc on 2017/5/8.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MY_CRAD_INFO_TABLEVIEW_CELL @"MycradInfoTableViewCell"
@interface MycradInfoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *myInfoTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *myInfotextLabel;

+ (instancetype)create;
- (void)updateContentText:(NSString *)text;
- (CGFloat)updateCellHeight;
@end
