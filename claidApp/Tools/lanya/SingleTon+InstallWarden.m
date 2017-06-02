//
//  SingleTon+InstallWarden.m
//  claidApp
//
//  Created by kevinpc on 2016/12/27.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "SingleTon+InstallWarden.h"
#import "SingleTon+tool.h"
@implementation SingleTon (InstallWarden)
- (void)hairpinUserCardData:(NSString *)characteristic {
    NSString *str = [characteristic substringWithRange:NSMakeRange(0,2)];
    [self sendCommand:@"aa"];
    self.receiveData = [NSString stringWithFormat:@"%@%@",[characteristic substringWithRange:NSMakeRange(2,104)],[characteristic substringWithRange:NSMakeRange(106,104)]];
    if ([str isEqualToString:@"02"]) {    //用户卡
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
        if (iCardData.identification == [identificationString integerValue]) {
             [self.numberArrar addObject:data[i]];
            
        }
    }

    if ([identificationString isEqualToString:@"12"]) {    //地址卡
        self.installCardData = [InstallCardData initinstallNamestr:[NSString stringWithFormat:@"地址%lu",(self.numberArrar.count + 1)] installData:dataString identification:12];
        [self.tool insertWithObj:self.installCardData];
    } else if ([identificationString isEqualToString:@"22"]){     //时间卡
        self.installCardData = [InstallCardData initinstallNamestr:[NSString stringWithFormat:@"时间%lu",(self.numberArrar.count + 1)] installData:dataString identification:22];
        [self.tool insertWithObj:self.installCardData];
    } else if ([identificationString isEqualToString:@"32"]){     //同步卡
        self.installCardData = [InstallCardData initinstallNamestr:[NSString stringWithFormat:@"同步%lu",(self.numberArrar.count + 1)] installData:dataString identification:32];
        [self.tool insertWithObj:self.installCardData];
    } else if ([identificationString isEqualToString:@"42"]){     //出厂卡
        self.installCardData = [InstallCardData initinstallNamestr:[NSString stringWithFormat:@"出厂%lu",(self.numberArrar.count + 1)] installData:dataString identification:42];
        [self.tool insertWithObj:self.installCardData];
    } else if ([identificationString isEqualToString:@"52"]){     //开放卡
        self.installCardData = [InstallCardData initinstallNamestr:[NSString stringWithFormat:@"开放%lu",(self.numberArrar.count + 1)] installData:dataString identification:52];
        [self.tool insertWithObj:self.installCardData];
    } else if ([identificationString isEqualToString:@"62"]){     //清空挂失卡
        self.installCardData = [InstallCardData initinstallNamestr:[NSString stringWithFormat:@"清空挂失卡%lu",(self.numberArrar.count + 1)] installData:dataString identification:62];
        [self.tool insertWithObj:self.installCardData];
    } else if ([identificationString isEqualToString:@"72"]){     //挂失卡
        self.installCardData = [InstallCardData initinstallNamestr:[NSString stringWithFormat:@"挂失%lu",(self.numberArrar.count + 1)] installData:dataString identification:72];
        [self.tool insertWithObj:self.installCardData];
    } else if ([identificationString isEqualToString:@"82"]){     //解挂卡
        self.installCardData = [InstallCardData initinstallNamestr:[NSString stringWithFormat:@"解挂%lu",(self.numberArrar.count + 1)] installData:dataString identification:82];
        [self.tool insertWithObj:self.installCardData];
    } else {
         LOG(@"数据头错误");
    }
    if ([self.installDelegate respondsToSelector:@selector(installDoSomethingtishiFrame:)]) {
        [self.installDelegate installDoSomethingtishiFrame:@"设置成功"];
    }
    
}


- (void)hairpinReadData:(NSString *)characteristic {
    if ([characteristic isEqualToString:@"7265616401"]) {
        self.receiveData = [AESCrypt decrypt:[[NSUserDefaults standardUserDefaults] objectForKey:@"lanyaAESData"] password:AES_PASSWORD];
        self.receiveData = [NSString stringWithFormat:@"%@%@",@"AA",[self.receiveData substringWithRange:NSMakeRange(0,104)]];
        [self sendCommand:self.receiveData];
    } else if ([characteristic isEqualToString:@"7265616402"]) {
        self.receiveData = [AESCrypt decrypt:[[NSUserDefaults standardUserDefaults] objectForKey:@"lanyaAESData"] password:AES_PASSWORD];
        self.receiveData = [NSString stringWithFormat:@"%@%@",@"AA",[self.receiveData substringWithRange:NSMakeRange(104,104)]];
        [self sendCommand:self.receiveData];
    } else if ([characteristic isEqualToString:@"7265616403"]) {
        self.receiveData = [AESCrypt decrypt:[[NSUserDefaults standardUserDefaults] objectForKey:@"lanyaAESErrornData"] password:AES_PASSWORD];
        self.receiveData = [NSString stringWithFormat:@"%@%@",@"AA",self.receiveData];
        [self sendCommand:self.receiveData];
    } else {
        if ( [self.deleGate respondsToSelector:@selector(switchEditInitPeripheralData:)]){
            [self.deleGate switchEditInitPeripheralData:7];  //数据格式错误
        }
    }

}
- (NSInteger)judgmentCardActiondataStr:(NSString *)datastr{
    NSInteger dataint = [self turnTheHexLiterals:datastr];
    switch (dataint) {
        case 0x02:
        case 0x12:
        case 0x22:
        case 0x32:
        case 0x42:
        case 0x52:
        case 0x62:
        case 0x72:
        case 0x82:
            dataint = 1;
            break;
        default:
            dataint = 0;
            break;
    }
    return dataint;
}
@end
