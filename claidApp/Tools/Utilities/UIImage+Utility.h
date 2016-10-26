//
//  UIImage+Utility.h
//  SameLike
//
//  Created by guoshencheng on 10/13/15.
//  Copyright © 2015 guoshencheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utility)

+ (UIImage *)imageWithColor:(UIColor*)color;
+ (UIImage *)imageWithView:(UIView *)view;
+ (UIImage *)imageWithView:(UIView *)view size:(CGSize)size;
- (UIImage *)rotateAndScaleWithRatio:(CGFloat)ratio;
- (NSString *)saveWithName:(NSString *)imageName;
+ (UIImage *)fixOrientation:(UIImage *)aImage;
- (UIColor *)mostColor;

@end
