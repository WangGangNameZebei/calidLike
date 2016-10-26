//
//  UIColor+Utility.m
//  ArchitectureProject
//
//  Created by guoshencheng on 6/23/15.
//  Copyright (c) 2015 guoshencheng. All rights reserved.
//

#import "UIColor+Utility.h"

@implementation UIColor (Utility)

//example
+ (instancetype)darkGreyLabelColor {
    return [UIColor colorWithIntRed:50 green:50 blue:50];
}

+ (instancetype)blueTintColor {
    return [UIColor colorWithIntRed:25 green:149 blue:252];
}

+ (instancetype)colorWithIntRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(NSInteger)alpha {
    return [UIColor colorWithRed:(red / 255.0) green:(green / 255.0) blue:(blue / 255.0) alpha:(alpha / 255.0)];
}

+ (instancetype)colorWithIntRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue {
    return [UIColor colorWithIntRed:red green:green blue:blue alpha:255];
}

+ (UIColor *) colorFromHexCode:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@", [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)], [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)], [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
