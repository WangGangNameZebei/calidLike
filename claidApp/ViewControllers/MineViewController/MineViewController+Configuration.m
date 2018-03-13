//
//  MineViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2016/10/19.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "MineViewController+Configuration.h"
#import "MineViewController+LogicalFlow.h"
#import "AESCrypt.h"
#import "UIColor+Utility.h"
#import "UIScreen+Utility.h"
#import <AudioToolbox/AudioToolbox.h>
#import "NetWorkJudge.h"
#import "InternetServices.h"

@implementation MineViewController (Configuration)

- (void)configureViews{
    [self netWorkdataAction];
    [self initData];
    [self carouselViewEdit];
    [self addGestRecognizer];
    [self SDshuakabiaoshiAction:YES];
    [self shakeAction];
}
#pragma mark 摇一摇实现
-(void)shakeAction {
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    // 并让自己成为第一响应者
    [self becomeFirstResponder];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"开始摇动");
    return;
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"取消摇动");
    return;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake && [[self userInfoReaduserkey:@"shakeswitch"] isEqualToString:@"YES"]) { // 判断是否是摇动结束
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);  //震动
        [self shuakaButtonAction:self.shuaKaButton];
        NSLog(@"摇动结束");
    }  
    return;  
}
#pragma mark 检测 网络
- (void)netWorkdataAction {
    self.wifiBool = YES;
    [NetWorkJudge StartWithBlock:^(NSInteger NetworkStatus) {
        NSLog(@"%ld",(long)NetworkStatus);
        if(NetworkStatus >0){ //有网络
            NSDate *date=[NSDate date];
            NSDateFormatter *format=[[NSDateFormatter alloc] init];
            [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
            [format setTimeZone:timeZone];
            NSString *timedateStr=[format stringFromDate:date];
            
            [self userInfowriteuserkey:@"netWorkTime" uservalue:timedateStr]; // 存储最后一次网络连接
            [self upgradeAppAction];
            [self loginPostForUsername:[self userInfoReaduserkey:@"userName"] password:[self userInfoReaduserkey:@"passWord"]];
            if (NetworkStatus == 1 && self.wifiBool){
                self.wifiBool = NO;
                [InternetServices uploadRecordingDataAction];
            }
            
        } else  {
            NSString *timedateStr = [self userInfoReaduserkey:@"netWorkTime"];
            if([self isTimeExpiredJudgmentaimsTime:timedateStr span:3]) {
                [InternetServices logOutPOSTkeystr:[self userInfoReaduserkey:@"userName"]];//退出登录
                [self alertViewmessage:@"长时间没有链接网络,请开启网络重新登录"];
            }
        }
    }];
}
#pragma mark检测升级
- (void)upgradeAppAction {
    static NSString *appId = @"1219844769";
    // 返回是否有新版本
    BOOL update = [self checkAppStoreVersionWithAppId:appId];
    // 添加自己的代码 可以弹出一个提示框 这里不实现了
    if (update) {
        [self alertViewDelegateString:@"有新的版本可供检测,是否升级?"];
    }
}

- (void)SDshuakabiaoshiAction:(BOOL)boolData{
    if(boolData){
      self.shuaKaButton.backgroundColor = [UIColor colorFromHexCode:@"1296db"];        
    } else {
      self.shuaKaButton.backgroundColor = [UIColor colorFromHexCode:@"C2C2C2"];
    }
     self.SDshukaBiaoshi = boolData;
}

#pragma mark  滚动视图
- (void)carouselViewEdit {
    NSMutableArray *imageArray = [[NSMutableArray alloc] initWithArray: @[@"advertisment_1.jpg",@"advertisment_2.jpg",@"advertisment_3.jpg"]];
    if (!self.carouselView) {
        self.carouselView = [[JYCarousel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen screenWidth],[UIScreen screenHeight] *7/22)
                                                  configBlock:^JYConfiguration *(JYConfiguration *carouselConfig) {
            carouselConfig.pageContollType = MiddlePageControl;
            carouselConfig.pageTintColor = [UIColor whiteColor];
            carouselConfig.currentPageTintColor = [UIColor setipBlueColor];
            carouselConfig.pushAnimationType = PushCube;
            carouselConfig.placeholder = [UIImage imageNamed:@"zhanweiImage.png"];
            carouselConfig.faileReloadTimes = 5;
            carouselConfig.interValTime = 4.0f;
            return carouselConfig;
                                                      
        } target:self];
        
        [self.JYimageView addSubview:self.carouselView];

     }
        //开始轮播
    [self.carouselView startCarouselWithArray:imageArray];

}

- (void)carouselViewClick:(NSInteger)index{
    NSLog(@"代理方式你点击图片索引index = %ld",(long)index);
}

- (void)initData {
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, screenLockStateChanged, NotificationPwdUI, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);  // 解锁检测        后台可运行(选模式)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(litActionbiaoshi) name:@"litActionbiaoshi" object:nil];       //通知注册
    self.ton = [SingleTon sharedInstance];
    [self.ton initialization];
    self.ton.deleGate = self;
    self.litBool = YES;
}


#pragma mark - mindsendDataToVCDelegate

-(void)switchEditInitPeripheralData:(NSInteger)data {
    switch (data) {
        case 1:                             //  1  为 打卡蓝牙自动连接自动
            [self switchEditInit];
            break;
        case 2:                             //  2  为 自动 连接 发现服务
            self.message = [self userInfoReaduserkey:@"lanyaAESData"];
            self.message = [AESCrypt decrypt:[self userInfoReaduserkey:@"lanyaAESData"] password:AES_PASSWORD];
            if (self.message.length > 0) {
               self.message = @"0180010101FF3344556600000000000000000000000000000000000000000000000000000000000000";
                self.message = [NSString stringWithFormat:@"%@%@",@"cc",self.message];
                 [self.ton sendCommand:self.message];       //发送数据
            } else {
                [self.ton disConnection];
                [self promptInformationActionWarningString:@"暂无数据!"];
                if (self.paybycardTimer){
                    [self.paybycardTimer invalidate];    // 释放函数
                    self.paybycardTimer = nil;
                }
                 [self SDshuakabiaoshiAction:YES];
            }
            break;
        case 3:                             //  3  为 发送数据成功
          [self.ton disConnection];             //断开蓝牙
            break;
        case 4://  4  为 主动断开蓝牙
            if (self.paybycardTimer){
                [self.paybycardTimer invalidate];    // 释放函数
                self.paybycardTimer = nil;
            }
            [self SDshuakabiaoshiAction:YES];
            if ([[self userInfoReaduserkey:@"switch"] isEqualToString:@"YES"])
                [self.ton targetScan];             //目标扫描
            break;
        case 5:
            [self autoConnectAction];  //发现蓝牙 连接刷卡
            break;
        case 6:
            [self alertViewmessage:@"数据返回格式错误!"];
            break;
        case 7:
            [self promptInformationActionWarningString:@"刷卡错误!"];
            break;
        default:
            [self lanyaShuakareturnPromptActioninteger:data];
            break;
    }
    
}

- (IBAction)shuakaButtonAction:(id)sender {     // 手动刷卡
    self.message = [self userInfoReaduserkey:@"lanyaAESData"];
    self.message = [AESCrypt decrypt:[self userInfoReaduserkey:@"lanyaAESData"] password:AES_PASSWORD];
    if (self.message.length < 10) {
       [self promptInformationActionWarningString:@"暂无数据!"];
        return;
    }
    
     if (self.SDshukaBiaoshi){
      [self SDshuakabiaoshiAction:NO];
     self.paybycardTimer = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(paybycardTimerAction) userInfo:nil repeats:NO];
        NSString *strUUid = SINGLE_TON_UUID_STR;
        if (!strUUid) {
            [self.ton startScan]; // 扫描
            return;
        }
      [self autoConnectAction];
    }
}

- (void)paybycardTimerAction{
     [self SDshuakabiaoshiAction:YES];
}

#pragma mark - 空白处收起键盘
- (void)addGestRecognizer{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    tap.numberOfTouchesRequired =1;
    tap.numberOfTapsRequired =1;
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}
- (void)tapped:(UIGestureRecognizer *)gestureRecognizer{
    [self.view endEditing:YES];
}
#pragma mark  自动连接蓝牙函数
- (void)autoConnectAction {
    [self.ton  getPeripheralWithIdentifierAndConnect:SINGLE_TON_UUID_STR];    //连接蓝牙
    
}

#pragma mark - 刷卡数据返回  错误 报告
- (void)lanyaShuakareturnPromptActioninteger:(NSInteger)promptInteger {
    
    switch (promptInteger) {
        case 0x00:
            [self alertViewmessage:@"此卡没有刷设备!"];
            break;
        case 0x2d:
            [self alertViewmessage:@"此卡为新发卡！"];
            break;
        case 0x1f:
        case 0x04:
            [self alertViewmessage:@"此卡被复制过!"];
            break;
        case 0x3c:
        case 0x3d:
            [self alertViewmessage:@"系统自动挂失!"];
            break;
        case 0x12:
            [self alertViewmessage:@"此卡已被挂失!"];
            break;
        case 0x22:
            [self alertViewmessage:@"读卡器通讯错误!"];
            break;
        case 0x0d:
            [self alertViewmessage:@"此卡地址与设备不符!"];
            break;
        case 0x0f:
            [self alertViewmessage:@"此卡不在准进时段内!"];
            break;
        case 0x11:
            [self alertViewmessage:@"此卡有效期已过!"];
            break;
        case 0x1a:
            [self alertViewmessage:@"此卡次数已用完!"];
            break;
        case 0x14:
            [self alertViewmessage:@"此卡次数为0!"];
            break;
        case 0x30:
            [self alertViewmessage:@"防潜返功能启动!"];
            break;
        case 0x33:
            [self alertViewmessage:@"防潜返没有压地感输入!"];
            break;
        case 0x34:
            [self alertViewmessage:@"此设置卡为UID复制卡!"];
            break;
        case 0x2a:
            [self alertViewmessage:@"此用户卡为UID复制卡!"];
            break;
        case 0x2b:
            [self alertViewmessage:@"存储器错误1!"];
            break;
        case 0x3b:
            [self alertViewmessage:@"存储器错误2!"];
            break;
        case 0x2c:
            [self alertViewmessage:@"效验码错误!"];
            break;
        case 0x24:
            [self alertViewmessage:@"刷新附属地址错误!"];
            break;
        case 0x05:
            [self alertViewmessage:@"动态码处理错误!"];
            break;
        case 0x35:
        case 0x3e:
        case 0x36:
        case 0x20:
        case 0x3f:
        case 0x2e:
        case 0x37:
        case 0x40:
        case 0x38:
        case 0x21:
        case 0x41:
        case 0x2f:
        case 0x39:
        case 0x42:
        case 0x3a:
            if ([[self userInfoReaduserkey:@"shockswitch"] isEqualToString:@"YES"])
                     AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);        //进入震动
            [self promptInformationActionWarningString:@"正常进入"];
            break;
        default:
            [self promptInformationActionWarningString:@"出现异常错误！"];
            break;
    }
}

#pragma mark -  检测 版本 号 是否升级
- (BOOL)checkAppStoreVersionWithAppId:(NSString *)appId {
    
    // MARK: 拼接链接，转换成URL
    NSString *checkUrlString = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@", appId];
    NSURL *checkUrl = [NSURL URLWithString:checkUrlString];
    // MARK: 获取网路数据AppStore上app的信息
    NSString *appInfoString = [NSString stringWithContentsOfURL:checkUrl encoding:NSUTF8StringEncoding error:nil];
    // MARK: 字符串转json转字典
    NSError *error = nil;
    if (appInfoString.length < 5 ){
        return NO;
    }
    NSData *JSONData = [appInfoString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *appInfo = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:&error];
    if (!error && appInfo) {
        NSArray *resultArr = appInfo[@"results"];
        NSDictionary *resultDic = resultArr.firstObject;
        // 版本号
        NSString *version = resultDic[@"version"];
        // 下载地址
        //  NSString   trackViewUrl = resultDic[@"trackViewUrl"];
        // FRXME：比较版本号
        
        BOOL upnumber = [self compareVersion:version];
        return upnumber;
    }else {
        // 返回错误 想当于没有更新吧
        return NO;
    }
    
}


- (BOOL)compareVersion:(NSString *)serverVersion {
    // 获取当前版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    // MARK： 比较方法
    if ([appVersion compare:serverVersion options:NSNumericSearch] == NSOrderedAscending) {
        return YES;
       } else {
        return NO;
       }
}
#pragma mark -  亮屏幕检测和通知
static void screenLockStateChanged(CFNotificationCenterRef center,void* observer,CFStringRef name,const void* object,CFDictionaryRef userInfo)

{
    if ([[[BaseViewController alloc]  userInfoReaduserkey:@"brightScreenswitch"] isEqualToString:@"YES"]){
        //创建通知
        NSNotification *notification =[NSNotification notificationWithName:@"litActionbiaoshi" object:nil userInfo:nil];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
}
//  通知 亮屏幕  刷卡
- (void)litActionbiaoshi {
    if (self.litBool){
        self.litBool = NO;
        return;
    }else{
        self.litBool = YES;
     NSString *strUUid = SINGLE_TON_UUID_STR;
     if (!strUUid) {
         [self.ton startScan];  // 扫描
         return;
     }
     [self.ton getPeripheralWithIdentifierAndConnect:SINGLE_TON_UUID_STR];    //连接蓝牙
    }
}
@end
