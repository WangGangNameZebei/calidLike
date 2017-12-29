//
//  CommunityViewController+LogicalFlow.m
//  claidApp
//
//  Created by Zebei on 2017/12/21.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "CommunityViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>
#import "InternetServices.h"

@implementation CommunityViewController (LogicalFlow)
- (void)announcementsetPOSTDataAction {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    [manager.requestSerializer setValue:[self userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];
    NSDictionary *parameters = @{@"ppt_cell_id":[self userInfoReaduserkey:@"districtNumber"]};
    [manager POST:PROPERTY_ANNOUNCEMENT_INQUIRIES_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        
        if ([[resultDic objectForKey:@"status"] integerValue] == 200) {
            self.communityViewControllerDataSource.resultDataDic = [resultDic objectForKey:@"data"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.communityTableView reloadData];
            });
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 296 || [[resultDic objectForKey:@"status"] integerValue] == 301 || [[resultDic objectForKey:@"status"] integerValue] == 328 || [[resultDic objectForKey:@"status"] integerValue] == 330){
            [InternetServices logOutPOSTkeystr:[self userInfoReaduserkey:@"userName"]]; //退出登录
            [self alertViewmessage:[resultDic objectForKey:@"msg"]];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 329) {
            [InternetServices requestLoginPostForUsername:[self userInfoReaduserkey:@"userName"] password:[self userInfoReaduserkey:@"passWord"]];
            [self announcementsetPOSTDataAction];
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


- (AFHTTPRequestOperationManager *)tokenManager {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 设置请求格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    return manager;
}
@end
