//
//  MyViewController+LogicalFlow.m
//  claidApp
//
//  Created by kevinpc on 2016/10/24.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "MyViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>
#import <AESCrypt.h>


@implementation MyViewController (LogicalFlow)

- (void)theinternetCardupData {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    
    NSString *cardData = [AESCrypt decrypt:[[NSUserDefaults standardUserDefaults] objectForKey:@"lanyaAESData"] password:AES_PASSWORD];
    
    NSDictionary *parameters = @{@"oraKey":[[NSUserDefaults standardUserDefaults] objectForKey:@"userorakey"],@"cn_calid_pptId":[[NSUserDefaults standardUserDefaults] objectForKey:@"districtNumber"],@"res":cardData};
    [manager POST:RENEWAL_USER_DATA_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 318) {
           NSMutableArray *dataArray= [resultDic objectForKey:@"data"];
            NSString *encryptedData = [AESCrypt encrypt:[NSString stringWithFormat:@"%@",dataArray[1]] password:AES_PASSWORD];  //加密
            [[NSUserDefaults standardUserDefaults] setObject:encryptedData forKey:@"lanyaAESData"];  //存储
            [self alertViewmessage:[NSString stringWithFormat:@"数据已经更新,由于是物业更新的数据,登录密码已被初始化,可以到修改密码页面进行更改,重置密码为:  %@  ,点击确认,密码不再提示!",dataArray[0]]];
            
        } else {
            [self promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [self promptInformationActionWarningString:[NSString stringWithFormat:@"%ld",(long)error.code]];
        
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
