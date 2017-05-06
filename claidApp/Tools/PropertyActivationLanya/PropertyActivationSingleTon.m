//
//  PropertyActivationSingleTon.m
//  claidApp
//
//  Created by kevinpc on 2017/4/28.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "PropertyActivationSingleTon.h"
#import "SingleTon+tool.h"


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
    self.singleton = [SingleTon sharedInstance];
    self.pAPeripheralArray = [NSMutableArray array];
    self.pAdelayInSeconds = 3.0;
}


#pragma mark - 处理传进来的字符串并发指令
- (void)sendCommand:(NSString *)String {
    
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
    NSInteger aa;
    Byte byte[110] = {};
    for (int j = 0; j < strlenght; j++) {
        TheTwoCharacters =[String substringWithRange:NSMakeRange((2*j),2)];
        aa = [self.singleton turnTheHexLiterals:TheTwoCharacters];
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
    if ([self.delegate respondsToSelector:@selector(pADoSomethingEveryFrame:)])
        [self.delegate pADoSomethingEveryFrame:self.pAPeripheralArray];
}

#pragma mark - 连接外设
-(void)connectClick:(CBPeripheral *)peripheral
{
    if (!peripheral) {
        
        LOG(@"主动断开蓝牙");
        return;
    }
    
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
        if ([c.UUID isEqual:[CBUUID UUIDWithString:@"0xFFF6"]]) {
            _pAwriteCharacteristic = c;
            if ([self.delegate respondsToSelector:@selector(pADoSomethingtishiFrame:)])
                [self.delegate pADoSomethingtishiFrame:@"连接成功"];
        }
        if ([c.UUID isEqual:[CBUUID UUIDWithString:@"0xFFF7"]]) {
            
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
    
    if (self.receiveData.length == 0)
        self.receiveData = @"";
    NSLog(@"===== %@",[self.singleton hexadecimalString:characteristic.value]);
    NSString *str1 = [self.singleton hexadecimalString:characteristic.value];
    self.receiveData = [NSString stringWithFormat:@"%@%@",self.receiveData,str1];
    if  (self.receiveData.length > 106  && self.receiveData.length <= 214 && [[str1 substringWithRange:NSMakeRange(0, 4)] isEqualToString:@"aa02"]){
        if ([self.singleton lanyaDataXiaoyanAction:[self.receiveData substringWithRange:NSMakeRange(4,104)]]) {
            [self sendCommand:@"aa"];
            LOG(@"成功1");
        } else {
            [self sendCommand:@"00"];
            LOG(@"失败1");
            self.receiveData = @"";
        }
    } else if (self.receiveData.length > 214 && [[str1 substringWithRange:NSMakeRange(0, 4)] isEqualToString:@"aa02"]) {
        if ([self.singleton lanyaDataXiaoyanAction:[self.receiveData substringWithRange:NSMakeRange(112,104)]]){
          
            [self sendCommand:@"aa"];
            self.receiveData = [NSString stringWithFormat:@"%@%@",[self.receiveData substringWithRange:NSMakeRange(4,104)],[self.receiveData substringWithRange:NSMakeRange(112,104)]];
            if ([[str1 substringWithRange:NSMakeRange(0, 4)] isEqualToString:@"aa02"]) {    //用户卡
               NSString *encryptedData = [AESCrypt encrypt:self.receiveData password:AES_PASSWORD];  //加密
               [[NSUserDefaults standardUserDefaults] setObject:encryptedData forKey:@"lanyaAESData"];  //存储
            }
            self.receiveData = @"";
        } else {
            [self sendCommand:@"00"];
            self.receiveData = [self.receiveData substringWithRange:NSMakeRange(0,108)];
            LOG(@"失败2");
        }
        
    } else {
        if ([[str1 substringWithRange:NSMakeRange(0, 4)] isEqualToString:@"aab2"] && self.receiveData.length > 214) {
            NSString *userInfoOne = [self.singleton lanyaDataDecryptedAction:[self.receiveData substringWithRange:NSMakeRange(4,104)]];
             NSString *userInfoTow = [self.singleton lanyaDataDecryptedAction:[self.receiveData substringWithRange:NSMakeRange(112,104)]];
            NSLog(@"++++>%@ ===%@",userInfoOne,userInfoTow);
            self.pAtool = [DBTool sharedDBTool];
            NSArray *data = [self.pAtool selectWithClass:[ClassUserInfo class] params:nil];
            NSString *namestr = [self.singleton changeLanguage:[userInfoOne substringWithRange:NSMakeRange(14,16)]];
            NSString *notestr = [self.singleton changeLanguage:[userInfoOne substringWithRange:NSMakeRange(58,32)]];
            self.classUserInfo = [ClassUserInfo classUserinfouniqueCodeStr:[userInfoOne substringWithRange:NSMakeRange(0,8)] userNameStr:namestr validityStr:[userInfoOne substringWithRange:NSMakeRange(8,6)] addressStr:[userInfoOne substringWithRange:NSMakeRange(30,16)] telePhoneStr:[userInfoOne substringWithRange:NSMakeRange(46,11)] noteStr:notestr eqIdStr:userInfoTow];
            if (data.count == 0){
                [self.pAtool createTableWithClass:[ClassUserInfo class]];
                [self.pAtool insertWithObj:self.classUserInfo];
            } else {
                [self.pAtool updateWithObj:self.classUserInfo andKey:@"uniqueCodeStr" isEqualValue:[userInfoOne substringWithRange:NSMakeRange(0,8)]];
            }
            if ([self.delegate respondsToSelector:@selector(pADoSomethingtishiFrame:)])
                [self.delegate pADoSomethingtishiFrame:self.receiveData];
          self.receiveData = @"";
        }
        [self sendCommand:@"aa"];
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
    [self connectClick:_pAperipheral];
    
}


@end
