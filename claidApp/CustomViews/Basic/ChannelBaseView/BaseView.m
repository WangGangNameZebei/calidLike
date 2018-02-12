//
//  BaseView.m
//  claidApp
//
//  Created by kevinpc on 2016/10/18.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "BaseView.h"
#import <Masonry.h>
#import "UIScreen+Utility.h"

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
- (void)promptInformationActionWarningString:(NSString *)warningString {
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc]init];
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:17]};
    CGSize LabelSize = [warningString boundingRectWithSize:CGSizeMake(300, 9000) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    label.text = warningString;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    showview.frame = CGRectMake(([UIScreen screenWidth] - LabelSize.width - 20)/2, [UIScreen screenHeight] - 200, LabelSize.width+20, LabelSize.height+10);
    [UIView animateWithDuration:3.5f animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
    
}

@end
