//
//  BaseViewController.h
//  claidApp
//
//  Created by kevinpc on 2016/10/18.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomActionSheet.h"
#import "DBTool.h"
#import "UserInfo.h"

@interface BaseViewController : UIViewController<UIAlertViewDelegate>
@property (strong, nonatomic) CustomActionSheet *customActionSheet;
@property (strong,nonatomic)DBTool *baseTool;                   //基础数据库





+ (instancetype)create;
- (void)hideTabBarAndpushViewController:(UIViewController *)viewController;     // 跳转页面
- (void)alertViewmessage:(NSString *)massage;      //无代理提示（确定）

- (NSString *)keyChainIdentifierForVendorString;        //从钥匙串读取UUID
- (void)alertViewDelegateString:(NSString *)stringMassage;  //有代理的提示（确定）
- (void)promptInformationActionWarningString:(NSString *)warningString;       // 提示
- (void)createAdatabaseAction;              //创建数据库
- (void)userInfowriteuserkey:(NSString *)userkey uservalue:(NSString *)uservalue;       //用户信息写入
- (NSString *)userInfoReaduserkey:(NSString *)userkey;              // 用户信息读写

- (BOOL)isMobileNumber:(NSString *)mobileNum;       // 判断是否是电话号码

@end
