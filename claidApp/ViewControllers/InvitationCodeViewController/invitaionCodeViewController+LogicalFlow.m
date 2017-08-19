//
//  invitaionCodeViewController+LogicalFlow.m
//  claidApp
//
//  Created by kevinpc on 2017/3/23.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "invitaionCodeViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>

@implementation invitaionCodeViewController (LogicalFlow)


- (void)invitionCodeForPhonenumber:(NSString *)touristPhone beizhutext:(NSString *)beizhutext  {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    NSString *userorakey =[self userInfoReaduserkey:@"userorakey"];
    NSDictionary *parameters = @{@"t_owner":userorakey,@"t_touristPhone":touristPhone,@"t_owner_Note":beizhutext};
    [manager POST:INVITAION_VISITOR_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil]; 
            [self promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];
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
