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
- (void)mainHairpinReturnData:(NSString *)characteristic{
    self.receiveData = [characteristic substringWithRange:NSMakeRange(0,104)];
    NSString *encryptedData = [AESCrypt encrypt:self.receiveData password:AES_PASSWORD];  //加密
    [[NSUserDefaults standardUserDefaults] setObject:encryptedData forKey:@"lanyaAESErrornData"];  //存储
    
    if (!self.jieHhou && [self.deleGate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
        [self.deleGate switchEditInitPeripheralData:3];
    }
    if ([self.deleGate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
        [self.deleGate switchEditInitPeripheralData:[self turnTheHexLiterals:[characteristic substringWithRange:NSMakeRange(104,2)]]];
    }
    
}

@end
