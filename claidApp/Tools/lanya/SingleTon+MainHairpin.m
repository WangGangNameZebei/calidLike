//
//  SingleTon+MainHairpin.m
//  claidApp
//
//  Created by kevinpc on 2017/1/6.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "SingleTon+MainHairpin.h"
#import "CalidTool.h"

@implementation SingleTon (MainHairpin)
- (void)mainHairpinReturnData:(NSString *)characteristic{
    if (!self.jieHhou && [self.deleGate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
        [self.deleGate switchEditInitPeripheralData:3];
        
    }
    if ([[characteristic substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"ea"]) {
        if ([self.deleGate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
            [self.deleGate switchEditInitPeripheralData:[CalidTool turnTheHexLiterals:[characteristic substringWithRange:NSMakeRange(24,2)]]];
        }
    }  else {
        self.receiveData = [characteristic substringWithRange:NSMakeRange(0,104)];
        NSString *encryptedData = [AESCrypt encrypt:self.receiveData password:AES_PASSWORD];  //加密
        [self.baseViewController userInfowriteuserkey:@"lanyaAESErrornData" uservalue:encryptedData];
        if ([self.deleGate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
            [self.deleGate switchEditInitPeripheralData:[CalidTool turnTheHexLiterals:[characteristic substringWithRange:NSMakeRange(104,2)]]];
            
        }
    }

}

@end
