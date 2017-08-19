//
//  SingleTon+tool.h
//  claidApp
//
//  Created by kevinpc on 2017/1/6.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "SingleTon.h"

@interface SingleTon (tool)
- (NSString*)hexadecimalString:(NSData *)data;   //将传入的NSData类型转换成NSString并返回
- (NSInteger)turnTheHexLiterals:(NSString *)string;     // 指令字符  值转16进制数
- (BOOL)lanyaDataXiaoyanAction:(NSString *)data;            //效验数据
- (void)lanyaSendoutDataAction:(NSString *)data;            //发送数据加密
- (NSString *)payByCardInstructionsActionString:(NSString *)string;             //发送数据指令
- (NSString *)jiamiaTostringAcction:(NSString *)string numberKey:(NSInteger)number ;
- (NSString *)lanyaDataDecryptedAction:(NSString *)data;                // 数据解密
- (NSString *)changeLanguage:(NSString *)chinese;         //16 进制的数转换字符串
- (NSString *)chineseToHex:(NSString *)chineseStr;       //将汉字字符串转换成16进制字符串
+ (NSString *)crc32producedataStr:(NSString *)dataStr;      //产生CRC
@end
