//
//  BaseViewController.h
//  claidApp
//
//  Created by kevinpc on 2016/10/18.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomActionSheet.h"

@interface BaseViewController : UIViewController<UIAlertViewDelegate>
@property (strong, nonatomic) CustomActionSheet *customActionSheet;
+ (instancetype)create;
- (void)hideTabBarAndpushViewController:(UIViewController *)viewController;     // 跳转页面
- (void)alertViewmessage:(NSString *)massage;      //无代理提示

- (NSString *)keyChainIdentifierForVendorString;        //从钥匙串读取UUID
- (void)alertViewDelegateString:(NSString *)stringMassage;  //有代理的提示
- (void)promptInformationActionWarningString:(NSString *)warningString;       // 提示
@end
