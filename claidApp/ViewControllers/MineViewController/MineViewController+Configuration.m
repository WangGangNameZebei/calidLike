//
//  MineViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2016/10/19.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "MineViewController+Configuration.h"
#import "AESCrypt.h"
#import "UIColor+Utility.h"
#import "UIScreen+Utility.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation MineViewController (Configuration)

- (void)configureViews{
    [self upgradeAppAction];
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
    if (event.subtype == UIEventSubtypeMotionShake && [[[NSUserDefaults standardUserDefaults] objectForKey:@"shakeswitch"] isEqualToString:@"YES"]) { // 判断是否是摇动结束
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);  //震动
        [self shuakaButtonAction:self.shuaKaButton];
        NSLog(@"摇动结束");
    }  
    return;  
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
     self.SDshukaBiaoshi = boolData;
    if(boolData){
      self.shuaKaButton.backgroundColor = [UIColor colorFromHexCode:@"1296db"];        
    } else {
      self.shuaKaButton.backgroundColor = [UIColor colorFromHexCode:@"C2C2C2"];
    }
    
}

#pragma mark  滚动视图
- (void)carouselViewEdit {
    NSMutableArray *imageArray = [[NSMutableArray alloc] initWithArray: @[@"gsgg1.jpg",@"gsgg2.jpg",@"gsgg3.jpg"]];
    if (!self.carouselView) {
        self.carouselView = [[JYCarousel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen screenWidth],[UIScreen screenHeight] *19/55)
                                                  configBlock:^JYConfiguration *(JYConfiguration *carouselConfig) {
            carouselConfig.pageContollType = MiddlePageControl;
            carouselConfig.pageTintColor = [UIColor whiteColor];
            carouselConfig.currentPageTintColor = [UIColor colorFromHexCode:@"#1296db"];
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
    self.ton.deleGate = self;
    self.litBool = YES;
}




#pragma mark - sendDataToVCDelegate

-(void)switchEditInitPeripheralData:(NSInteger)data {
    switch (data) {
        case 1:                             //  1  为 打卡蓝牙自动连接自动
            [self switchEditInit];
            break;
        case 2:                             //  2  为 自动 连接 发现服务
            self.message = [AESCrypt decrypt:[[NSUserDefaults standardUserDefaults] objectForKey:@"lanyaAESData"] password:AES_PASSWORD];
            if (self.message.length > 0) {
               self.message = @"0180010101FF3344556600000000000000000000000000000000000000000000000000000000000000";
                self.message = [NSString stringWithFormat:@"%@%@",@"cc",self.message];
                 [self.ton sendCommand:self.message];       //发送数据
            } else {
                [self SDshuakabiaoshiAction:YES];
                [self promptInformationActionWarningString:@"暂未发卡!"];
                [self.ton disConnection];
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
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"switch"] isEqualToString:@"YES"])
                [self.ton targetScan];             //目标扫描
            break;
        case 5:
            [self autoConnectAction];  //发现蓝牙 连接刷卡
            break;
        case 6:
            [self alertViewmessage:@"数据返回格式错误!"];
            break;
        case 7:
            [self promptInformationActionWarningString:@"刷卡失败!"];
            break;
        default:
            [self lanyaShuakareturnPromptActioninteger:data];
            break;
    }
    
}

- (IBAction)shuakaButtonAction:(id)sender {     // 手动刷卡
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
        case 0x2b:
            [self alertViewmessage:@"循环用的EEPROM读写出现致命错误!"];
            break;
        case 0x34:
            [self alertViewmessage:@"在设置卡上发现的UID卡!"];
            break;
        case 0x2c:
            [self alertViewmessage:@"CRC错误或老卡变新卡时错误!"];
            break;
        case 0x24:
            [self alertViewmessage:@"被复制或写附属地址出错!"];
            break;
        case 0x04:
            [self alertViewmessage:@"卡被复制!"];
            break;
        case 0x2a:
            [self alertViewmessage:@"在用户卡上发现的UID!"];
            break;
        case 0x30:
            [self alertViewmessage:@"防潜返,已经是进入或出去!"];
            break;
        case 0x1a:
            [self alertViewmessage:@"减次数为0!"];
            break;
        case 0x1b:
            [self alertViewmessage:@"减次数为0!"];
            break;
        case 0x05:
            [self alertViewmessage:@"滚动码处理出错!"];
            break;
        case 0x1f:
            [self alertViewmessage:@"第一次被顶掉!"];
            break;
        case 0x22:
            [self alertViewmessage:@"没有通讯上!"];
            break;
        case 0x23:
            [self alertViewmessage:@"测试卡处理!"];
            break;
        case 0x0d:
            [self alertViewmessage:@"地址不对!"];
            break;
        case 0x20:
            [self promptInformationActionWarningString:@"成功,权限所剩不多!"];
            break;
        case 0x0f:
            [self alertViewmessage:@"准时段可进入!"];
            break;
        case 0x35:
        case 0x36:
        case 0x2e:
        case 0x37:
        case 0x38:
        case 0x21:
        case 0x2f:
        case 0x39:
        case 0x3a:
            [self promptInformationActionWarningString:@"正常进入"];
            break;
        case 0x11:
            [self promptInformationActionWarningString:@"权限过期!"];
            break;
        default:
            [self promptInformationActionWarningString:@"哎呀,什么鬼,出错了吧!"];
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
    NSData *JSONData = [appInfoString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *appInfo = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:&error];
    if (!error && appInfo) {
        NSArray *resultArr = appInfo[@"results"];
        NSDictionary *resultDic = resultArr.firstObject;
        // 版本号
        NSString *version = resultDic[@"version"];
        // 下载地址
      //  NSString *trackViewUrl = resultDic[@"trackViewUrl"];
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
    // MARK： 比较方法
    if ([appVersion compare:serverVersion options:NSNumericSearch] == NSOrderedAscending) {
        return YES;
       }else {
        return NO;
       }
}
#pragma mark -  亮屏幕检测和通知
static void screenLockStateChanged(CFNotificationCenterRef center,void* observer,CFStringRef name,const void* object,CFDictionaryRef userInfo)

{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"brightScreenswitch"] isEqualToString:@"YES"]){
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
