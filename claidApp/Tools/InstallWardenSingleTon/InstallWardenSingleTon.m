//
//  InstallWardensingleTon.m
//  claidApp
//
//  Created by kevinpc on 2017/9/19.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "InstallWardensingleTon.h"
#import "CalidTool.h"
#import "InstallWardensingleTon+Tool.h"
@implementation InstallWardensingleTon


static InstallWardensingleTon *_instaceton = nil;

+(id)iwallocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instaceton = [super allocWithZone:zone];
    });
    return _instaceton;
}

+(InstallWardensingleTon *)iwsharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instaceton = [[self alloc] init];
    });
    return _instaceton;
}

+(id)iwcopyWithZone:(struct _NSZone *)zone {
    return _instaceton;
}

- (void)iwinitialization {
    _iwmanager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    
    self.iwPeripheralArray = [NSMutableArray array];
    self.iwdelayInSeconds = 3.0;
    self.iwbaseViewController = [[BaseViewController alloc] init];
    
}


#pragma mark - 处理传进来的字符串并发指令
- (void)iwsendCommand:(NSString *)String {
    NSString *strHead;
    NSData *writeData;
    NSInteger datalength;
    NSInteger jiequlength = 38;
    if ([[String substringWithRange:NSMakeRange(0,2)] isEqualToString:@"cc"]  &&  String.length < 200) {
        String = [CalidTool payByCardInstructionsActionString:String];
    }
    
    if(String.length > 200) {
        if (self.iwshukaTimer) {
            [self.iwshukaTimer invalidate];    // 释放函数
            self.iwshukaTimer = nil;
            LOG(@"关闭刷卡定时器");
        }
        self.iwshukaTimer = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(iwshukaShibaiAction) userInfo:nil repeats:NO];
        LOG(@"开启刷卡定时器");
    }
    if ([String isEqualToString:@"aa"] || [String isEqualToString:@"00"]) {
        _iwjieHhou = YES;
    } else {
        _iwjieHhou = NO;
    }
    int length = (unsigned)String.length;
    
    int ZeroNum = 210 - length;  // 38
    
    NSString *CommandStr = String;
    
    for (int i = 0; i < ZeroNum; i ++) {
        
        CommandStr = [NSString stringWithFormat:@"%@%@",CommandStr,@"0"];
    }
    
    if (length > 40){   // 长度 大于 40  拆分成  20 字节循环发送  否则 直接发送
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
            writeData = [self iwToDealWithCommandString:strHead StrLenght:strHead.length/2];
            [self iwwriteChar:writeData];
            
        }
    } else {
        writeData = [self iwToDealWithCommandString:CommandStr StrLenght:length/2];
        [self iwwriteChar:writeData];
        
    }
    
    
}


#pragma mark - 处理输入的字符串指令
- (NSData *)iwToDealWithCommandString:(NSString *)String StrLenght:(NSInteger)strlenght {
    NSString *TheTwoCharacters;
    NSInteger aa;
    Byte byte[110] = {};
    for (int j = 0; j < strlenght; j++) {
        TheTwoCharacters =[String substringWithRange:NSMakeRange((2*j),2)];
        aa = [CalidTool turnTheHexLiterals:TheTwoCharacters];
        byte[j] = aa;
    }
    NSData *data = [[NSData alloc] initWithBytes:byte length:strlenght];
    return data;
}

#pragma mark - 根据传进来的uuid去连接外设
- (void)iwgetPeripheralWithIdentifierAndConnect:(NSString *)identifierStr {
    [self iwstopScan];
    if (!self.iwscanTimer){
        [self.iwscanTimer invalidate];    // 释放函数
        self.iwscanTimer = nil;
    }
    NSUUID * uuid = [[NSUUID alloc]initWithUUIDString:identifierStr];
    NSArray *array = [self.iwmanager retrievePeripheralsWithIdentifiers:@[uuid]];
    CBPeripheral *peripheral = [array lastObject];
    _iwidentiFication = YES;
    self.iwinstallBool  = NO;
    [self iwconnectClick:peripheral];
    
}

#pragma mark  连接蓝牙名字获取
- (CBPeripheral *)iwlanyaNameString:(NSString *)uuidString {
    NSUUID * uuid = [[NSUUID alloc]initWithUUIDString:uuidString];
    NSArray *array = [self.iwmanager retrievePeripheralsWithIdentifiers:@[uuid]];
    CBPeripheral *peripheral = [array lastObject];
    return peripheral;
}

#pragma mark  设置卡连接   蓝牙发卡器
- (void)iwshoudongConnectClick:(NSString *)peripheralstr {
    _iwidentiFication = NO;
    self.iwinstallBool  = NO;
    NSUUID * uuid = [[NSUUID alloc]initWithUUIDString:peripheralstr];
    NSArray *array = [self.iwmanager retrievePeripheralsWithIdentifiers:@[uuid]];
    CBPeripheral *peripheral = [array lastObject];
    
    [self iwconnectClick:peripheral];
}
// 设置卡  连接
- (void)iwinstallShoudongConnectClick:(NSString *)uuids {
    _iwidentiFication = NO;
    self.iwinstallBool  = YES;
    
    [self iwstopScan];
    if (!self.iwscanTimer){
        [self.iwscanTimer invalidate];    // 释放函数
        self.iwscanTimer = nil;
    }
    
    NSUUID * uuid = [[NSUUID alloc]initWithUUIDString:uuids];
    NSArray *array = [self.iwmanager retrievePeripheralsWithIdentifiers:@[uuid]];
    CBPeripheral *peripheral = [array lastObject];
    [self iwconnectClick:peripheral];
    
}
#pragma mark - 扫描
-(void)iwstartScan
{
    _iwtarScanBool = NO;
    [_iwmanager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
    
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.iwdelayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.iwmanager stopScan];
        LOG(@"所有扫描到的外设：%@",self.iwPeripheralArray);
        
    });
}
#pragma mark - 目标扫描
- (void)iwtargetScan
{
    _iwtarScanBool = YES;
    [self.iwmanager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:SINGLE_TON_UUID_STR]] options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES}];
}

//定时器  到时 连接     蓝牙设备
- (void)iwlianjielanyaAction {
    [self iwstopScan];
    [self iwgetPeripheralWithIdentifierAndConnect:SINGLE_TON_UUID_STR];
}

#pragma mark - 停止扫描
- (void)iwstopScan {
    [self.iwmanager stopScan];
    _iwtarScanBool = NO;
}

#pragma mark - 开始查看服务，蓝牙开启
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            LOG(@"蓝牙已打开,现在可以扫描外设");
            break;
        default:
            break;
    }
}

#pragma mark - 查到外设时
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    if (_iwtarScanBool){
        if (self.iwscanTimer){
            [self.iwscanTimer invalidate];    // 释放函数
            self.iwscanTimer = nil;
        }
        self.iwscanTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(iwlianjielanyaAction) userInfo:nil repeats:0];
        LOG(@"目标扫描 蓝牙 开启 连接蓝牙定时器(scantime)");
        
    } else {
        NSString *strUUid = SINGLE_TON_UUID_STR;
        if (strUUid.length < 2 && [NSString stringWithFormat:@"%@",peripheral.name].length > 10) {
            if ([[[NSString stringWithFormat:@"%@",peripheral.name]  substringWithRange:NSMakeRange(0,5)] isEqualToString:@"CALID"]) {
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",peripheral.identifier] forKey:@"identifierStr"];  //存储
                if ([self.installDelegate  respondsToSelector:@selector(iwinstallEditInitPeripheralData:)]){
                    [self.installDelegate iwinstallEditInitPeripheralData:2];
                }
                
            }
        } else if ([[NSString stringWithFormat:@"%@",peripheral.name] isEqualToString:@"CALID"]){
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",peripheral.identifier] forKey:@"fakaqiIdentifierStr"];  //存储
            if ([self.installDelegate respondsToSelector:@selector(iwinstallEditInitPeripheralData:)]) {
                [self.installDelegate iwinstallEditInitPeripheralData:4];
            }
        }
        if(![self.iwPeripheralArray containsObject:peripheral])
            [self.iwPeripheralArray addObject:peripheral];
        
        
        
    }
}

#pragma mark - 连接外设
-(void)iwconnectClick:(CBPeripheral *)peripheral
{
    
    [self.iwmanager connectPeripheral:peripheral options:@{CBConnectPeripheralOptionNotifyOnConnectionKey: @YES, CBConnectPeripheralOptionNotifyOnDisconnectionKey: @YES, CBConnectPeripheralOptionNotifyOnNotificationKey: @YES,CBCentralManagerScanOptionAllowDuplicatesKey: @YES}];
    
    _iwperipheral = peripheral;
    
}
#pragma mark - 发指令
-(void)iwwriteChar:(NSData *)data
{
    if (!_iwwriteCharacteristic) {
        LOG(@"写特征为空");
        return;
    }
    if (!data) {
        LOG(@"指令为空");
        return;
    }
    [_iwperipheral writeValue:data forCharacteristic:_iwwriteCharacteristic type:CBCharacteristicWriteWithoutResponse];
    
}
- (void)iwshukaShibaiAction {
    if(self.iwshukaTimer) {
        [self.iwshukaTimer invalidate];    // 释放函数
        self.iwshukaTimer = nil;
        LOG(@"关闭刷卡定时器");
    }
    [self iwdisConnection];
}
#pragma mark - 主动断开设备
-(void)iwdisConnection
{
    if (_iwperipheral != nil)
    {
            LOG(@"主动断开设备");
            [self.iwmanager cancelPeripheralConnection:_iwperipheral];
            _iwperipheral = nil;
    }
    
}

#pragma mark - 连接外设成功，开始发现服务
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    
    LOG(@"成功连接 peripheral: %@ ",peripheral);
    self.iwperipheral = peripheral;
    //[peripheral readRSSI];
    [self.iwperipheral setDelegate:self];
    [self.iwperipheral discoverServices:nil];
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
    NSString *length = [NSString stringWithFormat:@"发现BLT4.0热点:%@,距离:%.1fm",_iwperipheral,pow(10,ci)];
    LOG(@"距离：%@",length);
    
}


#pragma mark - 已发现服务
-(void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    LOG(@"发现服务");
    NSString *strone;
    
    for (CBService *s in peripheral.services) {
        [self.iwnServices addObject:s];
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
            _iwwriteCharacteristic = c;
            if (self.iwinstallBool  && [self.installDelegate  respondsToSelector:@selector(iwinstallEditInitPeripheralData:)]){
                [self.installDelegate iwinstallEditInitPeripheralData:1];
            }
            
            
            if (!_iwidentiFication && !self.iwinstallBool){
                if ([self.installDelegate  respondsToSelector:@selector(iwinstallDoSomethingtishiFrame:)]){
                    [self.installDelegate iwinstallDoSomethingtishiFrame:@"已连接"];
                }
                
            }
            
            
        }
        if ([str1 isEqualToString:@"FFF7"]) {
            
            [self.iwperipheral setNotifyValue:YES forCharacteristic:c];
            
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
    if (self.iwreceiveData.length == 0)
        self.iwreceiveData = @"";//            令其 数据为 "" 否则 拼接的字符串 头为 NULL
    NSLog(@"===== %@",[CalidTool hexadecimalString:characteristic.value]);
    NSString *str1 = [CalidTool hexadecimalString:characteristic.value];
    
    if ([CalidTool hexadecimalString:characteristic.value].length == 40) {
        if ([[str1 substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"d2"]) {   // 第一串  返回d2结束
            jishunumber = 16;
        } else if ([[str1 substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"b2"]) {       //  刷卡正确返回
            jishunumber = 30;
        } else if ([[str1 substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"ee"]) {        //刷卡错误
            if ([[str1 substringWithRange:NSMakeRange(0, 10)] isEqualToString:@"eebb112233"]){
                jishunumber = 12;
                str1 = [NSString stringWithFormat:@"aa%@",[str1 substringWithRange:NSMakeRange(0, 12)]];
            } else {
                jishunumber = 10;
            }
            
        } else if ([[str1 substringWithRange:NSMakeRange(0, 8)] isEqualToString:@"72656164"]) {   // 软件读取信息
            jishunumber = 10;
            str1 = [NSString stringWithFormat:@"aa%@",str1];
        }  else if ([[str1 substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"f2"]) {   // 第一串
            jishunumber = 30;
        }
        self.iwreceiveData = [NSString stringWithFormat:@"%@%@",self.iwreceiveData,[str1 substringWithRange:NSMakeRange(2, jishunumber)]];                          //截取拼接数据
        if (jishunumber == 38)                      //长度为 38 表示 没拼接完  返回  等待 接收数据
            return;
    } else {
        self.iwreceiveData = [NSString stringWithFormat:@"%@%@",self.iwreceiveData,str1];     // 以前的模块 会用
    }
    
    if  (self.iwreceiveData.length > 104  && self.iwreceiveData.length <= 210 && [self judgmentCardActiondataStr:[self.iwreceiveData substringWithRange:NSMakeRange(0, 2)]] == 1){    // 发卡 接受第一次串数据
        if ([CalidTool lanyaDataXiaoyanAction:[self.iwreceiveData substringWithRange:NSMakeRange(2,104)]]) {
            [self iwsendCommand:@"aa"];
            LOG(@"成功1");
        } else {
            [self iwsendCommand:@"00"];
            LOG(@"失败1");
            self.iwreceiveData = @"";
        }
    }  else if (self.iwreceiveData.length > 104  && self.iwreceiveData.length < 210 && [[self.iwreceiveData substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"bb"]){             // 发卡器连接接收数据
        if (!_iwidentiFication && !self.iwinstallBool){
            if ([self.installDelegate  respondsToSelector:@selector(iwinstallDoSomethingtishiFrame:)]){
                [self.installDelegate iwinstallDoSomethingtishiFrame:self.iwreceiveData];
            }
            
        }
        self.iwreceiveData = @"";
        
    }else if (self.iwreceiveData.length > 200 && [self judgmentCardActiondataStr:[self.iwreceiveData substringWithRange:NSMakeRange(0, 2)]] == 1) {   // 发卡 接受第一次串数据
        self.iwreceiveData = [NSString stringWithFormat:@"%@%@",[self.iwreceiveData substringWithRange:NSMakeRange(0,106)],[self.iwreceiveData substringWithRange:NSMakeRange(108,104)]];
        if ([CalidTool lanyaDataXiaoyanAction:[self.iwreceiveData substringWithRange:NSMakeRange(106,104)]]){
            [self hairpinUserCardData:self.iwreceiveData];      //发卡
            self.iwreceiveData = @"";
        } else {
            [self iwsendCommand:@"00"];
            self.iwreceiveData = [self.iwreceiveData substringWithRange:NSMakeRange(0,108)];
            LOG(@"失败2");
        }
        
    } else if (self.iwreceiveData.length == 106 && [self judgmentCardActiondataStr:[self.iwreceiveData substringWithRange:NSMakeRange(0, 2)]] == 0){ // 这里发用户卡 最后信息两段  设置里不需要做任何操作
        if (self.iwshukaTimer){
            [self.iwshukaTimer invalidate];    // 释放函数
            self.iwshukaTimer = nil;
            LOG(@"关闭shukaTimer");
        }
        if ([[self.iwreceiveData substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"b2"] ||  [[self.iwreceiveData substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"a2"]) {
            [self iwsendCommand:@"aa"];
        } else {
            [self iwmainHairpinReturnData:self.iwreceiveData];
        }
        
        
        self.iwreceiveData = @"";
    } else if (self.iwreceiveData.length == 92 || self.iwreceiveData.length == 94) {                 //刷卡 第1串 返回
        if (self.iwreceiveData.length == 94) {
            [self lanyaSendoutDataAction:[self.iwreceiveData substringWithRange:NSMakeRange(2,92)]];
        } else {
            [self lanyaSendoutDataAction:self.iwreceiveData];
        }
        self.iwreceiveData = @"";
        
    } else {
        [self hairpinReadData:self.iwreceiveData];                  //读取
        self.iwreceiveData = @"";
    }
}

#pragma mark - 用于检测中心向外设写数据是否成功
-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (error) {
        LOG(@"ereor:====>%@",error.userInfo);
        
    }else{
        LOG(@"发送数据成功==%@",characteristic.value);
    }
}

#pragma mark - 连接意外断开
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    LOG(@"意外断开，执行重连api");
    if (!_iwidentiFication && !self.iwinstallBool){
        if ([self.installDelegate  respondsToSelector:@selector(iwinstallDoSomethingtishiFrame:)]){
            [self.installDelegate iwinstallDoSomethingtishiFrame:@"已断开"];
        }
    }
    if (!_iwidentiFication && self.iwinstallBool){
        if ([self.installDelegate  respondsToSelector:@selector(iwinstallEditInitPeripheralData:)]){
            [self.installDelegate iwinstallEditInitPeripheralData:6];  // 设置卡 断开链接
        }
    }
}


@end
