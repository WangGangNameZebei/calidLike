//
//  RetrieveThePasswordViewController+LogicalFlow.m
//  claidApp
//
//  Created by kevinpc on 2017/9/26.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "RetrieveThePasswordViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>

@implementation RetrieveThePasswordViewController (LogicalFlow)


#pragma mark - 检测 是否 被注册
- (void)userphoneisrequestPostDataPhoneNumber:(NSString *)phoneNumber {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    NSDictionary *parameters = @{@"accounts":phoneNumber};
    [manager POST:DETECTION_REGISTER_URL  parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 308) {
            [self obtainYanzhengmaAction];
        } else {
          [self promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
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
   // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    return manager;
}
@end
