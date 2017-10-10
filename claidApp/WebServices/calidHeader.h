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

/* 蓝牙发卡器 uuid*/

#define FAKAQI_TON_UUID_STR [[NSUserDefaults standardUserDefaults] objectForKey:@"fakaqiIdentifierStr"]

/*输出宏*/
#define LOG(...) NSLog(__VA_ARGS__);
#define LOG_METHOD NSLog(@"%s", __func__);
/*解锁屏幕*/
#define NotificationPwdUI CFSTR("com.apple.springboard.hasBlankedScreen")

//登录    URL
#define LOGIN_URL @"https://www.sycalid.cn/calid/userLogin.do"
// 检测是否注册
#define DETECTION_REGISTER_URL @"https://www.sycalid.cn/calid/userIsRegister.do"
//退出登录    URL
#define LOGOUT_URL @"https://www.sycalid.cn/calid/logOut.do"
//注册    URL
#define REGISTER_URL @"https://www.sycalid.cn/calid/userRegister.do"
//邀请访客   URL
#define INVITAION_VISITOR_URL @"https://www.sycalid.cn/calid/addTourist.do"
//我是访客   URL
#define VISITOR_URL @"https://www.sycalid.cn/calid/getKeyByPhoneNum.do"
// 物业激活  续卡 (注册)
#define ADDUSERPROPERTY_URL @"https://www.sycalid.cn/calid/propertyToActivate.do"

// 更新用户数据/后台登陆
#define RENEWAL_USER_DATA_URL @"https://www.sycalid.cn/calid/accountDetection.do"
// 用户修改密码
#define UP_DATA_USER_PWD_URL  @"https://www.sycalid.cn/calid/updateUserPwd.do"
// 用户找回密码
#define RETRIEVE_THE_PASSWORD_URL @"https://www.sycalid.cn/calid/updateUserPwdByPhone.do"
// 意见反馈
#define FEED_BACK_URL  @"https://www.sycalid.cn/calid/userReturnIdea.do"
// 校验发卡器
#define CHECK_STATUS_CARD_URL @"https://www.sycalid.cn/calid/checkStatusOfCard.do"
//修改小区信息
#define CHANGE_OF_INFO_URL @"https://www.sycalid.cn/calid/ChangeOfPPTInfo.do"
//修改小区备注
#define CHANGE_OF_NOTE_URL @"https://www.sycalid.cn/calid/updatePPTNote.do"
