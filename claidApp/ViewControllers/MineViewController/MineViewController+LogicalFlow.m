//
//  MineViewController+LogicalFlow.m
//  claidApp
//
//  Created by kevinpc on 2016/10/19.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "MineViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>
#import "DBTool.h"
#import "CreditCardRecords.h"
#import "InternetServices.h"

@implementation MineViewController (LogicalFlow)


- (void)uploadRecordingDataAction {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    [manager.requestSerializer setValue:[self userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];
    DBTool *tool = [DBTool sharedDBTool];
    CreditCardRecords *creditCardRecords;
    NSDictionary *uploadDictionary;
    NSString *uploadString = @"";
    NSData * jsonData;
    NSString * myString;
    NSArray *data = [tool selectWithClass:[CreditCardRecords class] params:nil];
    if (data.count == 0){
        return;
    } else {
        for (NSInteger i = 0; i <data.count ; i++) {
            creditCardRecords = data[i];
            uploadDictionary = @{@"accounts":[self userInfoReaduserkey:@"userName"],@"ppt_cell_id": creditCardRecords.communityNumber,@"swiping_address":creditCardRecords.swipeAddress,@"swiping_sensitivity":creditCardRecords.swipeSensitivity,@"swiping_status": creditCardRecords.swipeStatus,@"swiping_time":creditCardRecords.swipeTime};
            jsonData = [NSJSONSerialization dataWithJSONObject:uploadDictionary options:0 error:nil];
            myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            if (uploadString.length < 8){
                uploadString = [NSString stringWithFormat:@"%@",myString];
            } else {
                uploadString = [NSString stringWithFormat:@"%@,%@",uploadString,myString];
            }
        }
    }

    
    uploadString = [NSString stringWithFormat:@"[%@]",uploadString];
    NSDictionary *parameters = @{@"recordJson":uploadString};
    
    [manager POST:UPLOAD_RECORDING_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {

        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 200) {
            [tool dropTableWithClass:[CreditCardRecords class]]; // 成功删除记录
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 296 || [[resultDic objectForKey:@"status"] integerValue] == 301 || [[resultDic objectForKey:@"status"] integerValue] == 328 || [[resultDic objectForKey:@"status"] integerValue] == 330){
            [InternetServices logOutPOSTkeystr:[self userInfoReaduserkey:@"userName"]]; //退出登录
            [self alertViewmessage:[resultDic objectForKey:@"msg"]];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 329){ //过期
            [InternetServices requestLoginPostForUsername:[self userInfoReaduserkey:@"userName"] password:[self userInfoReaduserkey:@"passWord"]];
            [self uploadRecordingDataAction];
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

//后台登陆
- (void)loginPostForUsername:(NSString *)username password:(NSString *)password {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    [manager.requestSerializer setValue:[self userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];
    NSDictionary *parameters = @{@"accounts":username,@"passwd":password,@"imei":[self keyChainIdentifierForVendorString]};
    [manager POST:RENEWAL_USER_DATA_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSMutableArray *userdataArray;
        NSString *encryptedData;
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        
        if ([[resultDic objectForKey:@"status"] integerValue] == 200 ) {
            
            NSString *currentUserstr =[[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser"];
            NSMutableArray *dataArray= [resultDic objectForKey:@"data"];
            if ([currentUserstr integerValue] >= dataArray.count) {
                currentUserstr = [NSString stringWithFormat:@"%lu",(unsigned long)dataArray.count - 1];
            }
            [self createAdatabaseAction];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(unsigned long)dataArray.count] forKey:@"userNumber"];// 存储 用户下小区的个数
            for (NSInteger i = 0; i <dataArray.count; i++) {
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)i] forKey:@"currentUser"]; // ／／存储 当前小区标识
                userdataArray = dataArray[i];
                encryptedData = [AESCrypt encrypt:[NSString stringWithFormat:@"%@",userdataArray[2]] password:AES_PASSWORD];  //加密
                [self userInfowriteuserkey:@"lanyaAESData" uservalue:encryptedData]; //存储  刷卡数据
                [self userInfowriteuserkey:@"userorakey" uservalue:[NSString stringWithFormat:@"%@",userdataArray[0]]];    //存储     推荐码
                [self userInfowriteuserkey:@"districtNumber" uservalue:[NSString stringWithFormat:@"%@",userdataArray[1]]];       //存储  小区号
                [self userInfowriteuserkey:@"districtName" uservalue:[NSString stringWithFormat:@"%@%@",userdataArray[3],userdataArray[4]]];       //存储  小区名称
                [self userInfowriteuserkey:@"role" uservalue:[NSString stringWithFormat:@"%@",userdataArray[6]]];       // 小区 管理员标识
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:currentUserstr forKey:@"currentUser"]; // 恢复之前存储
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 205){
            [InternetServices clearAllUserDefaultsData];
            [self createAdatabaseAction];
            NSMutableArray *dataArray= [resultDic objectForKey:@"data"];
            NSArray *dataTowArray =dataArray[0];
            [self userInfowriteuserkey:@"Token" uservalue:dataTowArray[0]];//存储 token
            [self userInfowriteuserkey:@"userName" uservalue:username];//存储 账号
            [self userInfowriteuserkey:@"passWord" uservalue:password];// 存储 密码//
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"userNumber"];// 存储 用户下小区的个数
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"loginInfo"];  //登录标识
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"currentUser"]; //登录后默认 为第一个
            
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 329) {      // Token  失效获取新的
            [InternetServices requestLoginPostForUsername:username password:password];
            
        } else {
            if([[resultDic objectForKey:@"status"] integerValue] != 203 && [[resultDic objectForKey:@"status"] integerValue] != 204  && [[resultDic objectForKey:@"status"] integerValue] != 100 ){
                [InternetServices logOutPOSTkeystr:username];//退出登录
            }
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
    // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    return manager;
}
//字符串转日期格式
- (NSDate *)stringToDate:(NSString *)dateString withDateFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return [self worldTimeToChinaTime:date];
}

//将世界时间转化为中国区时间
- (NSDate *)worldTimeToChinaTime:(NSDate *)date {
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    return localeDate;
}
@end
