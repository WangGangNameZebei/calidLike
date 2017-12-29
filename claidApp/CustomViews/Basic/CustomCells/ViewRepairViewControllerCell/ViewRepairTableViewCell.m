//
//  ViewRepairTableViewCell.m
//  claidApp
//
//  Created by Zebei on 2017/12/23.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "ViewRepairTableViewCell.h"
#import "UIColor+Utility.h"
#import "UIScreen+Utility.h"

@implementation ViewRepairTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _imageBrowseView = [[DSImageBrowseView alloc] init];
    _imageBrowseView.delegate = self;
    [self addSubview:_imageBrowseView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)refuseButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(refuseWithButton:)]) {
        [self.delegate refuseWithButton:sender];
    }
}
- (IBAction)deaiWithButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(dealWithButton:)]) {
        [self.delegate dealWithButton:sender];
    }
}

- (void)setLayout:(ViewRepairLayout *)layout {
    if([layout.model.buttonTextbe isEqualToString:@"处理"]) {
        self.refuseButton.hidden = NO;
        self.dealWithbutton.backgroundColor = [UIColor setipBlueColor];
    } else if([layout.model.buttonTextbe isEqualToString:@"完成"]) {
        self.refuseButton.hidden =YES;
        self.dealWithbutton.backgroundColor = [UIColor colorFromHexCode:@"#FF5809"];
    } else if([layout.model.buttonTextbe isEqualToString:@"已完成"]) {
         self.refuseButton.hidden =YES;
        self.dealWithbutton.backgroundColor = [UIColor colorFromHexCode:@"#82D900"];
    } else  {
         self.refuseButton.hidden =YES;
        self.dealWithbutton.backgroundColor = [UIColor redColor];
    }
     self.height = layout.cellHeight;
     self.timeLabel.text = layout.model.timebe;
     self.phoneNumberLabel.text = layout.model.phoneNumberbe;
     self.infoTextLabel.text = layout.model.describe;
     [self.dealWithbutton setTitle:layout.model.buttonTextbe forState:UIControlStateNormal];

     self.infoTextLabel.frame = CGRectMake(2,48 , [UIScreen screenWidth] - 4, layout.descHeight);
      self.imageBrowseView.frame = CGRectMake(2, 58 + layout.descHeight , 0, 0);
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
@end
