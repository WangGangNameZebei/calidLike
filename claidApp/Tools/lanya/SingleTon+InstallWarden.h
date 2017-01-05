//
//  SingleTon+InstallWarden.h
//  claidApp
//
//  Created by kevinpc on 2016/12/27.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "SingleTon.h"

@interface SingleTon (InstallWarden)
- (void)hairpinUserCardData:(CBCharacteristic *)characteristic;         //用户卡  发卡
- (void)hairpinReadData:(CBCharacteristic *)characteristic;


- (NSString*)hexadecimalString:(NSData *)data;   //将传入的NSData类型转换成NSString并返回
@end
