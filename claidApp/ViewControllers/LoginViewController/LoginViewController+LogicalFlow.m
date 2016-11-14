//
//  LoginViewController+LogicalFlow.m
//  claidApp
//
//  Created by kevinpc on 2016/10/31.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "LoginViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>

#define LOGIN_URL @"http://www.calid.com/api/login"
@implementation LoginViewController (LogicalFlow)

- (void)requestLoginPostForUsername:(NSString *)username password:(NSString *)password lannyaKey:(NSString *)lanyaKey {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    NSDictionary *parameters = @{@"username":username,@"password":password,@"lanyakey":lanyaKey};
    [manager POST:LOGIN_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSLog(@"返回数据=======>%@",[responseObject objectForKey:@"result"]);
    
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"返回数据------->%@",error);

    }];
}

- (AFHTTPRequestOperationManager *)tokenManager {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    return manager;
}

@end
