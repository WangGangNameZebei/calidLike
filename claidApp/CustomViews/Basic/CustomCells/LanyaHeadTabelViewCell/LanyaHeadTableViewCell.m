//
//  LanyaHeadTableViewCell.m
//  claidApp
//
//  Created by kevinpc on 2016/12/17.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "LanyaHeadTableViewCell.h"

@implementation LanyaHeadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     self.selectionStyle = UITableViewCellSelectionStyleNone; 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
