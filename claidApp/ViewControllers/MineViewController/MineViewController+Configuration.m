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
#import <Masonry.h>

@implementation MineViewController (Configuration)

- (void)configureViews{
    [self initData];
    [self carouselViewEdit];
    [self addGestRecognizer];
    [self SDshuakabiaoshiAction:YES];
}
#pragma mark检测升级
- (void)upgradeAppAction {
    static NSString *appId = @"xxxxxx";
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
        self.carouselView = [[JYCarousel alloc] initWithFrame:CGRectMake(0, 64, [UIScreen screenWidth], 200) configBlock:^JYConfiguration *(JYConfiguration *carouselConfig) {
            carouselConfig.pageContollType = MiddlePageControl;
            carouselConfig.pageTintColor = [UIColor whiteColor];
            carouselConfig.currentPageTintColor = [UIColor colorFromHexCode:@"#1296db"];
            carouselConfig.pushAnimationType = PushCube;
            carouselConfig.placeholder = [UIImage imageNamed:@"zhanweiImage.png"];
            carouselConfig.faileReloadTimes = 5;
            carouselConfig.interValTime = 4.0f;
            return carouselConfig;
        } target:self];
        
        [self.view addSubview:self.carouselView];
        [self.carouselView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.top.width.offset(64);
            make.right.offset(0);
            make.bottom.equalTo(self.ziDongView.mas_top).with.offset(20);
        }];
     }
    //开始轮播
    [self.carouselView startCarouselWithArray:imageArray];

}

- (void)carouselViewClick:(NSInteger)index{
    NSLog(@"代理方式你点击图片索引index = %ld",index);
}

- (void)initData {
    self.ton = [SingleTon sharedInstance];
    self.ton.deleGate = self;
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
                 [[SingleTon sharedInstance] sendCommand:self.message];       //发送数据
            } else {
                [self SDshuakabiaoshiAction:YES];
                [self promptInformationActionWarningString:@"暂未发卡!"];
                [[SingleTon sharedInstance] disConnection];
            }
            break;
        case 3:                             //  3  为 发送数据成功
         [[SingleTon sharedInstance] disConnection];             //断开蓝牙
            break;
        case 4://  4  为 主动断开蓝牙
            [self SDshuakabiaoshiAction:YES];
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"switch"] isEqualToString:@"YES"])
                [[SingleTon sharedInstance] targetScan];             //目标扫描
            break;
        case 5:
            
            [self promptInformationActionWarningString:@"无本地链接!"];
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
      [self autoConnectAction];
    }
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
    SingleTon *ton = [SingleTon sharedInstance];
    [ton getPeripheralWithIdentifierAndConnect:SINGLE_TON_UUID_STR];    //连接蓝牙
    
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
        case 0x35:
             [self promptInformationActionWarningString:@"正常进入,有循环码处理,2为电梯总线!"];
            break;
        case 0x36:
            [self promptInformationActionWarningString:@"正常进入,没有处理循环码,2为电梯总线!"];
            break;
        case 0x20:
            [self promptInformationActionWarningString:@"正常进入,有处理循环码,3为门禁!"];
            break;
        case 0x2e:
            [self promptInformationActionWarningString:@"正常进入,没有处理循环码,3为门禁!"];
            break;
        case 0x37:
            [self promptInformationActionWarningString:@"正常进入,有处理循环码,5为楼宇模块!"];
            break;
        case 0x38:
            [self promptInformationActionWarningString:@"正常进入,没有处理循环码,5为楼宇模块!"];
            break;
        case 0x21:
            [self promptInformationActionWarningString:@"正常进入,有处理循环码,1为读卡器!"];
            break;
        case 0x2f:
            [self promptInformationActionWarningString:@"正常进入,没有处理循环码,1为读卡器!"];
            break;
        case 0x39:
            [self promptInformationActionWarningString:@"正常进入,有处理循环码,4为光耦读卡器!"];
            break;
        case 0x3a:
            [self promptInformationActionWarningString:@"正常进入,没有处理循环码,4为光耦读卡器!"];
            break;
        default:
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
        NSString *version = resultDic[@"trackName"];
        // 下载地址
      //  NSString *trackViewUrl = resultDic[@"trackViewUrl"];
        // FRXME：比较版本号
        return [self compareVersion:version];
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

@end
