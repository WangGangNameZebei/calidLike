//
//  MineViewController+Animation.m
//  claidApp
//
//  Created by kevinpc on 2016/10/19.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "MineViewController+Animation.h"

@implementation MineViewController (Animation)

- (void)animationShowFunctionView {
    self.functionListContainerView.hidden = NO;
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.functionNSLayoutConstraint.constant = 5;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)animationHideFunctionView {
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.functionNSLayoutConstraint.constant = -340;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.functionListContainerView.hidden = YES;
    }];
}
@end
