//
//  SXSearchHeadView+LogicalFlow.m
//  claidApp
//
//  Created by kevinpc on 2017/9/11.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "SXSearchHeadView+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>
#import "BaseViewController.h"
#import "InternetServices.h"

@implementation SXSearchHeadView (LogicalFlow)
- (void)changeTheNotePOSTnoteStr:(NSString *)noteStr {
    BaseViewController *baseVC = [[BaseViewController alloc] init];
    AFHTTPRequestOperationManager *manager = [self tokenManager];
     [manager.requestSerializer setValue:[baseVC userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];
    NSDictionary *parameters = @{@"accounts":[baseVC userInfoReaduserkey:@"userName"],@"ppt_cell_id":[baseVC userInfoReaduserkey:@"districtNumber"],@"note":noteStr};
    [manager POST:CHANGE_OF_NOTE_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
         if ([[resultDic objectForKey:@"status"] integerValue] == 200) {
             [baseVC promptInformationActionWarningString:@"修改成功"];
         } else if ([[resultDic objectForKey:@"status"] integerValue] == 329){ // token  过期
          [InternetServices requestLoginPostForUsername:[baseVC userInfoReaduserkey:@"userName"] password:[baseVC userInfoReaduserkey:@"passWord"]];
             [self changeTheNotePOSTnoteStr:noteStr]; // 调用自己
         } else if ([[resultDic objectForKey:@"status"] integerValue] == 296 || [[resultDic objectForKey:@"status"] integerValue] == 301 || [[resultDic objectForKey:@"status"] integerValue] == 328 || [[resultDic objectForKey:@"status"] integerValue] == 330) {
             [InternetServices logOutPOSTkeystr:[baseVC userInfoReaduserkey:@"userName"]]; //退出登录
         } else {
            [baseVC promptInformationActionWarningString:@"提交失败，请稍后再试"];
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
