//
//  MyViewController+LogicalFlow.m
//  claidApp
//
//  Created by kevinpc on 2016/10/24.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "MyViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>
#import <AESCrypt.h>
#import "LoginViewController.h"
#import "InternetServices.h"

@implementation MyViewController (LogicalFlow)

- (void)theinternetCardupData {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    [manager.requestSerializer setValue:[self userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];
    NSString *username = [self userInfoReaduserkey:@"userName"];
    NSString *password = [self userInfoReaduserkey:@"passWord"];
    NSDictionary *parameters = @{@"accounts":username,@"passwd":password,@"imei":[self keyChainIdentifierForVendorString]};
    [manager POST:RENEWAL_USER_DATA_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSMutableArray *userdataArray;
        NSString *encryptedData;
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 200) {
            
            NSString *currentUserstr =[[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser"];
            NSMutableArray *dataArray= [resultDic objectForKey:@"data"];
            if ([currentUserstr integerValue] >= dataArray.count) {
                currentUserstr = [NSString stringWithFormat:@"%lu",(unsigned long)dataArray.count - 1];
            }
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
            }
            [[NSUserDefaults standardUserDefaults] setObject:currentUserstr forKey:@"currentUser"]; // 恢复之前存储
            [self promptInformationActionWarningString:@"数据更新成功!"];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 205){
            [InternetServices clearAllUserDefaultsData];
            [self createAdatabaseAction];
            NSMutableArray *dataArray= [resultDic objectForKey:@"data"];
            NSArray *dataTowArray =dataArray[0];
            [self userInfowriteuserkey:@"Token" uservalue:dataTowArray[0]];//存储 token
            [self userInfowriteuserkey:@"userName" uservalue:username];//存储 账号
            [self userInfowriteuserkey:@"passWord" uservalue:password];// 存储 密码//
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"userNumber"];// 存储 用户下小区的个数
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"loginInfo"];  //登录标识
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"currentUser"]; //登录后默认 为第一个
            
            [self promptInformationActionWarningString:@"该账号未激活"];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 329) {      // Token  失效获取新的
            [InternetServices requestLoginPostForUsername:[self userInfoReaduserkey:@"userName"] password:[self userInfoReaduserkey:@"passWord"]];
            [self theinternetCardupData];
        } else {
              [InternetServices logOutPOSTkeystr:[self userInfoReaduserkey:@"userName"]]; //退出登录
              [self promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];
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
