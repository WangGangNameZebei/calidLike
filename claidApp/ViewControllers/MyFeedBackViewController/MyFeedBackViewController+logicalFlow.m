//
//  MyFeedBackViewController+logicalFlow.m
//  claidApp
//
//  Created by kevinpc on 2017/6/30.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "MyFeedBackViewController+logicalFlow.h"
#import <AFHTTPRequestOperationManager.h>
#import "InternetServices.h"

@implementation MyFeedBackViewController (logicalFlow)

- (void)feedbackPOSTtextString:(NSString *)textString{
    
    NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
    
    AFHTTPRequestOperationManager *manager = [self tokenManager];
     [manager.requestSerializer setValue:[self userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];
    NSDictionary *parameters = @{@"accounts":[self userInfoReaduserkey:@"userName"],@"content":textString,@"phone_type":@"1",@"phone_model":sysVersion};
    [manager POST:FEED_BACK_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        
        if ([[resultDic objectForKey:@"status"] integerValue] == 329){ //过期
            [InternetServices requestLoginPostForUsername:[self userInfoReaduserkey:@"userName"] password:[self userInfoReaduserkey:@"passWord"]];
            [self feedbackPOSTtextString:textString];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 200 || [[resultDic objectForKey:@"status"] integerValue] == 203 || [[resultDic objectForKey:@"status"] integerValue] == 204|| [[resultDic objectForKey:@"status"] integerValue] == 324 ||  [[resultDic objectForKey:@"status"] integerValue] == 100) {
            //[self alertViewmessage:[resultDic objectForKey:@"msg"]];
        } else {
            [InternetServices logOutPOSTkeystr:[self userInfoReaduserkey:@"userName"]];
        }
        
            [self alertViewmessage:[resultDic objectForKey:@"msg"]];
        self.feedbackTextView.text = @"";
        self.feedbacklabel.alpha = 1;
        
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
