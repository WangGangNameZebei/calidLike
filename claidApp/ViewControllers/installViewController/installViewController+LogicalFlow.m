//
//  installViewController+LogicalFlow.m
//  claidApp
//
//  Created by kevinpc on 2016/11/2.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "installViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>
#import "SingleTon+tool.h"

@implementation installViewController (LogicalFlow)
#pragma mark- 效验发卡器
- (void)checkStatusOfCardPOSTdataStr:(NSString *)dataStr {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    NSDictionary *parameters = @{@"cardData":dataStr};
    [manager POST:CHECK_STATUS_CARD_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 200){  //
            
            [self lanyaCardChuliActiondataStr:[resultDic objectForKey:@"data"] olddata:dataStr];
            
        } else {
            [self lanyaCardChuliActiondataStr:@"00" olddata:dataStr];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [self.sinTon disConnection];       // 退出前 断开蓝牙
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
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    return manager;
}
- (void)lanyaCardChuliActiondataStr:(NSString *)datastr olddata:(NSString *)loddata {
    NSString *receiveData =  [[SingleTon alloc] lanyaDataDecryptedAction:loddata];
    NSString *message = [SingleTon crc32producedataStr:[NSString stringWithFormat:@"01%@%@",[receiveData substringWithRange:NSMakeRange(48,8)],datastr]];
    message = [NSString stringWithFormat:@"dd01%@%@",message,datastr];
    [self.sinTon sendCommand:message];       //发送数据
}

@end
