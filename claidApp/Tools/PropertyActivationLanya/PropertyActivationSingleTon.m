//
//  PropertyActivationSingleTon.m
//  claidApp
//
//  Created by kevinpc on 2017/4/28.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "PropertyActivationSingleTon.h"
#import "CalidTool.h"
@implementation PropertyActivationSingleTon
static PropertyActivationSingleTon *_instace = nil;



+(id)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}

+(PropertyActivationSingleTon *)sharedInstance {
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
    _pAmanager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    self.pAPeripheralArray = [NSMutableArray array];
    self.pAdelayInSeconds = 3.0;
    self.baseViewController = [[BaseViewController alloc] init];
    
}


#pragma mark - 处理传进来的字符串并发指令
- (void)sendCommand:(NSString *)String {
    NSString *strHead;
    NSData *writeData;
    NSInteger datalength;
    NSInteger jiequlength = 38;

    int length = (unsigned)String.length;
    
    int ZeroNum = 210 - length;  // 38
    
    NSString *CommandStr = String;
    
    for (int i = 0; i < ZeroNum; i ++) {
        
        CommandStr = [NSString stringWithFormat:@"%@%@",CommandStr,@"0"];
    }
    if (length > 20){
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
        aa = [CalidTool turnTheHexLiterals:TheTwoCharacters];
        byte[j] = aa;
    }
    NSData *data = [[NSData alloc] initWithBytes:byte length:strlenght];
    return data;
}


#pragma mark - 根据传进来的uuid去连接外设
- (void)getPeripheralWithIdentifierAndConnect:(NSString *)identifierStr {
    [self stopScan];
    NSUUID * uuid = [[NSUUID alloc]initWithUUIDString:identifierStr];
    NSArray *array = [self.pAmanager retrievePeripheralsWithIdentifiers:@[uuid]];
    CBPeripheral *peripheral = [array lastObject];
    [self connectClick:peripheral];
}

#pragma mark  连接蓝牙名字获取
- (CBPeripheral *)lanyaNameString:(NSString *)uuidString {
    NSUUID * uuid = [[NSUUID alloc]initWithUUIDString:uuidString];
    NSArray *array = [self.pAmanager retrievePeripheralsWithIdentifiers:@[uuid]];
    CBPeripheral *peripheral = [array lastObject];
    return peripheral;
}



#pragma mark - 扫描
-(void)startScan
{
    LOG(@"正在扫描外设...");
    [_pAmanager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
    
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.pAdelayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.pAmanager stopScan];
        LOG(@"扫描超时,停止扫描");
        LOG(@"所有扫描到的外设：%@",self.pAPeripheralArray);
        
    });
}
#pragma mark - 目标扫描
- (void)targetScan
{
    [self.pAmanager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:@"0xFFF0"]] options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES}];
    
}


#pragma mark - 停止扫描
- (void)stopScan {
    [self.pAmanager stopScan];
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
    if(![self.pAPeripheralArray containsObject:peripheral])
        [self.pAPeripheralArray addObject:peripheral];
    
    
    NSString *strUUid = FAKAQI_TON_UUID_STR;
    if (strUUid.length < 2 && [NSString stringWithFormat:@"%@",peripheral.name].length == 5) {
        if ([[NSString stringWithFormat:@"%@",peripheral.name]  isEqualToString:@"CALID"]) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",peripheral.identifier] forKey:@"fakaqiIdentifierStr"];  //存储
            
            if ([self.delegate respondsToSelector:@selector(pADoSomethingEveryFrame:)])
                [self.delegate pADoSomethingEveryFrame:1];
            
        }
    }
    
    
   
}

#pragma mark - 连接外设
-(void)connectClick:(CBPeripheral *)peripheral
{
    
    [self.pAmanager connectPeripheral:peripheral options:@{CBConnectPeripheralOptionNotifyOnConnectionKey: @YES, CBConnectPeripheralOptionNotifyOnDisconnectionKey: @YES, CBConnectPeripheralOptionNotifyOnNotificationKey: @YES,CBCentralManagerScanOptionAllowDuplicatesKey: @YES}];
    
    _pAperipheral = peripheral;
    
}
#pragma mark - 发指令
-(void)writeChar:(NSData *)data
{
    if (!_pAwriteCharacteristic) {
        LOG(@"写特征为空");
        return;
    }
    if (!data) {
        LOG(@"指令为空");
        return;
    }
    LOG(@"外设...==%@",_pAperipheral);
    
    [_pAperipheral writeValue:data forCharacteristic:_pAwriteCharacteristic type:CBCharacteristicWriteWithoutResponse];
    
}

#pragma mark - 主动断开设备
-(void)disConnection
{
    
    if (_pAperipheral != nil)
    {
            LOG(@"主动断开设备");
            [self.pAmanager cancelPeripheralConnection:_pAperipheral];
            _pAperipheral = nil;
    }
    
}

#pragma mark - 连接外设成功，开始发现服务
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    
    LOG(@"成功连接 peripheral: %@ ",peripheral);
    self.pAperipheral = peripheral;
    //[peripheral readRSSI];
    [self.pAperipheral setDelegate:self];
    [self.pAperipheral discoverServices:nil];
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
    NSString *length = [NSString stringWithFormat:@"发现BLT4.0热点:%@,距离:%.1fm",_pAperipheral,pow(10,ci)];
    LOG(@"距离：%@",length);
    
}


#pragma mark - 已发现服务
-(void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    LOG(@"发现服务");
    for (CBService *s in peripheral.services) {
        [self.pAnServices addObject:s];
        NSString *strone = [NSString stringWithFormat:@"%@",s.UUID];
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
            _pAwriteCharacteristic = c;
            if ([self.delegate respondsToSelector:@selector(pADoSomethingtishiFrame:)])
                [self.delegate pADoSomethingtishiFrame:@"连接成功"];
        }
        if ([str1 isEqualToString:@"FFF7"]) {
            
            [self.pAperipheral setNotifyValue:YES forCharacteristic:c];
            
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
        self.receiveData = @"";
    NSLog(@"===== %@",[CalidTool hexadecimalString:characteristic.value]);

    NSString *str1 = [CalidTool hexadecimalString:characteristic.value];
        if ([[str1 substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"f2"]) {   // 第一串
              jishunumber = 30;
        } else if ([[str1 substringWithRange:NSMakeRange(0, 8)] isEqualToString:@"72656164"]) {   // 软件读取信息
            jishunumber = 10;
            str1 = [NSString stringWithFormat:@"aa%@",str1];
        } 
    
        self.receiveData = [NSString stringWithFormat:@"%@%@",self.receiveData,[str1 substringWithRange:NSMakeRange(2, jishunumber)]];
        if (jishunumber == 38)
            return;

    if  (self.receiveData.length > 104  && self.receiveData.length < 210 && ([[self.receiveData substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"02"] || [[self.receiveData substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"42"])){
        if ([CalidTool lanyaDataXiaoyanAction:[self.receiveData substringWithRange:NSMakeRange(2,104)]]) {
            [self sendCommand:@"aa"];
            LOG(@"成功1");
        } else {
            [self sendCommand:@"00"];
            LOG(@"失败1");
            self.receiveData = @"";
        }
    } else if (self.receiveData.length > 104  && self.receiveData.length < 210 && [[self.receiveData substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"bb"]){             // 发卡器连接接收数据
        if ([self.delegate respondsToSelector:@selector(pADoSomethingtishiFrame:)]){
            [self.delegate pADoSomethingtishiFrame:[self.receiveData substringWithRange:NSMakeRange(0, 106)]];
        }
        self.receiveData = @"";
        
    } else if (self.receiveData.length > 210 && [[self.receiveData substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"02"]) {   // 用户卡
        if ([CalidTool lanyaDataXiaoyanAction:[self.receiveData substringWithRange:NSMakeRange(108,104)]]){
          
            [self sendCommand:@"aa"];
            self.receiveData = [NSString stringWithFormat:@"%@%@",[self.receiveData substringWithRange:NSMakeRange(2,104)],[self.receiveData substringWithRange:NSMakeRange(108,104)]];
               NSString *encryptedData = [AESCrypt encrypt:self.receiveData password:AES_PASSWORD];  //加密
             [[NSUserDefaults standardUserDefaults] setObject:encryptedData forKey:@"wuyeFKAESData"];  //物业发卡数据
        
            self.receiveData = @"";
        } else {
            [self sendCommand:@"00"];
            self.receiveData = [self.receiveData substringWithRange:NSMakeRange(0,108)];
            LOG(@"失败2");
        }
        
    }  else if (self.receiveData.length > 210 && [[self.receiveData substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"42"]) {  //  出厂卡  头两个
        if ([CalidTool lanyaDataXiaoyanAction:[self.receiveData substringWithRange:NSMakeRange(108,104)]]){
            self.receiveData = @"";
            [self sendCommand:@"aa"];
            if ([self.delegate respondsToSelector:@selector(pADoSomethingEveryFrame:)])
                [self.delegate pADoSomethingEveryFrame:2];

        } else {
            [self sendCommand:@"00"];
            self.receiveData = [self.receiveData substringWithRange:NSMakeRange(0,108)];
            LOG(@"失败2");
        }

        
    }else if ([[self.receiveData substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"b2"] ||  [[self.receiveData substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"a2"]) {   // 发卡 后俩个
        if (self.receiveData.length > 210 ) {
          
            NSString *userInfoOne = [CalidTool lanyaDataDecryptedAction:[self.receiveData substringWithRange:NSMakeRange(2,104)]];
            if ([CalidTool lanyaDataXiaoyanAction:[self.receiveData substringWithRange:NSMakeRange(2,104)]] && [CalidTool lanyaDataXiaoyanAction:[self.receiveData substringWithRange:NSMakeRange(108,104)]]) {
                if ([self.delegate respondsToSelector:@selector(pADoSomethingtishiFrame:)])
                    [self.delegate pADoSomethingtishiFrame:[NSString stringWithFormat:@"%@%@%@",[self.receiveData substringWithRange:NSMakeRange(2,104)],[self.receiveData substringWithRange:NSMakeRange(108,104)],[userInfoOne substringWithRange:NSMakeRange(46,11)]]];
            }
            
           
            self.receiveData = @"";
        }
        [self sendCommand:@"aa"];
    } else {
        [self pahairpinReadData:self.receiveData];                  //读取
        self.receiveData = @"";
    }
 
}

#pragma mark - 用于检测中心向外设写数据是否成功
-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        LOG(@"ereor:====>%@",error.userInfo);
    }else{
        LOG(@"发送数据成功==%@",characteristic.value);
    }
}

#pragma mark - 连接意外断开
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    LOG(@"==>%@",error);
    LOG(@"意外断开，执行重连api");
    
    if ([self.delegate respondsToSelector:@selector(pADoSomethingtishiFrame:)]){
        [self.delegate pADoSomethingtishiFrame:@"断开连接"];
    }
    
}


- (void)pahairpinReadData:(NSString *)characteristic {
    if ([characteristic isEqualToString:@"7265616401"]) {
        self.receiveData = [AESCrypt decrypt:[self.baseViewController userInfoReaduserkey:@"lanyaAESData"] password:AES_PASSWORD];
        self.receiveData = [NSString stringWithFormat:@"%@%@",@"AA",[self.receiveData substringWithRange:NSMakeRange(0,104)]];
        [self sendCommand:self.receiveData];
    } else if ([characteristic isEqualToString:@"7265616402"]) {
        self.receiveData = [AESCrypt decrypt:[self.baseViewController userInfoReaduserkey:@"lanyaAESData"] password:AES_PASSWORD];
        self.receiveData = [NSString stringWithFormat:@"%@%@",@"AA",[self.receiveData substringWithRange:NSMakeRange(104,104)]];
        [self sendCommand:self.receiveData];
    } else if ([characteristic isEqualToString:@"7265616403"]) {
        self.receiveData = [AESCrypt decrypt:[self.baseViewController userInfoReaduserkey:@"lanyaAESErrornData"] password:AES_PASSWORD];
        self.receiveData = [NSString stringWithFormat:@"%@%@",@"AA",self.receiveData];
        [self sendCommand:self.receiveData];
    } else {
        [self disConnection];
       LOG(@"----接收到不明格式数据。。。")
    }
    
}

@end
