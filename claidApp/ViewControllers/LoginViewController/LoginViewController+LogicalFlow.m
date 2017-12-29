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
    NSDictionary *parameters = @{@"accounts":username,@"passwd":password,@"imei":[self keyChainIdentifierForVendorString]};
    [manager POST:LOGIN_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSMutableArray *userdataArray;
        NSString *encryptedData;
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 200) {
            NSMutableArray *dataArray= [resultDic objectForKey:@"data"];
           
            [self createAdatabaseAction];
             [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",dataArray.count] forKey:@"userNumber"];// 存储 用户下小区的个数
            for (NSInteger i = 0; i <dataArray.count; i++) {
               [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)i] forKey:@"currentUser"]; // ／／存储 当前小区标识
                userdataArray = dataArray[i];
                encryptedData = [AESCrypt encrypt:[NSString stringWithFormat:@"%@",userdataArray[2]] password:AES_PASSWORD];  //加密
                
                  [self userInfowriteuserkey:@"lanyaAESData" uservalue:encryptedData]; //存储  刷卡数据
                
                   [self userInfowriteuserkey:@"userorakey" uservalue:[NSString stringWithFormat:@"%@",userdataArray[0]]];    //存储     推荐码
                
                
                  [self userInfowriteuserkey:@"districtNumber" uservalue:[NSString stringWithFormat:@"%@",userdataArray[1]]];       //存储  小区号
                  [self userInfowriteuserkey:@"districtName" uservalue:[NSString stringWithFormat:@"%@%@",userdataArray[3],userdataArray[4]]];       //存储  小区名称
                
                [self userInfowriteuserkey:@"role" uservalue:[NSString stringWithFormat:@"%@",userdataArray[6]]];       // 小区 管理员标识
            }
           [self userInfowriteuserkey:@"Token" uservalue:userdataArray[5]];//存储 tpken
            [self userInfowriteuserkey:@"userName" uservalue:username];//存储 账号
            [self userInfowriteuserkey:@"passWord" uservalue:password];// 存储 密码//            
            
            CustomTabBarController *customTabBarController = [self createCustomTabBarController];
            UIApplication.sharedApplication.delegate.window.rootViewController = customTabBarController;
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"loginInfo"];  //登录标识
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"currentUser"]; //登录后默认 为第一个小区
            
         } else if ([[resultDic objectForKey:@"status"] integerValue] == 205){
             [self createAdatabaseAction];
             NSMutableArray *dataArray= [resultDic objectForKey:@"data"];
             
             NSArray *dataTowArray =dataArray[0];
             [self userInfowriteuserkey:@"userName" uservalue:username];//存储 账号
             [self userInfowriteuserkey:@"passWord" uservalue:password];// 存储 密码//
            [self userInfowriteuserkey:@"Token" uservalue:dataTowArray[0]];//存储 tpken
             [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"userNumber"];// 存储 用户下小区的个数
             CustomTabBarController *customTabBarController = [self createCustomTabBarController];
             UIApplication.sharedApplication.delegate.window.rootViewController = customTabBarController;
             [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"loginInfo"];  //登录标识
             [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"currentUser"]; //登录后默认 为第一个

        
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
    return manager;
}

@end
