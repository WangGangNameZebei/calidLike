//
//  VisitorSingleTon+Tool.h
//  claidApp
//
//  Created by kevinpc on 2017/1/18.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "VisitorSingleTon.h"

@interface VisitorSingleTon (Tool)
- (NSString*)visitorhexadecimalString:(NSData *)data;   //将传入的NSData类型转换成NSString并返回
- (NSInteger)visitorturnTheHexLiterals:(NSString *)string;
- (void)visitorlanyaSendoutDataAction:(NSString *)data;            //发送数据加密
- (NSString *)visitorpayByCardInstructionsActionString:(NSString *)string;

@end
