//
//  InternetServices.h
//  claidApp
//
//  Created by kevinpc on 2017/9/25.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InternetServices : NSObject
+ (void)requestLoginPostForUsername:(NSString *)username password:(NSString *)password;     // token失效 登陆
+ (BOOL)userphoneisrequestPostDataPhoneNumber:(NSString *)phoneNumber;      //检测帐号是否注册 YES 被注册 NO 没有注册
+ (void)logOutPOSTkeystr:(NSString *)keyStr;        //退出登录
+ (void)clearAllUserDefaultsData;        //清除 数据

@end
