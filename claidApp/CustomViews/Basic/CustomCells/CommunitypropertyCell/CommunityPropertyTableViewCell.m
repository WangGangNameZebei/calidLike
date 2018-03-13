//
//  CommunityPropertyTableViewCell.m
//  claidApp
//
//  Created by Zebei on 2018/3/3.
//  Copyright © 2018年 kevinpc. All rights reserved.
//

#import "CommunityPropertyTableViewCell.h"

@implementation CommunityPropertyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
     self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
