//
//  InternetServices.m
//  claidApp
//
//  Created by kevinpc on 2017/9/25.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "InternetServices.h"
#import <AFHTTPRequestOperationManager.h>
#import "BaseViewController.h"
#import "InstallCardData.h"
#import "LoginViewController.h"

@implementation InternetServices
+ (AFHTTPRequestOperationManager *)tokenManager {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 设置请求格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    return manager;
}


#pragma mark - token 失效登录
+ (void)requestLoginPostForUsername:(NSString *)username password:(NSString *)password {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    BaseViewController *baseVC = [[BaseViewController alloc] init];
    NSDictionary *parameters = @{@"accounts":username,@"passwd":password,@"imei":[baseVC keyChainIdentifierForVendorString]};
    [manager POST:LOGIN_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSMutableArray *userdataArray;
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *dataArray= [resultDic objectForKey:@"data"];
             userdataArray = dataArray[0];
            [baseVC userInfowriteuserkey:@"Token" uservalue:userdataArray[5]];//存储 token
            
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 205){
            [baseVC createAdatabaseAction];
            NSMutableArray *dataArray= [resultDic objectForKey:@"data"];
            
            [baseVC userInfowriteuserkey:@"userName" uservalue:username];//存储 账号
            [baseVC userInfowriteuserkey:@"passWord" uservalue:password];// 存储 密码//
            [baseVC userInfowriteuserkey:@"Token" uservalue:dataArray[0]];//存储 token
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"userNumber"];// 存储 用户下小区的个数
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"currentUser"]; //登录后默认 为第一个
            
            
        } else {
            [baseVC promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - 检测 是否 被注册
+ (BOOL)userphoneisrequestPostDataPhoneNumber:(NSString *)phoneNumber {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    NSDictionary *parameters = @{@"accounts":phoneNumber};
    [manager POST:DETECTION_REGISTER_URL  parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 301) {
           //未被注册
        } else {
         
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
    }];
    
    return YES;
}
#pragma mark - 退出登录
+ (void)logOutPOSTkeystr:(NSString *)keyStr {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    [manager.requestSerializer setValue:[[BaseViewController alloc] userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];
    NSDictionary *parameters = @{@"accounts":keyStr};
    [manager POST:LOGOUT_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [self clearAllUserDefaultsData];
        [self logOutViewToLogin];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [self clearAllUserDefaultsData];
        [self logOutViewToLogin];
    }];
}
#pragma mark -清除数据 
+ (void)clearAllUserDefaultsData {
    
    DBTool *dbtool = [DBTool sharedDBTool];
    [dbtool dropTableWithClass:[InstallCardData class]];
    [dbtool dropTableWithClass:[UserInfo class]];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults dictionaryRepresentation];
    for (id  key in dic) {
        [userDefaults removeObjectForKey:key];
    }
    [userDefaults synchronize];
}
#pragma mark - 退回到 登录页面
+ (void)logOutViewToLogin {
    LoginViewController *loginViewController = [LoginViewController create];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    navigationController.navigationBarHidden = YES;
    UIApplication.sharedApplication.delegate.window.rootViewController = navigationController;
   [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"loginInfo"];
}

@end
