//
//  installViewController+Animation.m
//  claidApp
//
//  Created by kevinpc on 2016/12/26.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "installViewController+Animation.h"
#import "UIScreen+Utility.h"

@implementation installViewController (Animation)

- (void)animationShowPickerConfirmView {
    self.pickerConfirmView.hidden = NO;
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.pickerConfirmView setFrame:CGRectMake(0, [UIScreen screenHeight] - 235,self.view.frame.size.width, 235)];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)animationHidePickerConfirmView {
    [UIView animateWithDuration:0.5 animations:^{
        [self.pickerConfirmView setFrame:CGRectMake(0, [UIScreen screenHeight] + 100,self.view.frame.size.width, 235)];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
          self.pickerConfirmView.hidden = YES;
    }];
    
}
@end
