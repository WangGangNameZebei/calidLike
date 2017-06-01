//
//  PropertyActivationViewController+LogicalFlow.m
//  claidApp
//
//  Created by kevinpc on 2017/5/31.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "PropertyActivationViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>


@implementation PropertyActivationViewController (LogicalFlow)
- (void)propertyActivationPostForUserData:(NSString *)userData userInfo:(NSString *)userInfo userEqInfo:(NSString *)userEqInfo userPhone:(NSString *)userPhone password:(NSString *)password {
    
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    NSDictionary *parameters = @{@"swipingData":userData,@"userInfo":userInfo,@"userEqInfo":userEqInfo ,@"userPhone":userPhone,@"userPassword":password};
    [manager POST:ADDUSERPROPERTY_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        [self promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];
      
        
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