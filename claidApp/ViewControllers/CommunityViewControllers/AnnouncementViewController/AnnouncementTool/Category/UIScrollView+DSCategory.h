//
//  UIScrollView+DSCategory.h
//  DSImageBrowse
//
//  Created by Zebei on 2017/8/7.
//  Copyright © 2017年 Zebei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (DSCategory)

/**
 Scroll content to top.
 
 @param animated  Use animation.
 */
- (void)scrollToTopAnimated:(BOOL)animated;

@end
