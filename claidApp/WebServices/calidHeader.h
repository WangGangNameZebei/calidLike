//
//  calidHeader.h
//  claidApp
//
//  Created by kevinpc on 2017/1/11.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

/*AES加密宏*/
#define AES_PASSWORD @"ufwjfitn"

/* 蓝牙刷卡的 uuid*/

#define SINGLE_TON_UUID_STR [[NSUserDefaults standardUserDefaults] objectForKey:@"identifierStr"]

/*输出宏*/
#define LOG(...) NSLog(__VA_ARGS__);
#define LOG_METHOD NSLog(@"%s", __func__);
/*解锁屏幕*/
#define NotificationPwdUI CFSTR("com.apple.springboard.hasBlankedScreen")

//登录    URL
#define LOGIN_URL @"http://www.sycalid.cn/api/login.do"
//注册    URL
#define REGISTER_URL @"http://www.sycalid.cn/api/addUser.do"
//邀请访客   URL
#define INVITAION_VISITOR_URL @"http://www.sycalid.cn/api/addTourist.do"
//我是访客   URL
#define VISITOR_URL @"http://www.sycalid.cn/api/getKeyByPhoneNum.do"
// 物业激活  续卡 (注册)
#define ADDUSERPROPERTY_URL  @"http://www.sycalid.cn/api/addUserProperty.do"

// 更新用户数据
#define RENEWAL_USER_DATA_URL  @"http://www.sycalid.cn/api/renewalUserDate.do"
// 用户修改密码
#define UP_DATA_USER_PWD_URL  @"http://www.sycalid.cn/api/updateUserPwd.do"
