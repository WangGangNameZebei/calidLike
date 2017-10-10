//
//  invitaionCodeViewController+LogicalFlow.m
//  claidApp
//
//  Created by kevinpc on 2017/3/23.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "invitaionCodeViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>
#import "InternetServices.h"

@implementation invitaionCodeViewController (LogicalFlow)


- (void)invitionCodeForPhonenumber:(NSString *)touristPhone beizhutext:(NSString *)beizhutext  {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    NSString *useroraNamestr =[self userInfoReaduserkey:@"userName"];
    NSString * ownerStr = [self userInfoReaduserkey:@"districtNumber"];
    if (ownerStr.length != 8){
        [self promptInformationActionWarningString:@"当前小区为空"];
    }
     [manager.requestSerializer setValue:[self userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];
    NSDictionary *parameters = @{@"accounts":useroraNamestr,@"tourist_phone":touristPhone,@"note":beizhutext,@"ppt_cell_id":ownerStr};
    [manager POST:INVITAION_VISITOR_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
       if ([[resultDic objectForKey:@"status"] integerValue] == 329){ //过期
           [InternetServices requestLoginPostForUsername:useroraNamestr password:[self userInfoReaduserkey:@"passWord"]];
           [self invitionCodeForPhonenumber:touristPhone beizhutext:beizhutext];
       } else if ([[resultDic objectForKey:@"status"] integerValue] == 200 || [[resultDic objectForKey:@"status"] integerValue] == 312 || [[resultDic objectForKey:@"status"] integerValue] == 203 || [[resultDic objectForKey:@"status"] integerValue] == 204 || [[resultDic objectForKey:@"status"] integerValue] == 331) {
          [self promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];
       } else {
           [self promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];
           [InternetServices logOutPOSTkeystr:useroraNamestr];
       }
        
        self.requestBool = YES;
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (error.code == -1009){
            [self promptInformationActionWarningString:@"您的网络有异常"];
        } else {
            [self promptInformationActionWarningString:[NSString stringWithFormat:@"%ld",(long)error.code]];
        }
        self.requestBool = YES;
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
