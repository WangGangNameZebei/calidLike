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
#define LOGIN_URL @"https://www.sycalid.cn/api/userLogin.do"
//用户 检测是否注册
#define DETECTION_REGISTER_URL @"https://www.sycalid.cn/api/userIsRegister.do"
//用户 退出登录   URL
#define LOGOUT_URL @"https://www.sycalid.cn/api/logOut.do"
//用户 注册    URL
#define REGISTER_URL @"https://www.sycalid.cn/api/userRegister.do"
//用户 邀请访客   URL
#define INVITAION_VISITOR_URL @"https://www.sycalid.cn/api/addTourist.do"
//用户 我是访客   URL
#define VISITOR_URL @"https://www.sycalid.cn/api/getKeyByPhoneNum.do"
//管理员  物业激活  续卡 (注册)
#define ADDUSERPROPERTY_URL @"https://www.sycalid.cn/api/pptadmin/userToActivateOrRenew.do"
//用户 更新用户数据/后台登陆
#define RENEWAL_USER_DATA_URL @"https://www.sycalid.cn/api/accountDetection.do"
//用户 修改密码
#define UP_DATA_USER_PWD_URL @"https://www.sycalid.cn/api/updateUserPwd.do"
//用户 获取个人信息
#define USER_INFO_DATD_URL @"https://www.sycalid.cn/api/getUserInfo.do"
//用户 修改个人信息
#define USER_UPLOAD_INFO_DATD_URL @"https://www.sycalid.cn/api/updateUserInfo.do"
//用户 找回密码
#define RETRIEVE_THE_PASSWORD_URL @"https://www.sycalid.cn/api/updateUserPwdByPhone.do"
//用户  意见反馈
#define FEED_BACK_URL  @"https://www.sycalid.cn/api/userReturnIdea.do"
// 校验发卡器
#define CHECK_STATUS_CARD_URL @"https://www.sycalid.cn/api/card/checkStatusOfCard.do"
//管理员 修改小区信息
#define CHANGE_OF_INFO_URL @"https://www.sycalid.cn/api/pptadmin/ChangeOfPPTInfo.do"
//管理员 获取小区信息
#define CHANGE_GET_OF_INFO_URL @"https://www.sycalid.cn/api/pptadmin/getOfPPTInfo.do"
//用户社区 获取小区信息
#define PROPERTY_GET_OF_INFO_URL @"https://www.sycalid.cn/api/community/userCommunity/getOfPPTInfo.do"
//管理员 修改小区备注
#define CHANGE_OF_NOTE_URL @"https://www.sycalid.cn/api/updatePPTNote.do"
//申请管理员
#define APPLY_PPT_ADMINISTRATOR_URL @"https://www.sycalid.cn/api/applyPPTAdministrator.do"
//用户 上传刷卡记录
#define UPLOAD_RECORDING_URL @"https://www.sycalid.cn/api/addSwipingCardRecordBatch.do"
//用户 报修上传
#define UPLOAD_REPAIR_URL @"https://www.sycalid.cn/api/user/userRepairs/addPPTRepairs.do"
//管理员 物业公告上传
#define UPLOAD_NOTIFICATION_URL @"https://www.sycalid.cn/api/pptadmin/doPublishNotification.do"
//社区 用户查看 最新公告
#define PROPERTY_ANNOUNCEMENT_INQUIRIES_URL @"https://www.sycalid.cn/api/community/userCommunity/getNewestPPTNotification.do"
//社区 用户查看 公告列表
#define PROPERTY_ANNOUNCEMENT_INQUIRIES_MOST_URL @"https://www.sycalid.cn/api/community/userCommunity/getPPTNotification.do"
//社区 用户查看 报修列表
#define USER_REPAIR_QUERY_URL @"https://www.sycalid.cn/api/user/userRepairs/getOneseifPPTRepairs.do"

//管理员 查询 用户刷卡记录
#define ADMIN_RECORD_QUERY_URL @"https://www.sycalid.cn/api/pptadmin/getCardRecordByCondition.do"
//管理员 查看 报修
#define ADMIN_REVIEW_REPAIR_URL @"https://www.sycalid.cn/api/pptadmin/pptRepairs/getUserPPTRepairsByCondition.do"
//管理员 接受／拒绝／删除／完成 报修
#define ADMIN_TO_HANDLE_REPAIR_URL @"https://www.sycalid.cn/api/pptadmin/pptRepairs/disposeUserPPTRepairs.do"
