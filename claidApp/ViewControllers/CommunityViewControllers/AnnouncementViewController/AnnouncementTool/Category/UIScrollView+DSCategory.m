//
//  UIScrollView+DSCategory.m
//  DSImageBrowse
//
//  Created by Zebei on 2017/8/7.
//  Copyright © 2017年 Zebei. All rights reserved.
//

#import "UIScrollView+DSCategory.h"

@implementation UIScrollView (DSCategory)



- (void)scrollToTopAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self setContentOffset:off animated:animated];
}

@end
