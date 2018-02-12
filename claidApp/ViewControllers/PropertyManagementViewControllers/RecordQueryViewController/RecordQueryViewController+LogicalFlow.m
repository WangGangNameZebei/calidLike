//
//  RecordQueryViewController+LogicalFlow.m
//  claidApp
//
//  Created by Zebei on 2018/1/2.
//  Copyright © 2018年 kevinpc. All rights reserved.
//

#import "RecordQueryViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>
#import "InternetServices.h"

@implementation RecordQueryViewController (LogicalFlow)


- (void)getPOSTConditionRecordQuerypageNum:(NSInteger)pageNum accounts:(NSString *)accounts swipingTime:(NSString *)swipingTime swipingEndTime:(NSString *)swipingEndTime swipingStatus:(NSString *)swipingStatus swipingAddress:(NSString *)swipingAddress {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    [manager.requestSerializer setValue:[self userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];
  NSDictionary *parameters = @{@"ppt_cell_id":[self userInfoReaduserkey:@"districtNumber"],@"pageNum":@(pageNum),@"accounts":accounts,@"swiping_time":swipingTime,@"swiping_end_time":swipingEndTime,@"swiping_status":swipingStatus,@"swiping_address":swipingAddress};
    
    [manager POST:ADMIN_RECORD_QUERY_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"status"] integerValue] == 200) {
            self.pageNum = pageNum;
             self.hasNextPage =[[resultDic objectForKey:@"hasNextPage"] integerValue];
            if (self.mjBool){
                [self.rqDataArrar removeAllObjects];
                self.rqDataArrar = [resultDic objectForKey:@"data"];
                self.recordQueryViewControllerDataSource.myDataArray = self.rqDataArrar;
                if (self.rqDataArrar.count == 0){
                    [self.recordQueryTableView showEmptyViewWithType:NoContentTypeOrder];
                } else {
                    [self.recordQueryTableView removeEmptyView];
                }
                [self.recordQueryTableView reloadData];
            } else {
                NSMutableArray * newDataArr = [NSMutableArray new];
                NSDictionary *newDataDic;
                newDataArr =[resultDic objectForKey:@"data"];
                for (NSInteger i = 0; i < newDataArr.count; i++) {
                     newDataDic =newDataArr[i];
                     [self.rqDataArrar addObject:newDataDic];
                }
                self.recordQueryViewControllerDataSource.myDataArray = self.rqDataArrar;
                if (self.rqDataArrar.count == 0){
                    [self.recordQueryTableView showEmptyViewWithType:NoContentTypeOrder];
                } else {
                    [self.recordQueryTableView removeEmptyView];
                }
                
                [self.recordQueryTableView reloadData];
                
            }
             [self.indicator stopAnimating];
         
            
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 205){   //无符合的数据
            [self.rqDataArrar removeAllObjects];
            self.recordQueryViewControllerDataSource.myDataArray = self.rqDataArrar;
            [self.recordQueryTableView showEmptyViewWithType:NoContentTypeOrder];
            [self.indicator stopAnimating];
            [self.recordQueryTableView reloadData];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 329){
            [InternetServices requestLoginPostForUsername:[self userInfoReaduserkey:@"userName"] password:[self userInfoReaduserkey:@"passWord"]];
            [self getPOSTConditionRecordQuerypageNum:pageNum accounts:accounts swipingTime:swipingTime swipingEndTime:swipingEndTime swipingStatus:swipingStatus swipingAddress:swipingAddress];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 296 ||[[resultDic objectForKey:@"status"] integerValue] == 301 || [[resultDic objectForKey:@"status"] integerValue] == 328 || [[resultDic objectForKey:@"status"] integerValue] == 330){
            [InternetServices logOutPOSTkeystr:[self userInfoReaduserkey:@"userName"]]; //退出登录
            [self.indicator stopAnimating];
      
            [self alertViewmessage:[resultDic objectForKey:@"msg"]];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 342){   //小区 管理员失效
            [self userInfowriteuserkey:@"role" uservalue:@"0"];       // 小区 管理员标识
            [self.indicator stopAnimating];
            [self.recordQueryTableView reloadData];
        }  else {
            [self alertViewmessage:[resultDic objectForKey:@"msg"]];
            [self.rqDataArrar removeAllObjects];
            self.recordQueryViewControllerDataSource.myDataArray = self.rqDataArrar;
            [self.recordQueryTableView showEmptyViewWithType:NoContentTypeNetwork];
            [self.indicator stopAnimating];
            [self.recordQueryTableView reloadData];
        }
        
        if (self.mjBool){
            [self.recordQueryTableView.mj_header endRefreshing];
        } else {
            [self.recordQueryTableView.mj_footer endRefreshing];
        }
       
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [self.rqDataArrar removeAllObjects];
        self.recordQueryViewControllerDataSource.myDataArray = self.rqDataArrar;
        [self.recordQueryTableView showEmptyViewWithType:NoContentTypeNetwork];
        [self.indicator stopAnimating];
        [self.recordQueryTableView reloadData];
        if (self.mjBool){
            [self.recordQueryTableView.mj_header endRefreshing];
        } else {
            [self.recordQueryTableView.mj_footer endRefreshing];
        }
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
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    return manager;
}

@end
