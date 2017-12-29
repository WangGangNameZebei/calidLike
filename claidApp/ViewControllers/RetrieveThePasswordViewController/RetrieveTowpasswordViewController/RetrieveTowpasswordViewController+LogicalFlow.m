//
//  RetrieveTowpasswordViewController+LogicalFlow.m
//  claidApp
//
//  Created by kevinpc on 2017/9/26.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "RetrieveTowpasswordViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>

@implementation RetrieveTowpasswordViewController (LogicalFlow)

#pragma mark -找回密码
- (void)retrieveThePsssWordPostDataPhoneNumber:(NSString *)phoneNumber  passWordStr:(NSString *)passWordStr {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    NSDictionary *parameters = @{@"accounts":phoneNumber,@"passwd":passWordStr};
    [manager POST:RETRIEVE_THE_PASSWORD_URL  parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        [self promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];
        if ([[resultDic objectForKey:@"status"] integerValue] == 200) {
            [self.navigationController popToRootViewControllerAnimated:YES];
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
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    return manager;
}
@end
