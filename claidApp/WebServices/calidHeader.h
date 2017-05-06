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
#define LOGIN_URL @"http://139.199.102.233:8080/calid/login.do"
//注册    URL
#define REGISTER_URL @"http://139.199.102.233:8080/calid/addUser.do"
//邀请访客   URL
#define INVITAION_VISITOR_URL @"http://139.199.102.233:8080/calid/addTourist.do"
//我是访客   URL
#define VISITOR_URL @"http://139.199.102.233:8080/calid/getKeyByPhoneNum.do"
