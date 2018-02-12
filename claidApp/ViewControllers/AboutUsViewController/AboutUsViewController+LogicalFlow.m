//
//  AboutUsViewController+LogicalFlow.m
//  claidApp
//
//  Created by Zebei on 2017/11/3.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "AboutUsViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>
#import "AboutUsViewController+Configuration.h"
#import "CalidTool.h"
#import "InternetServices.h"

@implementation AboutUsViewController (LogicalFlow)

- (void)administratorApplicationPOSTdataaccountsstr:(NSString *)accounts pptCellId:(NSString *)pptCellId role:(NSString *)role {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    [manager.requestSerializer setValue:[self userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];
    NSDictionary *parameters = @{@"accounts":accounts,@"ppt_cell_id":pptCellId,@"role":role};
    [manager POST:APPLY_PPT_ADMINISTRATOR_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        
        if ([[resultDic objectForKey:@"status"] integerValue] == 296 || [[resultDic objectForKey:@"status"] integerValue] == 328 || [[resultDic objectForKey:@"status"] integerValue] == 330){  //异常 退出登录
            [self.managementSingleTon disConnection];
            [InternetServices logOutPOSTkeystr:[self userInfoReaduserkey:@"userName"]];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 329){
            [InternetServices requestLoginPostForUsername:[self userInfoReaduserkey:@"userName"] password:[self userInfoReaduserkey:@"passWord"]];
            [self administratorApplicationPOSTdataaccountsstr:accounts pptCellId:pptCellId role:role];
        } else if ( [[resultDic objectForKey:@"status"] integerValue] == 301 ){
            [self alertViewmessage:[resultDic objectForKey:@"msg"]];
        } else {
            [self promptInformationActionWarningString:[resultDic objectForKey:@"msg"]];
        }
        
        
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (error.code == -1009){
            [self promptInformationActionWarningString:@"您的网络有异常"];
        } else {
            [self promptInformationActionWarningString:[NSString stringWithFormat:@"%ld",(long)error.code]];
        }
        
    }];

}
#pragma mark- 效验发卡器
- (void)checkStatusOfCardPOSTdataStr:(NSString *)dataStr {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    NSDictionary *parameters = @{@"cardData":dataStr};
    [manager POST:CHECK_STATUS_CARD_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 200){  //
            
            NSArray *arrar = [resultDic objectForKey:@"data"];
            [self lanyaCardChuliActiondataStr:arrar[0] olddata:dataStr];
            
        } else {
            NSString *receiveData =  [CalidTool lanyaDataDecryptedAction:dataStr];
            self.xiaoquNumber = [NSString stringWithFormat:@"%@",[receiveData substringWithRange:NSMakeRange(2,8)]];
            [self lanyaCardChuliActiondataStr:@"00" olddata:dataStr];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [self.managementSingleTon disConnection];       // 退出前 断开蓝牙
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
    return manager;
}

- (void)lanyaCardChuliActiondataStr:(NSString *)datastr olddata:(NSString *)loddata {
    NSString *receiveData =  [CalidTool lanyaDataDecryptedAction:loddata];
    self.xiaoquNumber = [NSString stringWithFormat:@"%@",[receiveData substringWithRange:NSMakeRange(2,8)]];
    NSString *message = [CalidTool crc32producedataStr:[NSString stringWithFormat:@"01%@%@",[receiveData substringWithRange:NSMakeRange(48,8)],datastr]];
    message = [NSString stringWithFormat:@"dd01%@%@",message,datastr];
    [self.managementSingleTon sendCommand:message];       //发送数据
    if ([datastr isEqualToString:@"55"]){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 0.4s后自动执行这个block里面的代码
            [self.managementSingleTon disConnection];
        });
        
        
    }
    
}
@end
