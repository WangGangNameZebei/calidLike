//
//  KaiKaViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2016/11/5.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "KaiKaViewController+Configuration.h"
#import "UIColor+Utility.h"

@implementation KaiKaViewController (Configuration)

- (void)configureViews {
    [self youXaioqiViewEdit];

}

- (void)youXaioqiViewEdit {
    [self viewlayer:self.youXiaoqiLabelView];
}

#pragma mark UIView 边框编辑
- (void)viewlayer:(UIView *)view {
    view.layer.cornerRadius = 6;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 1;
    view.layer.borderColor = [[UIColor setupGreyColor] CGColor];
}
@end
