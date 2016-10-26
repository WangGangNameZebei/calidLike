//
//  BaseViewController.h
//  claidApp
//
//  Created by kevinpc on 2016/10/18.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomActionSheet.h"

@interface BaseViewController : UIViewController
@property (strong, nonatomic) CustomActionSheet *customActionSheet;
+ (instancetype)create;
- (void)hideTabBarAndpushViewController:(UIViewController *)viewController;
@end
