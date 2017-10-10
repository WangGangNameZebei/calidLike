//
//  ChangeThePasswordViewController+LogicalFlow.m
//  claidApp
//
//  Created by kevinpc on 2017/6/24.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "ChangeThePasswordViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>
#import "InternetServices.h"

@implementation ChangeThePasswordViewController (LogicalFlow)

- (void)changeThePasswordPOSTForoldpasssword:(NSString *)oldpassword newpassword:(NSString *)newpassword {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    [manager.requestSerializer setValue:[self userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];
    NSDictionary *parameters = @{@"accounts":[self userInfoReaduserkey:@"userName"],@"passwd":oldpassword,@"new_passwd":newpassword};
    [manager POST:UP_DATA_USER_PWD_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
            [self promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];
        if([[resultDic objectForKey:@"status"] integerValue] == 200){
            [self userInfowriteuserkey:@"passWord" uservalue:newpassword]; //修改数据库密码
            self.oldPasswordTextField.text = @"";
            self.changenewPasswordTextField.text = @"";
            self.confirmnewPasswoedTextField.text = @"";
            
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 329){ //过期
            [InternetServices requestLoginPostForUsername:[self userInfoReaduserkey:@"userName"] password:[self userInfoReaduserkey:@"passWord"]];
            [self changeThePasswordPOSTForoldpasssword:oldpassword newpassword:newpassword];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 316 || [[resultDic objectForKey:@"status"] integerValue] == 203 || [[resultDic objectForKey:@"status"] integerValue] == 204) {
            [self promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];
        } else {
            [self promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];
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
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    return manager;
}
@end
