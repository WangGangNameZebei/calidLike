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


/*输出宏*/
#define AES_PASSWORD @"ufwjfitn"
#define LOGIN_URL @"http://192.168.1.114:8080/calid/login.do"
@implementation LoginViewController (LogicalFlow)

- (void)requestLoginPostForUsername:(NSString *)username password:(NSString *)password {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    NSDictionary *parameters = @{@"accounts":username,@"passwd":password};
    [manager POST:LOGIN_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 200) {
            NSString *dataString = [resultDic objectForKey:@"data"];
            NSString *encryptedData = [AESCrypt encrypt:dataString password:AES_PASSWORD];  //加密
            [[NSUserDefaults standardUserDefaults] setObject:encryptedData forKey:@"lanyaAESData"];  //存储
            CustomTabBarController *customTabBarController = [self createCustomTabBarController];
           UIApplication.sharedApplication.delegate.window.rootViewController = customTabBarController;
            
        } else {
                [self promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];

        }
    
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"返回数据------->%@",error);

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
