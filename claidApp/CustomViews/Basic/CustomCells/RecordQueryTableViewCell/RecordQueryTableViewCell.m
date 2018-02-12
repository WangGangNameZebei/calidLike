//
//  RecordQueryTableViewCell.m
//  claidApp
//
//  Created by Zebei on 2018/1/4.
//  Copyright © 2018年 kevinpc. All rights reserved.
//

#import "RecordQueryTableViewCell.h"

@implementation RecordQueryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
