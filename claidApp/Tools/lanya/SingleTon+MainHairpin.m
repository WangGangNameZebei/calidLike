//
//  SingleTon+MainHairpin.m
//  claidApp
//
//  Created by kevinpc on 2017/1/6.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "SingleTon+MainHairpin.h"
#import "SingleTon+tool.h"

@implementation SingleTon (MainHairpin)
- (void)mainHairpinReturnData:(CBCharacteristic *)characteristic{
    self.receiveData = [[self hexadecimalString:characteristic.value] substringWithRange:NSMakeRange(0,104)];
    NSString *encryptedData = [AESCrypt encrypt:self.receiveData password:AES_PASSWORD];  //加密
    [[NSUserDefaults standardUserDefaults] setObject:encryptedData forKey:@"lanyaAESErrornData"];  //存储
    
    if (!self.jieHhou && [self.deleGate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
        [self.deleGate switchEditInitPeripheralData:3];
    }
    if ([self.deleGate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
        [self.deleGate switchEditInitPeripheralData:[self turnTheHexLiterals:[[self hexadecimalString:characteristic.value] substringWithRange:NSMakeRange(104,2)]]];
    }
    
}

@end
