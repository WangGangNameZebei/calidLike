//
//  MycradInfoTableViewCell.m
//  claidApp
//
//  Created by kevinpc on 2017/5/8.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "MycradInfoTableViewCell.h"

@implementation MycradInfoTableViewCell

+ (instancetype)create {
    MycradInfoTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:MY_CRAD_INFO_TABLEVIEW_CELL owner:nil options:nil] lastObject];
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
     self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateContentText:(NSString *)text {
    self.myInfotextLabel.text = text;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (CGFloat)updateCellHeight {
    CGFloat contentLabelHeight = self.myInfotextLabel.frame.size.height;
    return contentLabelHeight + 10;
}

@end
