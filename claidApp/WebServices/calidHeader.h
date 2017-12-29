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
#define LOGIN_URL @"http://192.168.1.104:3657/calid/userLogin.do"
//用户 检测是否注册
#define DETECTION_REGISTER_URL @"http://192.168.1.104:3657/calid/userIsRegister.do"
//用户 退出登录   URL
#define LOGOUT_URL @"http://192.168.1.104:3657/calid/logOut.do"
//用户 注册    URL
#define REGISTER_URL @"http://192.168.1.104:3657/calid/userRegister.do"
//用户 邀请访客   URL
#define INVITAION_VISITOR_URL @"http://192.168.1.104:3657/calid/addTourist.do"
//用户 我是访客   URL
#define VISITOR_URL @"http://192.168.1.104:3657/calid/getKeyByPhoneNum.do"
//管理员  物业激活  续卡 (注册)
#define ADDUSERPROPERTY_URL @"http://192.168.1.104:3657/calid/pptadmin/userToActivateOrRenew.do"
//用户 更新用户数据/后台登陆
#define RENEWAL_USER_DATA_URL @"http://192.168.1.104:3657/calid/accountDetection.do"
//用户 修改密码
#define UP_DATA_USER_PWD_URL  @"http://192.168.1.104:3657/calid/updateUserPwd.do"
//用户 找回密码
#define RETRIEVE_THE_PASSWORD_URL @"http://192.168.1.104:3657/calid/updateUserPwdByPhone.do"
//用户  意见反馈
#define FEED_BACK_URL  @"http://192.168.1.104:3657/calid/userReturnIdea.do"
// 校验发卡器
#define CHECK_STATUS_CARD_URL @"http://192.168.1.104:3657/calid/card/checkStatusOfCard.do"
//管理员 修改小区信息
#define CHANGE_OF_INFO_URL @"http://192.168.1.104:3657/calid/ChangeOfPPTInfo.do"
//管理员 修改小区备注
#define CHANGE_OF_NOTE_URL @"http://192.168.1.104:3657/calid/updatePPTNote.do"
//申请管理员
#define APPLY_PPT_ADMINISTRATOR_URL @"http://192.168.1.104:3657/calid/applyPPTAdministrator.do"
//用户 上传刷卡记录
#define UPLOAD_RECORDING_URL @"http://192.168.1.104:3657/calid/addSwipingCardRecordBatch.do"
//用户 报修上传
#define UPLOAD_REPAIR_URL @"http://192.168.1.104:3657/calid/user/userRepairs/addPPTRepairs.do"
//管理员 物业公告上传
#define UPLOAD_NOTIFICATION_URL @"http://192.168.1.104:3657/calid/pptadmin/doPublishNotification.do"
//社区 用户查看 最新公告
#define PROPERTY_ANNOUNCEMENT_INQUIRIES_URL @"http://192.168.1.104:3657/calid/community/userCommunity/getNewestPPTNotification.do"
//社区 用户查看 公告列表
#define PROPERTY_ANNOUNCEMENT_INQUIRIES_MOST_URL @"http://192.168.1.104:3657/calid/community/userCommunity/getPPTNotification.do"
//社区 用户查看 报修列表
#define USER_REPAIR_QUERY_URL @"http://192.168.1.104:3657/calid/user/userRepairs/getOneseifPPTRepairs.do"

//管理员 查看 报修
#define ADMIN_REVIEW_REPAIR_URL @"http://192.168.1.104:3657/calid/pptadmin/pptRepairs/getUserPPTRepairsByCondition.do"
//管理员 接受／拒绝／删除／完成 报修
#define ADMIN_TO_HANDLE_REPAIR_URL @"http://192.168.1.104:3657/calid/pptadmin/pptRepairs/disposeUserPPTRepairs.do"
