//
//  KaiKaViewController+Animation.m
//  claidApp
//
//  Created by kevinpc on 2016/11/5.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "KaiKaViewController+Animation.h"

@implementation KaiKaViewController (Animation)

- (void)imageViewOpenAnimationimageView:(UIImageView *)image {
    [UIView animateWithDuration:.1 delay:0 usingSpringWithDamping:10 initialSpringVelocity:10 options: UIViewAnimationOptionCurveEaseIn animations:^{
         image.transform = CGAffineTransformMakeScale(1.0,-1.0);
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        image.transform = CGAffineTransformMakeScale(1.0,-1.0);
    }];

}

- (void)imageViewCloseAnimationimageView:(UIImageView *)image {
    [UIView animateWithDuration:.1 delay:0 usingSpringWithDamping:10 initialSpringVelocity:10 options: UIViewAnimationOptionCurveEaseIn animations:^{
         image.transform = CGAffineTransformMakeScale(1.0,1.0);
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
         image.transform = CGAffineTransformMakeScale(1.0,1.0);
    }];

}

@end
