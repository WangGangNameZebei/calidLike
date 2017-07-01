//
//  LoginViewController+LogicalFlow.m
//  claidApp
//
//  Created by kevinpc on 2016/10/31.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "LoginViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>
#import <AESCrypt.h>


@implementation LoginViewController (LogicalFlow)

- (void)requestLoginPostForUsername:(NSString *)username password:(NSString *)password {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    NSDictionary *parameters = @{@"accounts":username,@"passwd":password,@"IMEI":[self keyChainIdentifierForVendorString]};
    [manager POST:LOGIN_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *dataArray= [resultDic objectForKey:@"data"];
            NSString *encryptedData = [AESCrypt encrypt:[NSString stringWithFormat:@"%@",dataArray[2]] password:AES_PASSWORD];  //加密
            [[NSUserDefaults standardUserDefaults] setObject:encryptedData forKey:@"lanyaAESData"];  //存储
            
             [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",dataArray[0]] forKey:@"userorakey"];  //存储     推荐码
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",dataArray[1]] forKey:@"districtNumber"];  //存储  小区号
            
            CustomTabBarController *customTabBarController = [self createCustomTabBarController];
            UIApplication.sharedApplication.delegate.window.rootViewController = customTabBarController;
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"loginInfo"];  //登录标识
            
        } else {
                [self promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];
                [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"loginInfo"];
            

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
   // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    return manager;
}

@end
