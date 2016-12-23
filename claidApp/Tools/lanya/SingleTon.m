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
#import <AESCrypt.h>

/*输出宏*/
#define AES_PASSWORD @"ufwjfitn"
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
    _manager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    
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
    if(String.length > 200)
        if (self.shukaTimer) {
            [self.shukaTimer invalidate];    // 释放函数
            self.shukaTimer = nil;
            LOG(@"关闭刷卡定时器");
        }
        self.shukaTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(shukaShibaiAction) userInfo:nil repeats:NO];
       LOG(@"开启刷卡定时器");
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
    
    NSData *data = [self ToDealWithCommandString:CommandStr StrLenght:length/2];
    
    [self writeChar:data];

}


#pragma mark - 处理输入的字符串指令
- (NSData *)ToDealWithCommandString:(NSString *)String StrLenght:(NSInteger)strlenght {
    NSString *TheTwoCharacters;
    int aa;
    Byte byte[105] = {};
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
        LOG(@"关闭Scantime");
    }
    NSUUID * uuid = [[NSUUID alloc]initWithUUIDString:identifierStr];
    NSArray *array = [self.manager retrievePeripheralsWithIdentifiers:@[uuid]];
    CBPeripheral *peripheral = [array lastObject];
    [self connectClick:peripheral];
    _identiFication = YES;
    
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
    [self connectClick:peripheral];
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
    [self.manager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:@"0xFFF0"]] options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES}];
   
    
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
        LOG(@"关闭Scantime");
    }
  
}

- (void)houtaisaomiaoAction {
    NSString *uuidstr = [[NSUserDefaults standardUserDefaults] objectForKey:@"identifierStr"];
    
    if (!uuidstr) {
        if ( [self.deleGate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
            [self.deleGate switchEditInitPeripheralData:5];
        }
        return;
    }
    [self getPeripheralWithIdentifierAndConnect:uuidstr];    //连接蓝牙

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
//    NSUUID * uuid = [[NSUUID alloc]initWithUUIDString:[[NSUserDefaults standardUserDefaults] objectForKey:@"identifierStr"]];
//    NSArray *array = [self.manager retrievePeripheralsWithIdentifiers:@[uuid]];
//    CBPeripheral *chucunPeripheral = [array lastObject];   /[peripheral.name isEqualToString:chucunPeripheral.name]
    if (_tarScanBool){
        if (self.scanTimer){
          [self.scanTimer invalidate];    // 释放函数
            self.scanTimer = nil;
            LOG(@"关闭Scantime");
        }
       self.scanTimer = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(lianjielanyaAction) userInfo:nil repeats:NO];
        LOG(@"目标扫描 蓝牙 开启 连接蓝牙定时器(scantime)");
       
    } else {
        
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
    LOG(@"外设...==%@",_peripheral);
    
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
//    if (!_shukaTimer)
//     self.shukaTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(shukaShibaiAction) userInfo:nil repeats:NO];
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
    if (!_identiFication && [self.delegate respondsToSelector:@selector(DoSomethingtishiFrame:)]) {
        [self.delegate DoSomethingtishiFrame:@"连接成功!"];
    }
    
    for (CBService *s in peripheral.services) {
        [self.nServices addObject:s];
        if ([s.UUID isEqual:[CBUUID UUIDWithString:@"0xFFF0"]]) {
            [peripheral discoverCharacteristics:nil forService:s];
        
        }
    }
}

#pragma mark - 已搜索到Characteristics
-(void) peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    
    LOG(@"发现特征");
  

    for (CBCharacteristic *c in service.characteristics) {
        if ([c.UUID isEqual:[CBUUID UUIDWithString:@"0xFFF6"]]) {
            _writeCharacteristic = c;
    
            if (_identiFication && [self.deleGate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
                [self.deleGate switchEditInitPeripheralData:2];
            }
          
        
        }
        if ([c.UUID isEqual:[CBUUID UUIDWithString:@"0xFFF7"]]) {
            
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
   if (self.receiveData.length == 0)
       self.receiveData = @"";
   NSLog(@"===== %@",[self hexadecimalString:characteristic.value]);
    NSString *str1 = [self hexadecimalString:characteristic.value];
    self.receiveData = [NSString stringWithFormat:@"%@%@",self.receiveData,str1];
    if  (self.receiveData.length > 106  && self.receiveData.length <= 214){
        if ([self lanyaDataXiaoyanAction:[self.receiveData substringWithRange:NSMakeRange(4,104)]]) {
          [self sendCommand:@"aa"];
            LOG(@"成功1");
         } else {
            [self sendCommand:@"00"];
            LOG(@"失败1");
            self.receiveData = @"";
        }
    } else if (self.receiveData.length > 214) {
                if ([self lanyaDataXiaoyanAction:[self.receiveData substringWithRange:NSMakeRange(112,104)]]){
                    NSString *str = [NSString stringWithFormat:@"收到数据：%@",characteristic.value];
                    LOG(@"收到的String 类型数据：%@",str);
                    [self sendCommand:@"aa"];
                    self.receiveData = [NSString stringWithFormat:@"%@%@",[self.receiveData substringWithRange:NSMakeRange(4,104)],[self.receiveData substringWithRange:NSMakeRange(112,104)]];
                    NSString *encryptedData = [AESCrypt encrypt:self.receiveData password:AES_PASSWORD];  //加密
                    [[NSUserDefaults standardUserDefaults] setObject:encryptedData forKey:@"lanyaAESData"];  //存储
                    LOG(@"成功2");
                    self.receiveData = @"";
                } else {
                    [self sendCommand:@"00"];
                    self.receiveData = [self.receiveData substringWithRange:NSMakeRange(0,108)];
                    LOG(@"失败2");
                }
        
    } else if (self.receiveData.length == 106){
       
        if(self.shukaTimer){
             [self.shukaTimer invalidate];    // 释放函数
            self.shukaTimer = nil;
            LOG(@"关闭刷卡定时器");
        }
        self.receiveData = [[self hexadecimalString:characteristic.value] substringWithRange:NSMakeRange(0,104)];
        
        
        NSString *encryptedData = [AESCrypt encrypt:self.receiveData password:AES_PASSWORD];  //加密
        [[NSUserDefaults standardUserDefaults] setObject:encryptedData forKey:@"lanyaAESErrornData"];  //存储

        if (!_jieHhou && [self.delegate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
            [self.deleGate switchEditInitPeripheralData:3];
        }
        if ([self.deleGate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
            [self.deleGate switchEditInitPeripheralData:[self turnTheHexLiterals:[[self hexadecimalString:characteristic.value] substringWithRange:NSMakeRange(104,2)]]];
        }

       self.receiveData = @"";
    } else {
      
        if ([[self hexadecimalString:characteristic.value] isEqualToString:@"7265616401"]) {
            self.receiveData = [AESCrypt decrypt:[[NSUserDefaults standardUserDefaults] objectForKey:@"lanyaAESData"] password:AES_PASSWORD];
            self.receiveData = [NSString stringWithFormat:@"%@%@",@"AA",[self.receiveData substringWithRange:NSMakeRange(0,104)]];
            [self sendCommand:_receiveData];
        } else if ([[self hexadecimalString:characteristic.value] isEqualToString:@"7265616402"]) {
            self.receiveData = [AESCrypt decrypt:[[NSUserDefaults standardUserDefaults] objectForKey:@"lanyaAESData"] password:AES_PASSWORD];
           self.receiveData = [NSString stringWithFormat:@"%@%@",@"AA",[self.receiveData substringWithRange:NSMakeRange(104,104)]];
           [self sendCommand:_receiveData];
        } else if ([[self hexadecimalString:characteristic.value] isEqualToString:@"7265616403"]) {
            self.receiveData = [AESCrypt decrypt:[[NSUserDefaults standardUserDefaults] objectForKey:@"lanyaAESErrornData"] password:AES_PASSWORD];
            self.receiveData = [NSString stringWithFormat:@"%@%@",@"AA",self.receiveData];
            [self sendCommand:_receiveData];
        } else {
            if ( [self.deleGate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
                [self.deleGate switchEditInitPeripheralData:6];  //数据格式错误
            }
        }
       self.receiveData = @"";
    }
}

- (BOOL)lanyaDataXiaoyanAction:(NSString *)data {
    unsigned int numberKey;
    unsigned char key[4];
    unsigned char key1[4];
    unsigned char key2[100];
    NSString * TheTwoCharacters;
    int  aa;
    for (NSInteger j = 0; j < data.length / 2; j++) {
        TheTwoCharacters = [data substringWithRange:NSMakeRange(j * 2,2)];
        aa= [self turnTheHexLiterals:TheTwoCharacters];
        key2[j] = aa;
    }
    key1[0] = key2[48];
    key1[1] = key2[49];
    key1[2] = key2[50];
    key1[3] = key2[51];
    xor(key1);
    
    for(NSInteger I = 0; I < 48; I++) {
        key2[I] = key2[I]^tmpstr[I];
    }
    numberKey = crcs32(key2,48);
    key[0] = numberKey>>24;
    key[1] = numberKey>>16;
    key[2] = numberKey>>8;
    key[3] = numberKey;
    if (key[0] == key1[0] && key[1] == key1[1] && key1[2] == key1[2] && key[3] == key1[3]) {
        return YES;
    } else {
        return NO;
    }
}



//将传入的NSData类型转换成NSString并返回
- (NSString*)hexadecimalString:(NSData *)data{
    NSString* result;
    const unsigned char* dataBuffer = (const unsigned char*)[data bytes];
    if(!dataBuffer){
        return nil;
    }
    NSUInteger dataLength = [data length];
    NSMutableString* hexString = [NSMutableString stringWithCapacity:(dataLength * 2)];
    for(int i = 0; i < dataLength; i++){
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    }
    result = [NSString stringWithString:hexString];
    return result;
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
    LOG(@"==>%@",error);
    LOG(@"意外断开，执行重连api");
    


    [self connectClick:_peripheral];
    
}

#pragma mark - C  语言 的加密 算法
unsigned int crcs32( unsigned char buf[], unsigned char len)
{
    unsigned int ret = 0x13141516;
    int i;
    for(i = 0; i < len;i++)
    {
        ret = CRC32_table[((ret & 0xFF) ^ buf[i])] ^ (ret >> 8);
    }
    ret = ~ret;
    return ret;
}

unsigned int CRC32_table[256] =
{
    0x00000000, 0x77073096, 0xEE0E612C, 0x990951BA,
    0x076DC419, 0x706AF48F, 0xE963A535, 0x9E6495A3,
    0x0EDB8832, 0x79DCB8A4, 0xE0D5E91E, 0x97D2D988,
    0x09B64C2B, 0x7EB17CBD, 0xE7B82D07, 0x90BF1D91,
    0x1DB71064, 0x6AB020F2, 0xF3B97148, 0x84BE41DE,
    0x1ADAD47D, 0x6DDDE4EB, 0xF4D4B551, 0x83D385C7,
    0x136C9856, 0x646BA8C0, 0xFD62F97A, 0x8A65C9EC,
    0x14015C4F, 0x63066CD9, 0xFA0F3D63, 0x8D080DF5,
    0x3B6E20C8, 0x4C69105E, 0xD56041E4, 0xA2677172,
    0x3C03E4D1, 0x4B04D447, 0xD20D85FD, 0xA50AB56B,
    0x35B5A8FA, 0x42B2986C, 0xDBBBC9D6, 0xACBCF940,
    0x32D86CE3, 0x45DF5C75, 0xDCD60DCF, 0xABD13D59,
    0x26D930AC, 0x51DE003A, 0xC8D75180, 0xBFD06116,
    0x21B4F4B5, 0x56B3C423, 0xCFBA9599, 0xB8BDA50F,
    0x2802B89E, 0x5F058808, 0xC60CD9B2, 0xB10BE924,
    0x2F6F7C87, 0x58684C11, 0xC1611DAB, 0xB6662D3D,
    0x76DC4190, 0x01DB7106, 0x98D220BC, 0xEFD5102A,
    0x71B18589, 0x06B6B51F, 0x9FBFE4A5, 0xE8B8D433,
    0x7807C9A2, 0x0F00F934, 0x9609A88E, 0xE10E9818,
    0x7F6A0DBB, 0x086D3D2D, 0x91646C97, 0xE6635C01,
    0x6B6B51F4, 0x1C6C6162, 0x856530D8, 0xF262004E,
    0x6C0695ED, 0x1B01A57B, 0x8208F4C1, 0xF50FC457,
    0x65B0D9C6, 0x12B7E950, 0x8BBEB8EA, 0xFCB9887C,
    0x62DD1DDF, 0x15DA2D49, 0x8CD37CF3, 0xFBD44C65,
    0x4DB26158, 0x3AB551CE, 0xA3BC0074, 0xD4BB30E2,
    0x4ADFA541, 0x3DD895D7, 0xA4D1C46D, 0xD3D6F4FB,
    0x4369E96A, 0x346ED9FC, 0xAD678846, 0xDA60B8D0,
    0x44042D73, 0x33031DE5, 0xAA0A4C5F, 0xDD0D7CC9,
    0x5005713C, 0x270241AA, 0xBE0B1010, 0xC90C2086,
    0x5768B525, 0x206F85B3, 0xB966D409, 0xCE61E49F,
    0x5EDEF90E, 0x29D9C998, 0xB0D09822, 0xC7D7A8B4,
    0x59B33D17, 0x2EB40D81, 0xB7BD5C3B, 0xC0BA6CAD,
    0xEDB88320, 0x9ABFB3B6, 0x03B6E20C, 0x74B1D29A,
    0xEAD54739, 0x9DD277AF, 0x04DB2615, 0x73DC1683,
    0xE3630B12, 0x94643B84, 0x0D6D6A3E, 0x7A6A5AA8,
    0xE40ECF0B, 0x9309FF9D, 0x0A00AE27, 0x7D079EB1,
    0xF00F9344, 0x8708A3D2, 0x1E01F268, 0x6906C2FE,
    0xF762575D, 0x806567CB, 0x196C3671, 0x6E6B06E7,
    0xFED41B76, 0x89D32BE0, 0x10DA7A5A, 0x67DD4ACC,
    0xF9B9DF6F, 0x8EBEEFF9, 0x17B7BE43, 0x60B08ED5,
    0xD6D6A3E8, 0xA1D1937E, 0x38D8C2C4, 0x4FDFF252,
    0xD1BB67F1, 0xA6BC5767, 0x3FB506DD, 0x48B2364B,
    0xD80D2BDA, 0xAF0A1B4C, 0x36034AF6, 0x41047A60,
    0xDF60EFC3, 0xA867DF55, 0x316E8EEF, 0x4669BE79,
    0xCB61B38C, 0xBC66831A, 0x256FD2A0, 0x5268E236,
    0xCC0C7795, 0xBB0B4703, 0x220216B9, 0x5505262F,
    0xC5BA3BBE, 0xB2BD0B28, 0x2BB45A92, 0x5CB36A04,
    0xC2D7FFA7, 0xB5D0CF31, 0x2CD99E8B, 0x5BDEAE1D,
    0x9B64C2B0, 0xEC63F226, 0x756AA39C, 0x026D930A,
    0x9C0906A9, 0xEB0E363F, 0x72076785, 0x05005713,
    0x95BF4A82, 0xE2B87A14, 0x7BB12BAE, 0x0CB61B38,
    0x92D28E9B, 0xE5D5BE0D, 0x7CDCEFB7, 0x0BDBDF21,
    0x86D3D2D4, 0xF1D4E242, 0x68DDB3F8, 0x1FDA836E,
    0x81BE16CD, 0xF6B9265B, 0x6FB077E1, 0x18B74777,
    0x88085AE6, 0xFF0F6A70, 0x66063BCA, 0x11010B5C,
    0x8F659EFF, 0xF862AE69, 0x616BFFD3, 0x166CCF45,
    0xA00AE278, 0xD70DD2EE, 0x4E048354, 0x3903B3C2,
    0xA7672661, 0xD06016F7, 0x4969474D, 0x3E6E77DB,
    0xAED16A4A, 0xD9D65ADC, 0x40DF0B66, 0x37D83BF0,
    0xA9BCAE53, 0xDEBB9EC5, 0x47B2CF7F, 0x30B5FFE9,
    0xBDBDF21C, 0xCABAC28A, 0x53B39330, 0x24B4A3A6,
    0xBAD03605, 0xCDD70693, 0x54DE5729, 0x23D967BF,
    0xB3667A2E, 0xC4614AB8, 0x5D681B02, 0x2A6F2B94,
    0xB40BBE37, 0xC30C8EA1, 0x5A05DF1B, 0x2D02EF8D
};
char tmpstr[54];
//数据  加密 算法
void xor(unsigned char key[]) {
    int j;
    int slen= 54; //strlen(source);
    int klen= 4; //strlen(key);
    unsigned char str = 0x0;
    unsigned char numberOne[54] = {0x87,0x65,0x4a,0x8b,0xb1,0x76,0x5,0x91,
        0x3c,0x83,0x23,0xdc,0xb0,0x63,0x59,0x02,
        0x20,0xd0,0x39,0x85,0x58,0x14,0x19,0x8,
        0x47,0x65,0xca,0x8c,0xb9,0x70,0x51,0x81,
        0x39,0x33,0x22,0xcc,0xb5,0x6e,0x5a,0x66,
        0x28,0xd2,0x99,0x88,0x5c,0x10,0xa9,0xa,
        0x90,0x9e,0xd,0xcd,0x18,0x7a};
    
    for (int i = 0;i < 4; i++) {
        str = str + key[i];
    }
    
    for(j=0;j<slen;j++)
    {
        if (str % klen == 0 ){
            tmpstr[j]=(numberOne[j]^key[j%klen]) ^ str;
        }else if (str % klen == 1) {
            tmpstr[j]=(numberOne[j]^key[j%klen])^(~(str)) ;
        }else if (str % klen == 2) {
            tmpstr[j]=numberOne[j]^key[j%klen];
        } else {
            tmpstr[j]=~((numberOne[j]^key[j%klen]) ^ str);
        }
        if(!tmpstr[j])
            tmpstr[j]=numberOne[j];
    }
    
}
@end


