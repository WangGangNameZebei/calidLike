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
    NSDictionary *parameters = @{@"swipingData":userData,@"userInfo":userInfo,@"userEqInfo":userEqInfo ,@"userPhone":userPhone,@"userPassword":password,@"userMode":self.titleLabelString};
    [manager POST:ADDUSERPROPERTY_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        [self promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];
      
        if ([[resultDic objectForKey:@"msg"] isEqualToString:@"注册成功"]){  // 注册成功  清除数据
            self.userInfo = @"";
            self.pAPhoneNumberTextField.text = @"";
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (error.code == -1009){
            [self promptInformationActionWarningString:@"您的网络有异常"];
        } else {
            [self promptInformationActionWarningString:[NSString stringWithFormat:@"%ld",(long)error.code]];
        }
        
    }];

    
}

//更新数据
- (void)theinternetCardupData {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    
    NSString *cardData = [AESCrypt decrypt:[[NSUserDefaults standardUserDefaults] objectForKey:@"lanyaAESData"] password:AES_PASSWORD];
    
    NSDictionary *parameters = @{@"oraKey":[[NSUserDefaults standardUserDefaults] objectForKey:@"userorakey"],@"cn_calid_pptId":[[NSUserDefaults standardUserDefaults] objectForKey:@"districtNumber"],@"res":cardData};
    [manager POST:RENEWAL_USER_DATA_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 318) {
            NSMutableArray *dataArray= [resultDic objectForKey:@"data"];
            NSString *encryptedData = [AESCrypt encrypt:[NSString stringWithFormat:@"%@",dataArray[1]] password:AES_PASSWORD];  //加密
            [[NSUserDefaults standardUserDefaults] setObject:encryptedData forKey:@"lanyaAESData"];  //存储
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
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
