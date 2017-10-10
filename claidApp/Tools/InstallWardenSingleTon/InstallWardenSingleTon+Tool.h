//
//  InstallWardensingleTon+Tool.h
//  claidApp
//
//  Created by kevinpc on 2017/9/19.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "InstallWardensingleTon.h"

@interface InstallWardensingleTon (Tool)

- (void)hairpinUserCardData:(NSString *)characteristic;         //设置  发卡
- (void)hairpinReadData:(NSString *)characteristic;             //  软件读取卡信息
- (NSInteger)judgmentCardActiondataStr:(NSString *)datastr;     //判断 是发卡   还是    刷卡数据  返回
- (void)iwmainHairpinReturnData:(NSString *)characteristic;
- (void)lanyaSendoutDataAction:(NSString *)data;
@end
