//
//  ParkModifyViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2017/9/15.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "ParkModifyViewController+Configuration.h"

@implementation ParkModifyViewController (Configuration)
- (void)configureViews {
    [self textFieldEdit];
    [self addGestRecognizer];
}

- (void)textFieldEdit {
    self.parkAddressTextfield.text = self.addressString;
}

#pragma mark - 空白处收起键盘
- (void)addGestRecognizer {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    tap.numberOfTouchesRequired =1;
    tap.numberOfTapsRequired =1;
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}
- (void)tapped:(UIGestureRecognizer *)gestureRecognizer{
    [self.view endEditing:YES];
}

@end
