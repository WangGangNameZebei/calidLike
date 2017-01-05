//
//  SingleTon+InstallWarden.m
//  claidApp
//
//  Created by kevinpc on 2016/12/27.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "SingleTon+InstallWarden.h"

@implementation SingleTon (InstallWarden)
- (void)hairpinUserCardData:(CBCharacteristic *)characteristic {
    NSString *str = [NSString stringWithFormat:@"收到数据：%@",characteristic.value];
    LOG(@"收到的String 类型数据：%@",str);
    str = [self.receiveData substringWithRange:NSMakeRange(0,4)];
    [self sendCommand:@"aa"];
    self.receiveData = [NSString stringWithFormat:@"%@%@",[self.receiveData substringWithRange:NSMakeRange(4,104)],[self.receiveData substringWithRange:NSMakeRange(112,104)]];
    if ([str isEqualToString:@"aa02"]) {    //用户卡
        NSString *encryptedData = [AESCrypt encrypt:self.receiveData password:AES_PASSWORD];  //加密
        [[NSUserDefaults standardUserDefaults] setObject:encryptedData forKey:@"lanyaAESData"];  //存储
    } else {
         [self cradClassificationData:self.receiveData identificationString:str];
    }
    LOG(@"成功2");
    
}

- (void)cradClassificationData:(NSString *)dataString identificationString:(NSString *)identificationString {
    self.tool = [DBTool sharedDBTool];
    self.numberArrar = [NSMutableArray array];
    NSArray *data = [self.tool selectWithClass:[InstallCardData class] params:nil];
    if (data.count == 0){               
         [self.tool createTableWithClass:[InstallCardData class]];
    }
    for (int i=0;i<data.count;i++)
    {
        InstallCardData *iCardData = data[i];
        if (iCardData.identification == [[identificationString substringWithRange:NSMakeRange(2,2)] integerValue]) {
             [self.numberArrar addObject:data[i]];
            
        }
    }

    if ([identificationString isEqualToString:@"aa12"]) {    //地址卡
        self.installCardData = [InstallCardData initinstallNamestr:[NSString stringWithFormat:@"地址%ld",(self.numberArrar.count + 1)] installData:dataString identification:12];
        [self.tool insertWithObj:self.installCardData];
    } else if ([identificationString isEqualToString:@"aa22"]){     //时间卡
        self.installCardData = [InstallCardData initinstallNamestr:[NSString stringWithFormat:@"时间%ld",(self.numberArrar.count + 1)] installData:dataString identification:22];
        [self.tool insertWithObj:self.installCardData];
    } else if ([identificationString isEqualToString:@"aa32"]){     //同步卡
        self.installCardData = [InstallCardData initinstallNamestr:[NSString stringWithFormat:@"同步%ld",(self.numberArrar.count + 1)] installData:dataString identification:32];
        [self.tool insertWithObj:self.installCardData];
    } else if ([identificationString isEqualToString:@"aa42"]){     //出厂卡
        self.installCardData = [InstallCardData initinstallNamestr:[NSString stringWithFormat:@"出厂%ld",(self.numberArrar.count + 1)] installData:dataString identification:42];
        [self.tool insertWithObj:self.installCardData];
    } else if ([identificationString isEqualToString:@"aa52"]){     //开放卡
        self.installCardData = [InstallCardData initinstallNamestr:[NSString stringWithFormat:@"开放%ld",(self.numberArrar.count + 1)] installData:dataString identification:52];
        [self.tool insertWithObj:self.installCardData];
    } else if ([identificationString isEqualToString:@"aa62"]){     //清空挂失卡
        self.installCardData = [InstallCardData initinstallNamestr:[NSString stringWithFormat:@"清空挂失卡%ld",(self.numberArrar.count + 1)] installData:dataString identification:62];
        [self.tool insertWithObj:self.installCardData];
    } else if ([identificationString isEqualToString:@"aa72"]){     //挂失卡
        self.installCardData = [InstallCardData initinstallNamestr:[NSString stringWithFormat:@"挂失%ld",(self.numberArrar.count + 1)] installData:dataString identification:72];
        [self.tool insertWithObj:self.installCardData];
    } else if ([identificationString isEqualToString:@"aa82"]){     //解挂卡
        self.installCardData = [InstallCardData initinstallNamestr:[NSString stringWithFormat:@"解挂%ld",(self.numberArrar.count + 1)] installData:dataString identification:82];
        [self.tool insertWithObj:self.installCardData];
    } else {
         LOG(@"数据头错误");
    }
    if ([self.installDelegate respondsToSelector:@selector(installDoSomethingtishiFrame:)]) {
        [self.installDelegate installDoSomethingtishiFrame:@"设置成功"];
    }
    
}


- (void)hairpinReadData:(CBCharacteristic *)characteristic {
    if ([[self hexadecimalString:characteristic.value] isEqualToString:@"7265616401"]) {
        self.receiveData = [AESCrypt decrypt:[[NSUserDefaults standardUserDefaults] objectForKey:@"lanyaAESData"] password:AES_PASSWORD];
        self.receiveData = [NSString stringWithFormat:@"%@%@",@"AA",[self.receiveData substringWithRange:NSMakeRange(0,104)]];
        [self sendCommand:self.receiveData];
    } else if ([[self hexadecimalString:characteristic.value] isEqualToString:@"7265616402"]) {
        self.receiveData = [AESCrypt decrypt:[[NSUserDefaults standardUserDefaults] objectForKey:@"lanyaAESData"] password:AES_PASSWORD];
        self.receiveData = [NSString stringWithFormat:@"%@%@",@"AA",[self.receiveData substringWithRange:NSMakeRange(104,104)]];
        [self sendCommand:self.receiveData];
    } else if ([[self hexadecimalString:characteristic.value] isEqualToString:@"7265616403"]) {
        self.receiveData = [AESCrypt decrypt:[[NSUserDefaults standardUserDefaults] objectForKey:@"lanyaAESErrornData"] password:AES_PASSWORD];
        self.receiveData = [NSString stringWithFormat:@"%@%@",@"AA",self.receiveData];
        [self sendCommand:self.receiveData];
    } else {
        if ( [self.deleGate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
            [self.deleGate switchEditInitPeripheralData:6];  //数据格式错误
        }
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
@end
