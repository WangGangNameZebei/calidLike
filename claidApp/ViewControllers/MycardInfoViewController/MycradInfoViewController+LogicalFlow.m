//
//  MycradInfoViewController+LogicalFlow.m
//  claidApp
//
//  Created by Zebei on 2018/2/1.
//  Copyright © 2018年 kevinpc. All rights reserved.
//

#import "MycradInfoViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>
#import "InternetServices.h"
#import "UIImage+Utility.h"
#import "MycradInfoViewController+Configuration.h"

@implementation MycradInfoViewController (LogicalFlow)

- (void)getPOSTuserInfoAction{
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    [manager.requestSerializer setValue:[self userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];
    NSString *username = [self userInfoReaduserkey:@"userName"];
    NSDictionary *parameters = @{@"accounts":username};
    
    [manager POST:USER_INFO_DATD_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 200) {
            NSMutableDictionary *resultDicTow = [resultDic objectForKey:@"data"];
         self.imagedata = [UIImage getImageFromURL:[NSString stringWithFormat:@"http://sycalid.cn//%@",[resultDicTow objectForKey:@"avatar"]]];
            self.userNameString =[resultDicTow objectForKey:@"nickname"];
            [self.myInfoTableView reloadData];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 329) {      // Token  失效获取新的
            [InternetServices requestLoginPostForUsername:[self userInfoReaduserkey:@"userName"] password:[self userInfoReaduserkey:@"passWord"]];
            [self getPOSTuserInfoAction];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 100){//  操作频繁
            [self promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];
        } else {
            [self alertViewmessage:[resultDic objectForKey:@"msg"]];
        }
    
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (error.code == -1009){
            [self promptInformationActionWarningString:@"您的网络有异常"];
        } else {
            [self promptInformationActionWarningString:[NSString stringWithFormat:@"%ld",(long)error.code]];
        }
        
    }];
    
    
}

- (void)uploadPOSTuserInfoActionUserNameString:(NSString *)userNameString {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    [manager.requestSerializer setValue:[self userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];
    NSString *username = [self userInfoReaduserkey:@"userName"];
    NSString *editBoolStr = [NSString stringWithFormat:@"%d",self.editBool];
    NSDictionary *parameters = @{@"accounts":username,@"nickname":userNameString,@"is_avatar_change":editBoolStr};
    
    [manager POST:USER_UPLOAD_INFO_DATD_URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            self.imagedata = [UIImage scaleImage:self.imagedata toKb:200];
            NSData *imageData = UIImagePNGRepresentation(self.imagedata);
            [formData appendPartWithFileData:imageData name:@"avatarfile" fileName:self.fileName mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 200) {
            [self myInfoEditBoolAction:NO];
            [self promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 329) {      // Token  失效获取新的
            [InternetServices requestLoginPostForUsername:[self userInfoReaduserkey:@"userName"] password:[self userInfoReaduserkey:@"passWord"]];
            [self uploadPOSTuserInfoActionUserNameString:userNameString];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 100){//  操作频繁
            [self promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 296 ||[[resultDic objectForKey:@"status"] integerValue] == 301 || [[resultDic objectForKey:@"status"] integerValue] == 328 ||[[resultDic objectForKey:@"status"] integerValue] == 330){
            [self alertViewmessage:[resultDic objectForKey:@"msg"]];
            [InternetServices logOutPOSTkeystr:[self userInfoReaduserkey:@"userName"]];
         } else {
             [self alertViewmessage:[resultDic objectForKey:@"msg"]];
         }
       
        [self alertViewmessage:[resultDic objectForKey:@"msg"]];
      
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
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    return manager;
}


@end
