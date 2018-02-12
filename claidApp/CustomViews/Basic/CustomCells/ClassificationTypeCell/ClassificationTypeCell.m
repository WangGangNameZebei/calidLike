//
//  ClassificationTypeCell.m
//  SameLike
//
//  Created by 王刚 on 15/10/27.
//  Copyright © 2015年 zebei. All rights reserved.
//

#import "ClassificationTypeCell.h"

@implementation ClassificationTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self classificationViewEdit];
}

- (void)classificationViewEdit {
    self.classificationView = [ClassificationView create];
    self.classificationView.frame = self.bounds;
    [self addSubview:self.classificationView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
