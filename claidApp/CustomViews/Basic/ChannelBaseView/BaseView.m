//
//  BaseView.m
//  claidApp
//
//  Created by kevinpc on 2016/10/18.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "BaseView.h"
#import <Masonry.h>
@implementation BaseView

+ (instancetype)create {
    NSAssert(false, @"-base view should never be created without subclass");
    return nil;
}

- (void)makeConstraintWithLeft:(NSInteger)left top:(NSInteger)top right:(NSInteger)right bottom:(NSInteger)bottom {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(left));
        make.right.equalTo(@(right));
        make.top.equalTo(@(top));
        make.bottom.equalTo(@(bottom));
    }];
}


@end
