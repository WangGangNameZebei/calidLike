//
//  VisitorViewController+LogicalFlow.m
//  claidApp
//
//  Created by kevinpc on 2017/1/16.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "VisitorViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>

@implementation VisitorViewController (LogicalFlow)

- (void)visitorPostForPhoneNumber:(NSString *)phoneNumber {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    NSDictionary *parameters = @{@"tourist_phone":phoneNumber};
    [manager POST:VISITOR_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 200) {
            [self dataAnalysisActiondata:resultDic];            
           
        } else {
            [self alertViewmessage:[resultDic objectForKey:@"msg"]];
        }
        self.requestBool = YES;
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (error.code == -1009){
            [self promptInformationActionWarningString:@"您的网络有异常"];
        } else {
            [self promptInformationActionWarningString:[NSString stringWithFormat:@"%ld",(long)error.code]];
        }

        self.requestBool =YES;
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

//数据解析
- (void)dataAnalysisActiondata:(NSDictionary *)returndataDic {
    self.visitorTextField.text = @"";
    NSMutableArray *dataArray = [returndataDic objectForKey:@"data"];
    if(dataArray.count ==0){
        [self promptInformationActionWarningString:@"暂无可用的权限"];
        return;
    } else {
        [self createAdatabaseAction];
        [self promptInformationActionWarningString:[NSString stringWithFormat:@"您有%lu个权限,请点+号进行选择",(unsigned long)dataArray.count]];
    }
    self.tool = [DBTool sharedDBTool];
    NSArray *data = [self.tool selectWithClass:[VisitorCalss class] params:nil];
    if (data.count == 0){
        [self.tool createTableWithClass:[VisitorCalss class]];
    }
    for (NSInteger i=0; i < dataArray.count; i++) {
        self.readBool = YES;
        self.dataArray = [dataArray objectAtIndex:i];
       
        self.visitorClassData = [VisitorCalss assignmentVisitorName:[self.dataArray[2] integerValue] visitorRemarks:self.dataArray[0] visitorData:self.dataArray[1]];
      self.readDataArr = [self.tool selectWithClass:[VisitorCalss class] params:nil];
        for (NSInteger j=0; j <self.readDataArr.count; j++) {
            self.viReadClass = self.readDataArr[j];
            if (self.viReadClass.visitorName == self.visitorClassData.visitorName){
                self.readBool = NO;
             }
        }
        if (self.readBool) {
            [self.tool insertWithObj:self.visitorClassData];
            self.visitorViewControllerDataSource.beizhuNameArray = [self.tool selectWithClass:[VisitorCalss class] params:nil];
            [self.visitorTableView reloadData];  //刷新 蓝牙选择
        }
        
        
    }
   
}

@end
