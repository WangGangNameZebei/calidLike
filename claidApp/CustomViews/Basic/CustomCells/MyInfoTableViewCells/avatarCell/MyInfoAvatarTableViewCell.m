//
//  MyInfoAvatarTableViewCell.m
//  claidApp
//
//  Created by Zebei on 2018/2/1.
//  Copyright © 2018年 kevinpc. All rights reserved.
//

#import "MyInfoAvatarTableViewCell.h"


@implementation MyInfoAvatarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (IBAction)setupAvatarImageAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(myInfoAvatarTableViewCellDelegate:)]){
        [self.delegate myInfoAvatarTableViewCellDelegate:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
