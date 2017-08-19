//
//  PropertyActivationViewController+LogicalFlow.m
//  claidApp
//
//  Created by kevinpc on 2017/5/31.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "PropertyActivationViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>
#import "UIColor+Utility.h"
#import "SingleTon+tool.h"

@implementation PropertyActivationViewController (LogicalFlow)
- (void)propertyActivationPostForUserData:(NSString *)userData userInfo:(NSString *)userInfo userEqInfo:(NSString *)userEqInfo userPhone:(NSString *)userPhone password:(NSString *)password {
    
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    NSDictionary *parameters = @{@"swipingData":userData,@"userInfo":userInfo,@"userEqInfo":userEqInfo ,@"userPhone":userPhone,@"userPassword":password,@"userMode":self.titleLabelString};
    [manager POST:ADDUSERPROPERTY_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
      
        if ([[resultDic objectForKey:@"status"] integerValue] == 200){  // 注册成功  清除数据
            self.userInfo = @"";
            self.pAPhoneNumberTextField.text = @"";
            self.uploadButton.backgroundColor = [UIColor setupGreyColor];
           [self promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];
        } else {
            
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

#pragma mark- 效验发卡器
- (void)checkStatusOfCardPOSTdataStr:(NSString *)dataStr {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    NSDictionary *parameters = @{@"cardData":dataStr};
    [manager POST:CHECK_STATUS_CARD_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
    if ([[resultDic objectForKey:@"status"] integerValue] == 200){  //
     
        [self lanyaCardChuliActiondataStr:[resultDic objectForKey:@"data"] olddata:dataStr];
         
    } else {
        [self lanyaCardChuliActiondataStr:@"00" olddata:dataStr];
    }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [self.paSingleTon disConnection];       // 退出前 断开蓝牙
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
    
    NSString *cardData = [AESCrypt decrypt:[self userInfoReaduserkey:@"lanyaAESData"] password:AES_PASSWORD];
    
    NSDictionary *parameters = @{@"oraKey":[self userInfoReaduserkey:@"userorakey"],@"cn_calid_pptId":[self userInfoReaduserkey:@"districtNumber"],@"res":cardData};
    [manager POST:RENEWAL_USER_DATA_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 318) {
            NSMutableArray *dataArray= [resultDic objectForKey:@"data"];
            NSString *encryptedData = [AESCrypt encrypt:[NSString stringWithFormat:@"%@",dataArray[1]] password:AES_PASSWORD];  //加密
            [self userInfowriteuserkey:@"lanyaAESData" uservalue:encryptedData];  //存储
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

- (void)lanyaCardChuliActiondataStr:(NSString *)datastr olddata:(NSString *)loddata {
    NSString *receiveData =  [[SingleTon alloc] lanyaDataDecryptedAction:loddata];
    NSString *message = [SingleTon crc32producedataStr:[NSString stringWithFormat:@"01%@%@",[receiveData substringWithRange:NSMakeRange(48,8)],datastr]];
    message = [NSString stringWithFormat:@"dd01%@%@",message,datastr];
    [self.paSingleTon sendCommand:message];       //发送数据

}
@end
