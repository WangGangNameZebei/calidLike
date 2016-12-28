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
    [self sendCommand:@"aa"];
    self.receiveData = [NSString stringWithFormat:@"%@%@",[self.receiveData substringWithRange:NSMakeRange(4,104)],[self.receiveData substringWithRange:NSMakeRange(112,104)]];
    NSString *encryptedData = [AESCrypt encrypt:self.receiveData password:AES_PASSWORD];  //加密
    [[NSUserDefaults standardUserDefaults] setObject:encryptedData forKey:@"lanyaAESData"];  //存储
    LOG(@"成功2");
    
}

- (void)hairpinInstallData:(CBCharacteristic *)characteristic {
    
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
