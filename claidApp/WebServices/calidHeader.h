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

//用户 登录    URL
#define LOGIN_URL @"http://192.168.1.106/api/userLogin.do"
//用户 检测是否注册
#define DETECTION_REGISTER_URL @"http://192.168.1.106/api/userIsRegister.do"
//用户 退出登录   URL
#define LOGOUT_URL @"http://192.168.1.106/api/logOut.do"
//用户 注册    URL
#define REGISTER_URL @"http://192.168.1.106/api/userRegister.do"
//用户 邀请访客   URL
#define INVITAION_VISITOR_URL @"http://192.168.1.106/api/addTourist.do"
//用户 我是访客   URL
#define VISITOR_URL @"http://192.168.1.106/api/getKeyByPhoneNum.do"
//管理员  物业激活  续卡 (注册)
#define ADDUSERPROPERTY_URL @"http://192.168.1.106/api/pptadmin/userToActivateOrRenew.do"
//用户 更新用户数据/后台登陆
#define RENEWAL_USER_DATA_URL @"http://192.168.1.106/api/accountDetection.do"
//用户 修改密码
#define UP_DATA_USER_PWD_URL @"http://192.168.1.106/api/updateUserPwd.do"
//用户 获取个人信息
#define USER_INFO_DATD_URL @"http://192.168.1.106/api/getUserInfo.do"
//用户 修改个人信息
#define USER_UPLOAD_INFO_DATD_URL @"http://192.168.1.106/api/updateUserInfo.do"
//用户 找回密码
#define RETRIEVE_THE_PASSWORD_URL @"http://192.168.1.106/api/updateUserPwdByPhone.do"
//用户  意见反馈
#define FEED_BACK_URL  @"http://192.168.1.106/api/userReturnIdea.do"
// 校验发卡器
#define CHECK_STATUS_CARD_URL @"http://192.168.1.106/api/card/checkStatusOfCard.do"
//管理员 修改小区信息
#define CHANGE_OF_INFO_URL @"http://192.168.1.106/api/pptadmin/ChangeOfPPTInfo.do"
//管理员 获取小区信息
#define CHANGE_GET_OF_INFO_URL @"http://192.168.1.106/api/pptadmin/getOfPPTInfo.do"
//管理员 修改小区备注
#define CHANGE_OF_NOTE_URL @"http://192.168.1.106/api/updatePPTNote.do"
//申请管理员
#define APPLY_PPT_ADMINISTRATOR_URL @"http://192.168.1.106/api/applyPPTAdministrator.do"
//用户 上传刷卡记录
#define UPLOAD_RECORDING_URL @"http://192.168.1.106/api/addSwipingCardRecordBatch.do"
//用户 报修上传
#define UPLOAD_REPAIR_URL @"http://192.168.1.106/api/user/userRepairs/addPPTRepairs.do"
//管理员 物业公告上传
#define UPLOAD_NOTIFICATION_URL @"http://192.168.1.106/api/pptadmin/doPublishNotification.do"
//社区 用户查看 最新公告
#define PROPERTY_ANNOUNCEMENT_INQUIRIES_URL @"http://192.168.1.106/api/community/userCommunity/getNewestPPTNotification.do"
//社区 用户查看 公告列表
#define PROPERTY_ANNOUNCEMENT_INQUIRIES_MOST_URL @"http://192.168.1.106/api/community/userCommunity/getPPTNotification.do"
//社区 用户查看 报修列表
#define USER_REPAIR_QUERY_URL @"http://192.168.1.106/api/user/userRepairs/getOneseifPPTRepairs.do"

//管理员 查询 用户刷卡记录
#define ADMIN_RECORD_QUERY_URL @"http://192.168.1.106/api/pptadmin/getCardRecordByCondition.do"
//管理员 查看 报修
#define ADMIN_REVIEW_REPAIR_URL @"http://192.168.1.106/api/pptadmin/pptRepairs/getUserPPTRepairsByCondition.do"
//管理员 接受／拒绝／删除／完成 报修
#define ADMIN_TO_HANDLE_REPAIR_URL @"http://192.168.1.106/api/pptadmin/pptRepairs/disposeUserPPTRepairs.do"
