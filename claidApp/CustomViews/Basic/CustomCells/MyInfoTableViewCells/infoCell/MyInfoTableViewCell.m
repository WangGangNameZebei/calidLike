//
//  MyInfoTableViewCell.m
//  claidApp
//
//  Created by Zebei on 2018/2/1.
//  Copyright © 2018年 kevinpc. All rights reserved.
//

#import "MyInfoTableViewCell.h"

@implementation MyInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)returntextFieldDelegate {
    self.infoValueTextField.delegate = self;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(myInfoTableViewCellDelegate:)]){
        [self.delegate myInfoTableViewCellDelegate:self.infoValueTextField.text];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
