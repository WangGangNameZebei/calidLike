//
//  SingleTon.m
//  BlueTooth4.0
//
//  Created by zebei on 16/5/13.
//  Copyright © 2016年 wanggang. All rights reserved.
//

#import "SingleTon.h"
#import "MineViewController.h"
#import "MineViewController+Configuration.h"
#import "SingleTon+InstallWarden.h"
#import "SingleTon+MainHairpin.h"
#import "SingleTon+tool.h"


@implementation SingleTon

static SingleTon *_instace = nil;

+(id)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}

+(SingleTon *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
    });
    return _instace;
}

+(id)copyWithZone:(struct _NSZone *)zone {
    return _instace;
}

- (void)initialization {
    _manager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    
    self.PeripheralArray = [NSMutableArray array];
    self.delayInSeconds = 3.0;
}


#pragma mark - 处理传进来的字符串并发指令
- (void)sendCommand:(NSString *)String {
    NSString *strHead;
    NSData *writeData;
    NSInteger datalength;
    NSInteger jiequlength = 38;
    if ([[String substringWithRange:NSMakeRange(0,2)] isEqualToString:@"cc"]  &&  String.length < 200) {
       String = [self payByCardInstructionsActionString:String];
    }
    
    if(String.length > 200) {
        if (self.shukaTimer) {
            [self.shukaTimer invalidate];    // 释放函数
            self.shukaTimer = nil;
            LOG(@"关闭刷卡定时器");
        }
        self.shukaTimer = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(shukaShibaiAction) userInfo:nil repeats:NO];
       LOG(@"开启刷卡定时器");
    }
    if ([String isEqualToString:@"aa"] || [String isEqualToString:@"00"]) {
        _jieHhou = YES;
    } else {
        _jieHhou = NO;
    }
    int length = (unsigned)String.length;
    
    int ZeroNum = 210 - length;  // 38
    
    NSString *CommandStr = String;
    
    for (int i = 0; i < ZeroNum; i ++) {
        
        CommandStr = [NSString stringWithFormat:@"%@%@",CommandStr,@"0"];
    }
    
    if (length > 20){   // 长度 大于 20  拆分成  20 字节循环发送  否则 直接发送
        if ([[CommandStr substringWithRange:NSMakeRange(0,2)] isEqualToString:@"cc"]) {
            strHead = @"c";
        }else{
            strHead = @"a";
        }
        datalength =((length-2)/2) %19;
        if (datalength>0) {
            datalength =((length-2)/2) / 19 +1;
        } else {
            datalength =((length-2)/2) / 19;
        }
        CommandStr = [CommandStr substringWithRange:NSMakeRange(2, length-2)];
        for (NSInteger aa = 0; aa <datalength; aa++) {
            if (aa == datalength - 1)
                jiequlength = CommandStr.length - aa*38;
            strHead = [NSString stringWithFormat:@"%@%ld%@",[strHead substringWithRange:NSMakeRange(0,1)],(long)aa,[CommandStr substringWithRange:NSMakeRange(aa*38,jiequlength)]];
            writeData = [self ToDealWithCommandString:strHead StrLenght:strHead.length/2];
            [self writeChar:writeData];
            
        }
    } else {
        writeData = [self ToDealWithCommandString:CommandStr StrLenght:length/2];
        [self writeChar:writeData];
        
    }


}


#pragma mark - 处理输入的字符串指令
- (NSData *)ToDealWithCommandString:(NSString *)String StrLenght:(NSInteger)strlenght {
    NSString *TheTwoCharacters;
    NSInteger aa;
    Byte byte[110] = {};
      for (int j = 0; j < strlenght; j++) {
          TheTwoCharacters =[String substringWithRange:NSMakeRange((2*j),2)];
          aa = [self turnTheHexLiterals:TheTwoCharacters];
           byte[j] = aa;
      }
    NSData *data = [[NSData alloc] initWithBytes:byte length:strlenght];
    return data;
}

#pragma mark - 根据传进来的uuid去连接外设
- (void)getPeripheralWithIdentifierAndConnect:(NSString *)identifierStr {
    [self stopScan];
    if (!self.scanTimer){
       [self.scanTimer invalidate];    // 释放函数
        self.scanTimer = nil;
    }
    NSUUID * uuid = [[NSUUID alloc]initWithUUIDString:identifierStr];
    NSArray *array = [self.manager retrievePeripheralsWithIdentifiers:@[uuid]];
    CBPeripheral *peripheral = [array lastObject];
    _identiFication = YES;
    self.installBool  = NO;
    [self connectClick:peripheral];
    
}

#pragma mark  连接蓝牙名字获取
- (CBPeripheral *)lanyaNameString:(NSString *)uuidString {
    NSUUID * uuid = [[NSUUID alloc]initWithUUIDString:uuidString];
    NSArray *array = [self.manager retrievePeripheralsWithIdentifiers:@[uuid]];
    CBPeripheral *peripheral = [array lastObject];
    return peripheral;
}

#pragma mark  手动连接   蓝牙设备
- (void)shoudongConnectClick:(CBPeripheral *)peripheral {
    _identiFication = NO;
    self.installBool  = NO;
    [self connectClick:peripheral];
}
// 设置卡  连接   
- (void)installShoudongConnectClick:(NSString *)uuids {
    _identiFication = NO;
    self.installBool  = YES;
    
    [self stopScan];
    if (!self.scanTimer){
        [self.scanTimer invalidate];    // 释放函数
        self.scanTimer = nil;
    }
    
    NSUUID * uuid = [[NSUUID alloc]initWithUUIDString:uuids];
    NSArray *array = [self.manager retrievePeripheralsWithIdentifiers:@[uuid]];
    CBPeripheral *peripheral = [array lastObject];
    [self connectClick:peripheral];
  
}
#pragma mark - 扫描
-(void)startScan
{
    _tarScanBool = NO;
    [_manager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
 
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.manager stopScan];
        LOG(@"所有扫描到的外设：%@",self.PeripheralArray);

    });
}
#pragma mark - 目标扫描
- (void)targetScan
{
    _tarScanBool = YES;
    [self.manager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:SINGLE_TON_UUID_STR]] options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES}];
}
#pragma mark - 后台
- (void)lanyaHoutaiAction {
   [self stopScan];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"switch"] isEqualToString:@"YES"]) {
     self.houtaiTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(houtaisaomiaoAction) userInfo:nil repeats:YES];
    }
    LOG(@"开启后台定时器");
    if (self.scanTimer){
       [self.scanTimer invalidate];    // 释放函数
        self.scanTimer = nil;
    }
}

- (void)houtaisaomiaoAction {
    [self getPeripheralWithIdentifierAndConnect:SINGLE_TON_UUID_STR];    //连接蓝牙
}

#pragma mark - 前台
- (void)lanyaQiantaiAction {
    if (self.houtaiTimer) {
        [self.houtaiTimer invalidate];
        self.houtaiTimer = nil;
        [self stopScan];
        LOG(@"关闭后台定时器");
    }
    if (self.manager)
        [self targetScan];
}
//定时器  到时 连接     蓝牙设备
- (void) lianjielanyaAction {
    [self stopScan];
    [self getPeripheralWithIdentifierAndConnect:SINGLE_TON_UUID_STR];
}

#pragma mark - 停止扫描
- (void)stopScan {
    [self.manager stopScan];
    _tarScanBool = NO;
}

#pragma mark - 开始查看服务，蓝牙开启
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            LOG(@"蓝牙已打开,现在可以扫描外设");            
            if ([self.deleGate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
                [self.deleGate switchEditInitPeripheralData:1];
            }
            break;
        default:
            break;
    }
}

#pragma mark - 查到外设时
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    if (_tarScanBool){
        if (self.scanTimer){
          [self.scanTimer invalidate];    // 释放函数
            self.scanTimer = nil;
        }
       self.scanTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(lianjielanyaAction) userInfo:nil repeats:0];
        LOG(@"目标扫描 蓝牙 开启 连接蓝牙定时器(scantime)");
       
    } else {
        NSString *strUUid = SINGLE_TON_UUID_STR;
        if (strUUid.length < 2 && [NSString stringWithFormat:@"%@",peripheral.name].length > 10) {
          if ([[[NSString stringWithFormat:@"%@",peripheral.name]  substringWithRange:NSMakeRange(0,5)] isEqualToString:@"CALID"]) {
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",peripheral.identifier] forKey:@"identifierStr"];  //存储
               if ([self.deleGate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
                   [self.deleGate switchEditInitPeripheralData:5];
               }
              if ([self.installDelegate  respondsToSelector:@selector(installEditInitPeripheralData:)]){
                  [self.installDelegate installEditInitPeripheralData:2];
              }

          }
       }
        if(![self.PeripheralArray containsObject:peripheral])
            [self.PeripheralArray addObject:peripheral];
        
           if ([self.delegate respondsToSelector:@selector(DoSomethingEveryFrame:)])
            [self.delegate DoSomethingEveryFrame:self.PeripheralArray];
        
       if ([self.installDelegate respondsToSelector:@selector(installDoSomethingEveryFrame:)]) {
          [self.installDelegate installDoSomethingEveryFrame:self.PeripheralArray];
        }
    }
}

#pragma mark - 连接外设
-(void)connectClick:(CBPeripheral *)peripheral
{
    
    if (!peripheral) {
        if (_identiFication && [self.deleGate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
            [self.deleGate switchEditInitPeripheralData:4];
        }
        if (!_identiFication && [self.delegate respondsToSelector:@selector(DoSomethingtishiFrame:)]) {
            [self.delegate DoSomethingtishiFrame:@"断开连接!"];
        }
        return;
    }
    
    [self.manager connectPeripheral:peripheral options:@{CBConnectPeripheralOptionNotifyOnConnectionKey: @YES, CBConnectPeripheralOptionNotifyOnDisconnectionKey: @YES, CBConnectPeripheralOptionNotifyOnNotificationKey: @YES,CBCentralManagerScanOptionAllowDuplicatesKey: @YES}];

    _peripheral = peripheral;
    
}
#pragma mark - 发指令
-(void)writeChar:(NSData *)data
{
    if (!_writeCharacteristic) {
        LOG(@"写特征为空");
        return;
    }
    if (!data) {
        LOG(@"指令为空");
        return;
    }
    [_peripheral writeValue:data forCharacteristic:_writeCharacteristic type:CBCharacteristicWriteWithoutResponse];
    
}
- (void)shukaShibaiAction {
    if ([self.deleGate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
        [self.deleGate switchEditInitPeripheralData:7];
    }
    if(self.shukaTimer) {
      [self.shukaTimer invalidate];    // 释放函数
      self.shukaTimer = nil;
      LOG(@"关闭刷卡定时器");
    }
     [self disConnection];
}
#pragma mark - 主动断开设备
-(void)disConnection
{
    
    if (_peripheral != nil)
    {
        LOG(@"主动断开设备");
        [self.manager cancelPeripheralConnection:_peripheral];
        _peripheral = nil;
    }
    
}

#pragma mark - 连接外设成功，开始发现服务
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {

    LOG(@"成功连接 peripheral: %@ ",peripheral);
    self.peripheral = peripheral;
    //[peripheral readRSSI];
    [self.peripheral setDelegate:self];
    [self.peripheral discoverServices:nil];
    LOG(@"扫描服务");
    
}

#pragma mark - 连接外设失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    LOG(@"连接外设失败：%@",error);
}

#pragma mark - RSSI
- (void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(NSError *)error {
   // [peripheral readRSSI];
    int rssi = abs([RSSI intValue]);
    double ci = (rssi - 59) / (10 * 2.0);
    NSString *length = [NSString stringWithFormat:@"发现BLT4.0热点:%@,距离:%.1fm",_peripheral,pow(10,ci)];
    LOG(@"距离：%@",length);

}


#pragma mark - 已发现服务
-(void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    LOG(@"发现服务");
    NSString *strone;
    if (!_identiFication && [self.delegate respondsToSelector:@selector(DoSomethingtishiFrame:)]) {
        [self.delegate DoSomethingtishiFrame:@"连接成功!"];
    }
//    if (!_identiFication && [self.installDelegate respondsToSelector:@selector(installDoSomethingtishiFrame:)]) {
//        [self.installDelegate installDoSomethingtishiFrame:@"成功!"];
//    }
    
    for (CBService *s in peripheral.services) {
        [self.nServices addObject:s];
        strone = [NSString stringWithFormat:@"%@",s.UUID];
         if (strone.length > 8)
            strone= [strone substringWithRange:NSMakeRange(4,4)];
        if ([strone isEqual:@"FFF0"] ) {
            [peripheral discoverCharacteristics:nil forService:s];
        
        }
    }
}

#pragma mark - 已搜索到Characteristics
-(void) peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    LOG(@"发现特征");
    for (CBCharacteristic *c in service.characteristics) {
        NSString *str1 = [NSString stringWithFormat:@"%@",c.UUID];
        if (str1.length > 8)
           str1 = [str1 substringWithRange:NSMakeRange(4,4)];
        if ([str1 isEqualToString:@"FFF6"]) {
            _writeCharacteristic = c;
    
            if (_identiFication && [self.deleGate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
                [self.deleGate switchEditInitPeripheralData:2];
            }
            if (self.installBool  && [self.installDelegate  respondsToSelector:@selector(installEditInitPeripheralData:)]){
                [self.installDelegate installEditInitPeripheralData:1];
            }
        
        }
        if ([str1 isEqualToString:@"FFF7"]) {
            
            [self.peripheral setNotifyValue:YES forCharacteristic:c];
            
        }
    }
    
}

#pragma mark - 根据特征更新通知状态
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
   LOG(@"收到特殊的回调error==%@,是否通知中BOOL==%d.仅仅打印没做处理",error,characteristic.isNotifying);
}

#pragma mark - 获取外设发来的数据，不论是read和notify,获取数据都是从这个方法中读取。
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSInteger jishunumber = 38;
   if (self.receiveData.length == 0)
       self.receiveData = @"";//            令其 数据为 "" 否则 拼接的字符串 头为 NULL
   NSLog(@"===== %@",[self hexadecimalString:characteristic.value]);
    NSString *str1 = [self hexadecimalString:characteristic.value];
    
    if ([self hexadecimalString:characteristic.value].length == 40) {
        if ([[str1 substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"d2"]) {   // 第一串  返回d2结束
            jishunumber = 16;
        } else if ([[str1 substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"b2"]) {       //  刷卡正确返回
            jishunumber = 30;
        } else if ([[str1 substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"ee"]) {        //刷卡错误
            jishunumber = 10;
        } else if ([[str1 substringWithRange:NSMakeRange(0, 8)] isEqualToString:@"72656164"]) {   // 软件读取信息
            jishunumber = 10;
            str1 = [NSString stringWithFormat:@"aa%@",str1];
        } else if ([[str1 substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"f2"]) {   // 第一串
            jishunumber = 30;
        }
        self.receiveData = [NSString stringWithFormat:@"%@%@",self.receiveData,[str1 substringWithRange:NSMakeRange(2, jishunumber)]];                          //截取拼接数据
        if (jishunumber == 38)                      //长度为 38 表示 没拼接完  返回  等待 接收数据
            return;
    } else {
      self.receiveData = [NSString stringWithFormat:@"%@%@",self.receiveData,str1];     // 以前的模块 会用
    }
    
    if  (self.receiveData.length > 104  && self.receiveData.length <= 210 && [self judgmentCardActiondataStr:[self.receiveData substringWithRange:NSMakeRange(0, 2)]] == 1){    // 发卡 接受第一次串数据
        if ([self lanyaDataXiaoyanAction:[self.receiveData substringWithRange:NSMakeRange(2,104)]]) {
          [self sendCommand:@"aa"];
            LOG(@"成功1");
         } else {
            [self sendCommand:@"00"];
            LOG(@"失败1");
            self.receiveData = @"";
        }
    } else if (self.receiveData.length > 200 && [self judgmentCardActiondataStr:[self.receiveData substringWithRange:NSMakeRange(0, 2)]] == 1) {   // 发卡 接受第一次串数据
        
        self.receiveData = [NSString stringWithFormat:@"%@%@",[self.receiveData substringWithRange:NSMakeRange(0,106)],[self.receiveData substringWithRange:NSMakeRange(108,104)]];
        if ([self lanyaDataXiaoyanAction:[self.receiveData substringWithRange:NSMakeRange(106,104)]]){
                    [self hairpinUserCardData:self.receiveData];      //发卡
                    self.receiveData = @"";
                } else {
                    [self sendCommand:@"00"];
                    self.receiveData = [self.receiveData substringWithRange:NSMakeRange(0,108)];
                    LOG(@"失败2");
                }
        
    } else if (self.receiveData.length == 106 && [self judgmentCardActiondataStr:[self.receiveData substringWithRange:NSMakeRange(0, 2)]] == 0){
        if (self.shukaTimer){
            [self.shukaTimer invalidate];    // 释放函数
            self.shukaTimer = nil;
            LOG(@"关闭shukaTimer");
        }
        [self mainHairpinReturnData:self.receiveData];            //刷卡最后 返回 数据
       self.receiveData = @"";
    } else if (self.receiveData.length == 92 || self.receiveData.length == 94) {                 //刷卡 第1串 返回
        if (self.receiveData.length == 94) {
            [self lanyaSendoutDataAction:[self.receiveData substringWithRange:NSMakeRange(2,92)]];
        } else {
          [self lanyaSendoutDataAction:self.receiveData];
        }
        self.receiveData = @"";
        
    } else {
        [self hairpinReadData:self.receiveData];                  //读取
        self.receiveData = @"";
    }
}

#pragma mark - 用于检测中心向外设写数据是否成功
-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{    if (error) {
        LOG(@"ereor:====>%@",error.userInfo);
        
    }else{
        LOG(@"发送数据成功==%@",characteristic.value);
        
    }
}

#pragma mark - 连接意外断开
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    LOG(@"意外断开，执行重连api");
    //  [self connectClick:_peripheral];
    if (_identiFication && [self.deleGate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
        [self.deleGate switchEditInitPeripheralData:4];
    }
    if (!_identiFication && [self.delegate respondsToSelector:@selector(DoSomethingtishiFrame:)]) {
        [self.delegate DoSomethingtishiFrame:@"断开连接!"];
    }
}

@end


