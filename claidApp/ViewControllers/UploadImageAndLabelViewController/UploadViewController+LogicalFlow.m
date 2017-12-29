//
//  UploadViewController+LogicalFlow.m
//  claidApp
//
//  Created by Zebei on 2017/12/13.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "UploadViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>
#import "UIImage+Utility.h"
#import "InternetServices.h"

@implementation UploadViewController (LogicalFlow)

#pragma mrak- 物业公告上传
- (void)uploadAnnouncementdataTitleStr:(NSString *)datatitlestr dataTextStr:(NSString *)textString {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    [manager.requestSerializer setValue:[self userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];
    NSDictionary *parameters = @{@"accounts":[self userInfoReaduserkey:@"userName"],@"ppt_cell_id":[self userInfoReaduserkey:@"districtNumber"],@"notification_title":datatitlestr,@"notification_content":textString,@"notificationFiles":self.imageDataArray};
    [manager POST:UPLOAD_NOTIFICATION_URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        UIImage *imagedata;
        //利用for循环上传多张图片
        for (NSInteger i = 0; i < self.imageDataArray.count; i++) {
            imagedata = [self.imageDataArray objectAtIndex:i];
            imagedata =  [UIImage scaleImage:imagedata toKb:500];
            NSData *imageData = UIImagePNGRepresentation(imagedata);
            [formData appendPartWithFileData:imageData name:@"notificationFiles" fileName:[NSString stringWithFormat:@"%ld.png", (long)i] mimeType:@"image/png"];
        }
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 200){  //
            [self promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 329){ //过期
            [InternetServices requestLoginPostForUsername:[self userInfoReaduserkey:@"userName"] password:[self userInfoReaduserkey:@"passWord"]];
            [self uploadAnnouncementdataTitleStr:datatitlestr dataTextStr:textString];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 296 || [[resultDic objectForKey:@"status"] integerValue] == 301 || [[resultDic objectForKey:@"status"] integerValue] == 328 || [[resultDic objectForKey:@"status"] integerValue] == 330) {
            [self alertViewmessage:[resultDic objectForKey:@"msg"]];
            [InternetServices logOutPOSTkeystr:[self userInfoReaduserkey:@"userName"]];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 342){   //小区 管理员失效
              [self userInfowriteuserkey:@"role" uservalue:@"0"];       // 小区 管理员标识
        } else {
            [self alertViewmessage:[resultDic objectForKey:@"msg"]];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (error.code == -1009){
            [self promptInformationActionWarningString:@"您的网络有异常"];
            
        } else {
            [self promptInformationActionWarningString:[NSString stringWithFormat:@"%ld",(long)error.code]];
        }
    }];
}
#pragma mrak- 用户报修上传
- (void)uploadRepairdataTextStr:(NSString *)textString {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    [manager.requestSerializer setValue:[self userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];
    NSDictionary *parameters = @{@"accounts":[self userInfoReaduserkey:@"userName"],@"ppt_cell_id":[self userInfoReaduserkey:@"districtNumber"],@"repairs_content":textString,@"repairsFiles":self.imageDataArray};
    [manager POST:UPLOAD_REPAIR_URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        UIImage *imagedata;
        //利用for循环上传多张图片
        for (NSInteger i = 0; i < self.imageDataArray.count; i++) {
            imagedata = [self.imageDataArray objectAtIndex:i];
            imagedata =  [UIImage scaleImage:imagedata toKb:500];
            NSData *imageData = UIImagePNGRepresentation(imagedata);
            [formData appendPartWithFileData:imageData name:@"repairsFiles" fileName:[NSString stringWithFormat:@"%ld.png", (long)i] mimeType:@"image/png"];
        }
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 200){  //
            [self promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];
            [self dismissViewControllerAnimated:YES completion:nil];
           
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 329){ //过期
            [InternetServices requestLoginPostForUsername:[self userInfoReaduserkey:@"userName"] password:[self userInfoReaduserkey:@"passWord"]];
            [self uploadRepairdataTextStr:textString];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 296 || [[resultDic objectForKey:@"status"] integerValue] == 301 || [[resultDic objectForKey:@"status"] integerValue] == 328 || [[resultDic objectForKey:@"status"] integerValue] == 330) {
            [self alertViewmessage:[resultDic objectForKey:@"msg"]];
            [InternetServices logOutPOSTkeystr:[self userInfoReaduserkey:@"userName"]];
        } else {
            [self alertViewmessage:[resultDic objectForKey:@"msg"]];
          
        }
       
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
    manager.requestSerializer.timeoutInterval = 20;
    //manager.responseSerializer = [AFJSONResponseSerializer serializer];
    // 设置返回格式
   // manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
  
    return manager;
}
@end
