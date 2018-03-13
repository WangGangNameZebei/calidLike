//
//  DSImageDemoCell.m
//  DSImageBrowse
//
//  Created by Zebei on 2017/8/9.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "DSImageDemoCell.h"
#import "UIColor+Utility.h"
#import "UIScreen+Utility.h"

@implementation DSImageDemoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imageBrowseView = [[DSImageBrowseView alloc] init];
        _imageBrowseView.delegate = self;
         _titleLabel = [[LMJScrollTextView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) textScrollModel:LMJTextScrollWandering direction:LMJTextScrollMoveLeft];
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor setipBlueColor];
        _timeLabel.numberOfLines = 0;
        _describeLabel = [[UILabel alloc] init];
        _describeLabel.font = [UIFont systemFontOfSize:16];
        _describeLabel.numberOfLines = 0;
        _announcerLabel = [[UILabel alloc] init];
        _announcerLabel.font = [UIFont systemFontOfSize:10];
        _announcerLabel.textColor = [UIColor grayColor];
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor colorFromHexCode:@"#BEBEBE"];
        [self addSubview:_titleLabel];
        [self addSubview:_timeLabel];
        [self addSubview:_describeLabel];
        [self addSubview:_imageBrowseView];
        [self addSubview:_bottomLineView];
        [self addSubview:_announcerLabel];
        self.backgroundColor = [UIColor colorWithIntRed:240 green:240 blue:240];
    }
    return self;
}

- (void)setLayout:(DSDemoLayout *)layout {
    _timeLabel.frame = CGRectMake(5, 5, [UIScreen screenWidth]/5, layout.titleHeight +10);
    _describeLabel.frame = CGRectMake(10, layout.titleHeight+ 22, [UIScreen screenWidth] - 20, layout.descHeight);
    _titleLabel.frame = CGRectMake([UIScreen screenWidth]/5 + 8, 10, [UIScreen screenWidth] / 5 * 4- 11, layout.titleHeight +5);
    _titleLabel.LmjScrollTextViewWidth = [UIScreen screenWidth] / 5 * 4- 11;
    _imageBrowseView.frame = CGRectMake(10, 27 + layout.descHeight + layout.titleHeight, 0, 0);
    _imageBrowseView.layout = layout.imageLayout;
    _announcerLabel.frame = CGRectMake(10, layout.cellHeight - 21, [UIScreen screenWidth] -20, 20);
    _bottomLineView.frame = CGRectMake(0, layout.cellHeight-1, [UIScreen screenWidth], 1);
    
    self.height = layout.cellHeight;
    _describeLabel.text = layout.model.describe;
    [_titleLabel startScrollWithText:layout.model.titlebe textColor:[UIColor setipBlueColor] font:[UIFont systemFontOfSize:19]];
    _timeLabel.text = layout.model.timebe;
    _announcerLabel.text = [NSString stringWithFormat:@"发布者: %@",layout.model.announcerbe];
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
@end
