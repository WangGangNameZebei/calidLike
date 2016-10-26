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

/*输出宏*/
#ifdef DEBUG
#define LOG(...) NSLog(__VA_ARGS__);
#define LOG_METHOD NSLog(@"%s", __func__);
#else
#define LOG(...); #define LOG_METHOD;
#endif
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
    _manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    self.PeripheralArray = [NSMutableArray array];
    self.delayInSeconds = 3.0;
}

#pragma mark - 指令字面值转16进制
- (int)turnTheHexLiterals:(NSString *)string {
    
    NSString *FirstNumStr = [string substringWithRange:NSMakeRange(0,1)];
    int a = [self changeToIntString:FirstNumStr];
    NSString *SecondNumStr = [string substringWithRange:NSMakeRange(1,1)];
    int b = [self changeToIntString:SecondNumStr];

    return a*16+b;
    
}

#pragma mark - 处理返回数据并抛出DataHasBeenHandRing通知
- (void)ToDealWithReturnData:(NSData *)data {
    
    Byte *BArray = (Byte *)[data bytes];
    NSString *string = [NSString stringWithFormat:@"%d",BArray[0]];
    for(int i=1;i<[data length];i++) {
        string = [NSString stringWithFormat:@"%@,%d",string,BArray[i]];
    }
    LOG(@"收到的数据==%@",string);
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:DataHasBeenHandRing object:string userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];

}

- (int)changeToIntString:(NSString *)letter {
    
    if ([letter isEqualToString:@"0"]||[letter isEqualToString:@"1"]||[letter isEqualToString:@"2"]||[letter isEqualToString:@"3"]||
        [letter isEqualToString:@"4"]||[letter isEqualToString:@"5"]||[letter isEqualToString:@"6"]||[letter isEqualToString:@"7"]||
        [letter isEqualToString:@"8"]||[letter isEqualToString:@"9"]) {
        return [letter intValue];
    }
    if ([letter isEqualToString:@"a"]||[letter isEqualToString:@"A"]) {
        
        return 10;
        
    }else if ([letter isEqualToString:@"B"]||[letter isEqualToString:@"b"]) {
        
        return 11;
        
    }else if ([letter isEqualToString:@"c"]||[letter isEqualToString:@"C"]) {
        
        return 12;
        
    }else if ([letter isEqualToString:@"D"]||[letter isEqualToString:@"d"]) {
        
        return 13;
        
    } else if ([letter isEqualToString:@"e"]||[letter isEqualToString:@"E"]) {

        return 14;
        
    } else if ([letter isEqualToString:@"f"]||[letter isEqualToString:@"F"]) {
        
        return 15;
        
    }
    return 0;
}

#pragma mark - 处理传进来的字符串并发指令
- (void)sendCommand:(NSString *)String {
    
    int length = (unsigned)String.length;
    
    int ZeroNum = 38-length;
    
    NSString *CommandStr = String;
    
    for (int i = 0; i < ZeroNum; i ++) {
        
        CommandStr = [NSString stringWithFormat:@"%@%@",CommandStr,@"0"];
    }
    
    NSData *data = [self ToDealWithCommandString:CommandStr];
    
    [self writeChar:data];

}


#pragma mark - 处理输入的字符串指令
- (NSData *)ToDealWithCommandString:(NSString *)String {
    
    int CRC = 0;
    
    NSString * TheTwoCharacters = [String substringWithRange:NSMakeRange(0,2)];
    int  a0 = [self turnTheHexLiterals:TheTwoCharacters];
    
    NSString * TheTwoCharacters2 = [String substringWithRange:NSMakeRange(2,2)];
    
    int  a1 = [self turnTheHexLiterals:TheTwoCharacters2];
    NSString * TheTwoCharacters3 = [String substringWithRange:NSMakeRange(4,2)];
    
    int  a2 = [self turnTheHexLiterals:TheTwoCharacters3];
    NSString * TheTwoCharacters4 = [String substringWithRange:NSMakeRange(6,2)];
    
    int  a3 = [self turnTheHexLiterals:TheTwoCharacters4];
    NSString * TheTwoCharacters5 = [String substringWithRange:NSMakeRange(8,2)];
    
    int  a4 = [self turnTheHexLiterals:TheTwoCharacters5];
    NSString * TheTwoCharacters6 = [String substringWithRange:NSMakeRange(10,2)];
    
    int  a5 = [self turnTheHexLiterals:TheTwoCharacters6];
    NSString * TheTwoCharacters7 = [String substringWithRange:NSMakeRange(12,2)];
    
    int  a6 = [self turnTheHexLiterals:TheTwoCharacters7];
    NSString * TheTwoCharacters8 = [String substringWithRange:NSMakeRange(14,2)];
    
    int  a7 = [self turnTheHexLiterals:TheTwoCharacters8];
    NSString * TheTwoCharacters9 = [String substringWithRange:NSMakeRange(16,2)];
    
    int  a8 = [self turnTheHexLiterals:TheTwoCharacters9];
    NSString * TheTwoCharactersa = [String substringWithRange:NSMakeRange(18,2)];
    
    int  a9 = [self turnTheHexLiterals:TheTwoCharactersa];
    NSString * TheTwoCharactersb = [String substringWithRange:NSMakeRange(20,2)];
    
    int  aa = [self turnTheHexLiterals:TheTwoCharactersb];
    NSString * TheTwoCharactersc = [String substringWithRange:NSMakeRange(22,2)];
    
    int  ab = [self turnTheHexLiterals:TheTwoCharactersc];
    NSString * TheTwoCharactersd = [String substringWithRange:NSMakeRange(24,2)];
    
    int  ac = [self turnTheHexLiterals:TheTwoCharactersd];
    NSString * TheTwoCharacterse = [String substringWithRange:NSMakeRange(26,2)];
    
    int  ad = [self turnTheHexLiterals:TheTwoCharacterse];
    NSString * TheTwoCharactersf = [String substringWithRange:NSMakeRange(28,2)];
    
    int  ae = [self turnTheHexLiterals:TheTwoCharactersf];
    
    NSString * TheTwoCharactersf1 = [String substringWithRange:NSMakeRange(30,2)];
    
    int  ae1 = [self turnTheHexLiterals:TheTwoCharactersf1];
    NSString * TheTwoCharactersf2 = [String substringWithRange:NSMakeRange(32,2)];
    
    int  ae2 = [self turnTheHexLiterals:TheTwoCharactersf2];
    
    NSString * TheTwoCharactersf3 = [String substringWithRange:NSMakeRange(34,2)];
    
    int  ae3 = [self turnTheHexLiterals:TheTwoCharactersf3];
    
    NSString * TheTwoCharactersf4 = [String substringWithRange:NSMakeRange(36,2)];
    
    int  ae4 = [self turnTheHexLiterals:TheTwoCharactersf4];

    
    
    
   CRC = a0+a1+a2+a3+a4+a5+a6+a7+a8+a9+aa+ab+ac+ad+ae+ae1+ae2+ae3+ae4;
    
    CRC = CRC & 0xFF;
    
    Byte byte[] = {a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,aa,ab,ac,ad,ae,ae1,ae2,ae3,ae4,CRC};
    
    NSData *data = [[NSData alloc] initWithBytes:byte length:20];
    
    return data;
}

#pragma mark - 根据传进来的uuid去连接外设
- (void)getPeripheralWithIdentifierAndConnect:(NSString *)identifierStr {
    self.tarScanBool = NO;
    NSUUID * uuid = [[NSUUID alloc]initWithUUIDString:identifierStr];
    
    NSArray *array = [self.manager retrievePeripheralsWithIdentifiers:@[uuid]];
    
    CBPeripheral *peripheral = [array lastObject];
    [self connectClick:peripheral];
    _identiFication = YES;
    
}

#pragma mark - 扫描
-(void)startScan
{
    _tarScanBool = NO;
    LOG(@"正在扫描外设...");
    [_manager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];

    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.manager stopScan];
        LOG(@"扫描超时,停止扫描");
        LOG(@"所有扫描到的外设：%@",self.PeripheralArray);

    });
}
#pragma mark - 目标扫描
- (void)targetScan
{
    _tarScanBool = YES;
    [self.manager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:@"0xFFF0"]] options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
    
}
- (void) lianjielanyaAction {
    [self getPeripheralWithIdentifierAndConnect:[[NSUserDefaults standardUserDefaults] objectForKey:@"identifierStr"]];
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
            if ([self.delegate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
                [self.delegate switchEditInitPeripheralData:1];
            }
            break;
        default:
            break;
    }
}

#pragma mark - 查到外设时
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSUUID * uuid = [[NSUUID alloc]initWithUUIDString:[[NSUserDefaults standardUserDefaults] objectForKey:@"identifierStr"]];
    NSArray *array = [self.manager retrievePeripheralsWithIdentifiers:@[uuid]];
    CBPeripheral *chucunPeripheral = [array lastObject];
    if (_tarScanBool && [peripheral.name isEqualToString:chucunPeripheral.name]){
       [self.scanTimer invalidate];    // 释放函数
        [self stopScan];
        [self targetScan];
        self.scanTimer = [NSTimer scheduledTimerWithTimeInterval:4.5 target:self selector:@selector(lianjielanyaAction) userInfo:nil repeats:NO];
        
    } else if (!_tarScanBool){
        _tarScanBool = NO;
        if(![self.PeripheralArray containsObject:peripheral])
            
            [self.PeripheralArray addObject:peripheral];
        
        if ([self.delegate respondsToSelector:@selector(DoSomethingEveryFrame:)])
            
            [self.delegate DoSomethingEveryFrame:self.PeripheralArray];
    }
}

#pragma mark - 连接外设
-(void)connectClick:(CBPeripheral *)peripheral
{
    
    if (!peripheral) {
        
        [self.delegate recivedPeripheralData:@"当前外设为空，可能为主动断开，不需重连，或为尚未扫描到设备"];
        if ([self.delegate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
            [self.delegate switchEditInitPeripheralData:4];
        }

        return;
    }
    if ([self.delegate respondsToSelector:@selector(recivedPeripheralData:)]) {
        
        [self.delegate recivedPeripheralData:peripheral];
    
    }
    
    [self.manager connectPeripheral:peripheral options:@{CBConnectPeripheralOptionNotifyOnConnectionKey: @YES, CBConnectPeripheralOptionNotifyOnDisconnectionKey: @YES, CBConnectPeripheralOptionNotifyOnNotificationKey: @YES}];

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
    LOG(@"外设...==%@",_peripheral);
    
    [_peripheral writeValue:data forCharacteristic:_writeCharacteristic type:CBCharacteristicWriteWithoutResponse];
    
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
    if ([self.delegate respondsToSelector:@selector(recivedPeripheralData:)]) {
        [self.delegate recivedPeripheralData:@"连接成功"];
    
}
    LOG(@"成功连接 peripheral: %@ ",peripheral);
    self.peripheral = peripheral;
    [self.peripheral setDelegate:self];
    [self.peripheral discoverServices:nil];
    
    LOG(@"扫描服务");
    
}

#pragma mark - 连接外设失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    LOG(@"连接外设失败：%@",error);
}

#pragma mark - 已更新RSSI
-(void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error
{
    int rssi = abs([peripheral.RSSI intValue]);
    double ci = (rssi - 49) / (10 * 4.);
    NSString *length = [NSString stringWithFormat:@"发现BLT4.0热点:%@,距离:%.1fm",_peripheral,pow(10,ci)];
    LOG(@"距离：%@",length);
    NSString *str = [NSString stringWithFormat:@"距离：%@",length];
    if ([self.delegate respondsToSelector:@selector(recivedPeripheralData:)]) {
        [self.delegate recivedPeripheralData:str];
    
    }
}

#pragma mark - 已发现服务
-(void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    LOG(@"发现服务");
    if ([self.delegate respondsToSelector:@selector(recivedPeripheralData:)]) {
        [self.delegate recivedPeripheralData:@"发现服务"];
    
    }
    
    for (CBService *s in peripheral.services) {
        [self.nServices addObject:s];
        if ([s.UUID isEqual:[CBUUID UUIDWithString:@"0xFFF0"]]) {
            [peripheral discoverCharacteristics:nil forService:s];
            if ([self.delegate respondsToSelector:@selector(recivedPeripheralData:)]) {
            [self.delegate recivedPeripheralData:@"发现手环服务"];
            }
        }
    }
}

#pragma mark - 已搜索到Characteristics
-(void) peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    
    LOG(@"发现特征");
    if ([self.delegate respondsToSelector:@selector(recivedPeripheralData:)]) {
        
        [self.delegate recivedPeripheralData:@"发现特征"];
    
    }

    for (CBCharacteristic *c in service.characteristics) {
        if ([c.UUID isEqual:[CBUUID UUIDWithString:@"0xFFF6"]]) {
            _writeCharacteristic = c;
            if ([self.delegate respondsToSelector:@selector(recivedPeripheralData:)]) {
                
                [self.delegate recivedPeripheralData:@"发现写的特征，已保存"];
            }
            
            if (_identiFication && [self.delegate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
                [self.delegate switchEditInitPeripheralData:2];
            }
        
        }
        if ([c.UUID isEqual:[CBUUID UUIDWithString:@"0xFFF7"]]) {
            [self.peripheral setNotifyValue:YES forCharacteristic:c];
            
            if ([self.delegate respondsToSelector:@selector(recivedPeripheralData:)]) {
                
                [self.delegate recivedPeripheralData:@"发现读的特征，已保存"];

            }
        }
    }
    _identiFication = NO;
}

#pragma mark - 根据特征更新通知状态
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    
    LOG(@"收到特殊的回调error==%@,是否通知中BOOL==%d.仅仅打印没做处理",error,characteristic.isNotifying);
//    if (error)
//    {
//        LOG(@"didUpdateNotificationState: %@", error.localizedDescription);
//    }
//    
//    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:kCharacteristicUUID]] )
//    {
//        // Notification has started
//    if (characteristic.isNotifying)
//    {
//        LOG(@"Notification began on %@", characteristic);
//        [peripheral readValueForCharacteristic:characteristic];
//    }
//    else
//    { // Notification has stopped
//        // so disconnect from the peripheral
//        LOG(@"Notification stopped on %@.  Disconnecting", characteristic);
//        [self.manager cancelPeripheralConnection:self.peripheral];
//    }
//    }
}

#pragma mark - 获取外设发来的数据，不论是read和notify,获取数据都是从这个方法中读取。
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    LOG(@"收到的update数据：%@",characteristic.value);
    
    [self ToDealWithReturnData:characteristic.value];
    
    NSString *str = [NSString stringWithFormat:@"收到数据：%@",characteristic.value];
    
    if ([self.delegate respondsToSelector:@selector(recivedPeripheralData:)]) {
        
        [self.delegate recivedPeripheralData:str];
    
    }
}

#pragma mark - 用于检测中心向外设写数据是否成功
-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        LOG(@"ereor:====>%@",error.userInfo);
        if ([self.delegate respondsToSelector:@selector(recivedPeripheralData:)]) {
            [self.delegate recivedPeripheralData:error.userInfo];
        
    }
        [self.delegate recivedPeripheralData:error.userInfo];
        
    }else{
        LOG(@"发送数据成功==%@",characteristic.value);
        if ([self.delegate respondsToSelector:@selector(recivedPeripheralData:)]) {
        [self.delegate recivedPeripheralData:@"发送数据成功"];
        }
        if ([self.delegate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
            [self.delegate switchEditInitPeripheralData:3];
        }
    }
}

#pragma mark - 连接意外断开
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    LOG(@"==>%@",error);
    LOG(@"意外断开，执行重连api");
    
    if ([self.delegate respondsToSelector:@selector(recivedPeripheralData:)]) {
        
        [self.delegate recivedPeripheralData:@"已断开连接"];
    }

    [self connectClick:_peripheral];
    
}

@end


