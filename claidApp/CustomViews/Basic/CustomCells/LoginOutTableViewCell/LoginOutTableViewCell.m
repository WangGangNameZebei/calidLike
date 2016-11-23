//
//  LoginOutTableViewCell.m
//  claidApp
//
//  Created by kevinpc on 2016/11/14.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "LoginOutTableViewCell.h"

@implementation LoginOutTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
