//
//  calidHeader.h
//  claidApp
//
//  Created by kevinpc on 2017/1/11.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

/*AES加密宏*/
#define AES_PASSWORD @"ufwjfitn"

/*输出宏*/
#ifdef DEBUG
#define LOG(...) NSLog(__VA_ARGS__);
#define LOG_METHOD NSLog(@"%s", __func__);
#else
#define LOG(...); #define LOG_METHOD;
#endif

//登录    URL
#define LOGIN_URL @"http://192.168.1.107:8080/calid/login.do"
//注册    URL
#define REGISTER_URL @"http://192.168.1.107:8080/calid/addUser.do"
