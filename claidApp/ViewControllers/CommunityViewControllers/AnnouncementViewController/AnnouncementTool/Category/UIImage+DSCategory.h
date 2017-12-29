//
//  UIImage+DSCategory.h
//  DSImageBrowse
//
//  Created by Zebei on 2017/8/5.
//  Copyright © 2017年 Zebei. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIImage (DSCategory)

+ (nullable UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

//保持原来的宽高比
+ (nullable UIImage *)ds_thumbnailWithImage:(UIImage *)image size:(CGSize)size;

@end
NS_ASSUME_NONNULL_END
