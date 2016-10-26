//
//  CustomActionSheetCell.m
//  claidApp
//
//  Created by kevinpc on 2016/10/18.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "CustomActionSheetCell.h"

@implementation CustomActionSheetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.lineViewHeightConstraint.constant = 0.5;
}

- (void)updateWithContentText:(NSString *)contentText color:(UIColor *)color {
    self.contentLabel.text = contentText;
    self.contentLabel.textColor = color;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
