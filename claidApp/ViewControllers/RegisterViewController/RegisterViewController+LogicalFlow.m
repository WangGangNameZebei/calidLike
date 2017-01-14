//
//  RegisterViewController+LogicalFlow.m
//  claidApp
//
//  Created by kevinpc on 2016/11/1.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "RegisterViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>


@implementation RegisterViewController (LogicalFlow)
- (void)registerPostForUsername:(NSString *)username password:(NSString *)password oraKey:(NSString *)orakey {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    NSDictionary *parameters = @{@"accounts":username,@"passwd":password,@"oraKey":orakey};
    [manager POST:REGISTER_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ( [[resultDic objectForKey:@"status"] integerValue] == 200) {
            [self promptInformationActionWarningString:@"注册成功"];
        } else if ( [[resultDic objectForKey:@"status"] integerValue] == 301){
             [self promptInformationActionWarningString:@"请填写手机号"];
        } else if ( [[resultDic objectForKey:@"status"] integerValue]== 303){
            [self promptInformationActionWarningString:@"账号已存在"];
        } else if ( [[resultDic objectForKey:@"status"] integerValue] == 317){
            [self promptInformationActionWarningString:@"推荐码无效"];
        } else {
            [self promptInformationActionWarningString:@"操作失败"];
        }

    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
      [self promptInformationActionWarningString:[NSString stringWithFormat:@"%ld",(long)error.code]];        
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
@end
