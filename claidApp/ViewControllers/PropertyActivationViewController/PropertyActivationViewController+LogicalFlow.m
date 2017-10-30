//
//  PropertyActivationViewController+LogicalFlow.m
//  claidApp
//
//  Created by kevinpc on 2017/5/31.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "PropertyActivationViewController+LogicalFlow.h"
#import "PropertyActivationViewController+Configuration.h"
#import <AFHTTPRequestOperationManager.h>
#import "UIColor+Utility.h"
#import "CalidTool.h"
#import "InternetServices.h"

@implementation PropertyActivationViewController (LogicalFlow)
- (void)propertyActivationPostForUserData:(NSString *)userData userInfo:(NSString *)userInfo userEqInfo:(NSString *)userEqInfo userPhone:(NSString *)userPhone {
    
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    [manager.requestSerializer setValue:[self userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];
    NSDictionary *parameters = @{@"swipingData":userData,@"userInfo":userInfo,@"userEqInfo":userEqInfo ,@"accounts":userPhone,@"userMode":self.titleLabelString,@"userDisableStatus":[NSString stringWithFormat:@"%ld",(long)self.stopBiaoshi]};
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
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 329) { //token  过期
             [InternetServices requestLoginPostForUsername:[self userInfoReaduserkey:@"userName"] password:[self userInfoReaduserkey:@"passWord"]];
            [self propertyActivationPostForUserData:userData userInfo:userInfo userEqInfo:userEqInfo userPhone:userPhone];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 296 || [[resultDic objectForKey:@"status"] integerValue] == 301 || [[resultDic objectForKey:@"status"] integerValue] == 328 || [[resultDic objectForKey:@"status"] integerValue] == 330) {
            [InternetServices logOutPOSTkeystr:[self userInfoReaduserkey:@"userName"]];
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
     
        NSArray *arrar = [resultDic objectForKey:@"data"];
        [self lanyaCardChuliActiondataStr:arrar[0] olddata:dataStr];
        if (![arrar[1] isEqualToString:@"0"]){
            [self propertyNameAlertEditdataStr:arrar[1]];
        }
         
    } else {
        NSString *receiveData =  [CalidTool lanyaDataDecryptedAction:dataStr];
        self.xiaoquNumber = [NSString stringWithFormat:@"%@",[receiveData substringWithRange:NSMakeRange(2,8)]];
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


#pragma mark- 提交小区信息
- (void)districtInfoPOSTNameStr:(NSString *)nameStr dataStr:(NSString *)dataStr {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    [manager.requestSerializer setValue:[self userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];
    NSDictionary *parameters = @{@"pptId":self.xiaoquNumber,@"pptName":nameStr,@"pptLoc":dataStr};
    [manager POST:CHANGE_OF_INFO_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 200){  //
             [self promptInformationActionWarningString:@"园区信息提交成功"];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 329){ //过期
            [InternetServices requestLoginPostForUsername:[self userInfoReaduserkey:@"userName"] password:[self userInfoReaduserkey:@"passWord"]];
            [self districtInfoPOSTNameStr:nameStr dataStr:dataStr];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 326 || [[resultDic objectForKey:@"status"] integerValue] == 203 || [[resultDic objectForKey:@"status"] integerValue] == 204) {
            [self promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];
        } else {
            [self promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];
            [InternetServices logOutPOSTkeystr:[self userInfoReaduserkey:@"userName"]];
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
    NSString *receiveData =  [CalidTool lanyaDataDecryptedAction:loddata];
    self.xiaoquNumber = [NSString stringWithFormat:@"%@",[receiveData substringWithRange:NSMakeRange(2,8)]];
    NSString *message = [CalidTool crc32producedataStr:[NSString stringWithFormat:@"01%@%@",[receiveData substringWithRange:NSMakeRange(48,8)],datastr]];
    message = [NSString stringWithFormat:@"dd01%@%@",message,datastr];
    [self.paSingleTon sendCommand:message];       //发送数据
    if ([datastr isEqualToString:@"55"]){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 0.4s后自动执行这个block里面的代码
            [self.paSingleTon disConnection];
        });
        
     
    }

}
@end
