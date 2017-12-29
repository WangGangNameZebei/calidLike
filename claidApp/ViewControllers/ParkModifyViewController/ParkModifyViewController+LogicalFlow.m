//
//  ParkModifyViewController+LogicalFlow.m
//  claidApp
//
//  Created by kevinpc on 2017/9/15.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "ParkModifyViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>
#import "InternetServices.h"

@implementation ParkModifyViewController (LogicalFlow)

#pragma mark- 提交小区信息
- (void)districtInfoPOSTNameStr:(NSString *)nameStr dataStr:(NSString *)dataStr {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    [manager.requestSerializer setValue:[self userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];
    NSDictionary *parameters = @{@"pptId":[self userInfoReaduserkey:@"districtNumber"],@"pptName":nameStr,@"pptLoc":dataStr};
    [manager POST:CHANGE_OF_INFO_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 200){  //
            [self promptInformationActionWarningString:@"园区信息提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 329){ //过期
            [InternetServices requestLoginPostForUsername:[self userInfoReaduserkey:@"userName"] password:[self userInfoReaduserkey:@"passWord"]];
            [self districtInfoPOSTNameStr:nameStr dataStr:dataStr];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 326 || [[resultDic objectForKey:@"status"] integerValue] == 203 || [[resultDic objectForKey:@"status"] integerValue] == 204 || [[resultDic objectForKey:@"status"] integerValue] == 100) {
            [self alertViewmessage:[resultDic objectForKey:@"msg"]];
        } else {
            [self alertViewmessage:[resultDic objectForKey:@"msg"]];
            [InternetServices logOutPOSTkeystr:[self userInfoReaduserkey:@"userName"]];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
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
    return manager;
}

@end
