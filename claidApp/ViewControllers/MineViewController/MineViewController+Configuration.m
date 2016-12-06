//
//  MineViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2016/10/19.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "MineViewController+Configuration.h"
#import "AESCrypt.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation MineViewController (Configuration)

- (void)configureViews{
    [self initData];
    [self carouselViewEdit];
    [self addGestRecognizer];
}

#pragma mark  滚动视图
- (void)carouselViewEdit {
    NSMutableArray *imageArray = [[NSMutableArray alloc] initWithArray: @[@"https://p1.bqimg.com/524586/894925a41a745ba8.jpg",@"https://p1.bqimg.com/524586/edd59898ac21642f.jpg",@"https://p1.bqimg.com/524586/d277aa654cd60c3d.jpg",@"https://p1.bqimg.com/524586/a49b8d3e1b953f25.jpg",@"https://p1.bqimg.com/524586/972bff3b7a5fb7e1.jpg"]];
    
    if (!self.carouselView) {
        self.carouselView = [[JYCarousel alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 200) configBlock:^JYConfiguration *(JYConfiguration *carouselConfig) {
            carouselConfig.pageContollType = MiddlePageControl;
            carouselConfig.pageTintColor = [UIColor whiteColor];
            carouselConfig.currentPageTintColor = [UIColor blueColor];
            carouselConfig.pushAnimationType = PushCube;
            carouselConfig.placeholder = [UIImage imageNamed:@"zhanweiImage.png"];
            carouselConfig.faileReloadTimes = 5;
            carouselConfig.interValTime = 4.0f;
            return carouselConfig;
        } target:self];
        
        [self.view addSubview:self.carouselView];
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
    self.peripherArray = [NSMutableArray array];
}

- (void)switchEditInit {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"switch"] isEqualToString:@"YES"]){
        [self.zidongSwitch setOn:YES];
        [self zidongSwitchAction:self.zidongSwitch];
    } else {
        [self.zidongSwitch setOn:NO];
    }
}




#pragma mark - sendDataToVCDelegate

- (void)DoSomethingEveryFrame:(NSMutableArray *)array {
    self.peripherArray = array;
}

- (void)recivedPeripheralData:(id)data {

}

-(void)switchEditInitPeripheralData:(NSInteger)data {
    switch (data) {
        case 1:                             //  1  为 打卡蓝牙自动连接自动
            [self switchEditInit];
            break;
        case 2:                             //  2  为 自动 连接 发现服务
             self.message = [AESCrypt decrypt:[[NSUserDefaults standardUserDefaults] objectForKey:@"lanyaAESData"] password:AES_PASSWORD];
            self.message = [NSString stringWithFormat:@"%@%@",@"AA",self.message];
            [self writeDataActionString:self.message];
            break;
        case 3:                             //  3  为 发送数据成功
         [[SingleTon sharedInstance] disConnection];             //断开蓝牙
            break;
        case 4:                             //  4  为 主动断开蓝牙
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"switch"] isEqualToString:@"YES"])
                [[SingleTon sharedInstance] targetScan];             //目标扫描
            break;
        case 5:
             [self alertViewmessage:@"无本地链接!"];
            break;
        case 6:
            [self alertViewmessage:@"数据返回格式错误!"];
            break;
        case 7:
            [self alertViewmessage:@"刷卡失败!"];
            break;
        default:
            [self lanyaShuakareturnPromptActioninteger:data];
            break;
    }
    
}

- (IBAction)shuakaButtonAction:(id)sender {     // 手动刷卡
    [self autoConnectAction];
}

- (IBAction)zidongSwitchAction:(id)sender {   //自动链接
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        SingleTon *ton = [SingleTon sharedInstance];
        NSString *uuidstr = [[NSUserDefaults standardUserDefaults] objectForKey:@"identifierStr"];
        
        if (!uuidstr) {
            NSLog(@"没有本地保存外设identifierStr");
            return;
        }
        
        [ton getPeripheralWithIdentifierAndConnect:uuidstr];
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"switch"];
    } else {
        [self.ton.manager stopScan];  //停止  扫描
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"switch"];
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
    NSString *uuidstr = [[NSUserDefaults standardUserDefaults] objectForKey:@"identifierStr"];
    
    if (!uuidstr) {
        NSLog(@"没有本地保存外设identifierStr");
        return;
    }
    [ton getPeripheralWithIdentifierAndConnect:uuidstr];    //连接蓝牙
    
}
- (void)writeDataActionString:(NSString *)textStr {
    [[SingleTon sharedInstance] sendCommand:textStr];       //发送数据
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
           // self.textView.text = [NSString stringWithFormat:@"%@\n%@",@"正常进入  有循环码处理 2为电梯总线!",self.textView.text];
            break;
        case 0x36:
          //  self.textView.text = [NSString stringWithFormat:@"%@\n%@",@"正常进入  没有处理循环码 2为电梯总线!",self.textView.text];
            break;
        case 0x20:
          //  self.textView.text = [NSString stringWithFormat:@"%@\n%@",@"正常进入  有循环码处理 3为门禁!",self.textView.text];
            break;
        case 0x2e:
          //  self.textView.text = [NSString stringWithFormat:@"%@\n%@",@"正常进入 没有处理循环码 3为门禁!",self.textView.text];
            break;
        case 0x37:
          //  self.textView.text = [NSString stringWithFormat:@"%@\n%@",@"正常进入  有循环码处理 5 楼宇模块!",self.textView.text];
            break;
        case 0x38:
          //  self.textView.text = [NSString stringWithFormat:@"%@\n%@",@"正常进入 没有处理循环码 5 楼宇模块!",self.textView.text];
            break;
        case 0x21:
          //  self.textView.text = [NSString stringWithFormat:@"%@\n%@",@"正常进入  有循环码处理 1 为读卡器!",self.textView.text];
            break;
        case 0x2f:
           // self.textView.text = [NSString stringWithFormat:@"%@\n%@",@"正常进入 没有处理循环码 1 为读卡器!",self.textView.text];
            break;
        case 0x39:
           // self.textView.text = [NSString stringWithFormat:@"%@\n%@",@"正常进入  有循环码处理 4为光耦读卡器!",self.textView.text];
            break;
        case 0x3a:
          //  self.textView.text = [NSString stringWithFormat:@"%@\n%@",@"正常进入 没有处理循环码  4为光耦读卡器!",self.textView.text];
            break;
        default:
            break;
    }
}
@end
