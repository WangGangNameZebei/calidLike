//
//  UserRepairTableViewCell.m
//  claidApp
//
//  Created by Zebei on 2017/12/27.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "UserRepairTableViewCell.h"
#import "UIColor+Utility.h"
#import "UIScreen+Utility.h"

@implementation UserRepairTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _imageBrowseView = [[DSImageBrowseView alloc] init];
    _imageBrowseView.delegate = self;
    [self addSubview:_imageBrowseView];
}


- (void)setLayout:(UserRepairQueryLayout *)layout {

    self.height = layout.cellHeight;
    self.timeLabel.text = layout.model.timebe;
    self.infoTextLabel.text = layout.model.describe;
    self.statusLabel.text =layout.model.buttonTextbe;
    self.infoTextLabel.frame = CGRectMake(2,31 , [UIScreen screenWidth] - 4, layout.descHeight);
    self.imageBrowseView.frame = CGRectMake(2, 31 + layout.descHeight , 0, 0);
    _imageBrowseView.layout = layout.imageLayout;
}

- (void)imageBrowse:(DSImageBrowseView *)imageView didSelectImageAtIndex:(NSInteger)index {
    
    if ([self.delegate respondsToSelector:@selector(didClick:atIndex:)]) {
        [self.delegate didClick:imageView atIndex:index];
    }
    
}

- (void)imageBrowse:(DSImageBrowseView *)imageView longPressImageAtIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(longPress:atIndex:)]) {
        [self.delegate longPress:imageView atIndex:index];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
