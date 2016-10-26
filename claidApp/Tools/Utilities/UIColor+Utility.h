//
//  UIColor+Utility.h
//  ArchitectureProject
//
//  Created by guoshencheng on 6/23/15.
//  Copyright (c) 2015 guoshencheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utility)

+ (instancetype)colorWithIntRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;
+ (instancetype)colorWithIntRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(NSInteger)alpha;
+ (UIColor *)colorFromHexCode:(NSString *)hexString;
//custom color
+ (instancetype)darkGreyLabelColor;
+ (instancetype)blueTintColor;

@end
