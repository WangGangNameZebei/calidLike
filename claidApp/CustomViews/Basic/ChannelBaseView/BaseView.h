//
//  BaseView.h
//  claidApp
//
//  Created by kevinpc on 2016/10/18.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView
+ (instancetype)create;
- (void)makeConstraintWithLeft:(NSInteger)left top:(NSInteger)top right:(NSInteger)right bottom:(NSInteger)bottom;

- (void)promptInformationActionWarningString:(NSString *)warningString;
@end
