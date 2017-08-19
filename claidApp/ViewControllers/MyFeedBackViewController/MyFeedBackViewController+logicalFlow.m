//
//  MyFeedBackViewController+logicalFlow.m
//  claidApp
//
//  Created by kevinpc on 2017/6/30.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "MyFeedBackViewController+logicalFlow.h"
#import <AFHTTPRequestOperationManager.h>

@implementation MyFeedBackViewController (logicalFlow)

- (void)feedbackPOSTtextString:(NSString *)textString{
    
    NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
    
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    NSDictionary *parameters = @{@"i_oraKey":[self userInfoReaduserkey:@"userorakey"],@"i_content":textString,@"i_phone_type":@"1",@"i_phone_model":sysVersion};
    [manager POST:FEED_BACK_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
            [self promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];
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
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    return manager;
}

@end
