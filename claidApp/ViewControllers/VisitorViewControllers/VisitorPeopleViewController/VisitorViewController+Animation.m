//
//  VisitorViewController+Animation.m
//  claidApp
//
//  Created by kevinpc on 2017/3/23.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "VisitorViewController+Animation.h"

@implementation VisitorViewController (Animation)

- (void)animationShowFunctionView {
    self.ownerChoiceView.hidden = NO;

    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.ownerChoiceViewTopConstraint.constant = 5;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)animationHideFunctionView {
    [UIView animateWithDuration:0 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.ownerChoiceViewTopConstraint.constant = -140;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.ownerChoiceView.hidden = YES;
    }];
    

}

@end
