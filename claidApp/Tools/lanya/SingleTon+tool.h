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
- (NSInteger)turnTheHexLiterals:(NSString *)string;
- (BOOL)lanyaDataXiaoyanAction:(NSString *)data;            //效验数据
- (void)lanyaSendoutDataAction:(NSString *)data;            //发送数据加密
- (NSString *)payByCardInstructionsActionString:(NSString *)string;             //发送数据指令
@end
