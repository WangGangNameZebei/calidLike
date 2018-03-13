//
//  installViewController+LogicalFlow.m
//  claidApp
//
//  Created by kevinpc on 2016/11/2.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "installViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>
#import "CalidTool.h"

@implementation installViewController (LogicalFlow)
#pragma mark- 效验发卡器
- (void)checkStatusOfCardPOSTdataStr:(NSString *)dataStr {
    NSString *xyId =  [CalidTool lanyaDataDecryptedAction:dataStr];
    xyId = [xyId substringWithRange:NSMakeRange(2, 8)];
    if (![xyId isEqualToString:[self userInfoReaduserkey:@"districtNumber"]]){
        [self alertViewmessage:@"当前小区与设备不匹配,请选择正确小区"];
        if (![self.installLanyaLabel.text isEqualToString:@"已连接"]){
            NSString *message = @"d0446973636f6e6e656374696e67000000000000";
            [self.sinTon iwsendCommand:message];       //发送数据
        }
        [self.sinTon iwdisConnection];  //断开蓝牙
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    NSDictionary *parameters = @{@"cardData":dataStr};
    [manager POST:CHECK_STATUS_CARD_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 200){  //
             NSArray *arrar = [resultDic objectForKey:@"data"];
            [self lanyaCardChuliActiondataStr:arrar[0] olddata:dataStr];
            
        } else {
            [self lanyaCardChuliActiondataStr:@"00" olddata:dataStr];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
       [self.sinTon iwdisConnection];       // 退出前 断开蓝牙
        if (error.code == -1009){
            [self promptInformationActionWarningString:@"您的网络有异常"];
            
        } else {
            [self promptInformationActionWarningString:[NSString stringWithFormat:@"%ld",(long)error.code]];
        }
        
    }];
    
    
}
- (AFHTTPRequestOperationManager *)tokenManager {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 设置请求格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    return manager;
}
- (void)lanyaCardChuliActiondataStr:(NSString *)datastr olddata:(NSString *)loddata {
    NSString *receiveData =  [CalidTool lanyaDataDecryptedAction:loddata];
    NSString *message = [CalidTool crc32producedataStr:[NSString stringWithFormat:@"01%@%@",[receiveData substringWithRange:NSMakeRange(48,8)],datastr]];
    message = [NSString stringWithFormat:@"dd01%@%@",message,datastr];
    [self.sinTon iwsendCommand:message];       //发送数据
    if ([datastr isEqualToString:@"55"]){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 0.4s后自动执行这个block里面的代码
            [self.sinTon iwdisConnection];
        });
    }
}

@end
