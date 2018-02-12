//
//  AnnouncementViewController+LogicalFlow.m
//  claidApp
//
//  Created by Zebei on 2017/12/16.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "AnnouncementViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>
#import "InternetServices.h"

@implementation AnnouncementViewController (LogicalFlow)

- (void)announcementsetPOSTDataAction:(NSInteger)pageNum{
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    [manager.requestSerializer setValue:[self userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];
    NSDictionary *parameters = @{@"ppt_cell_id":[self userInfoReaduserkey:@"districtNumber"],@"pageNum":@(pageNum),@"pageSize":@(10)};
    [manager POST:PROPERTY_ANNOUNCEMENT_INQUIRIES_MOST_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        
        if ([[resultDic objectForKey:@"status"] integerValue] == 200) {
             self.pageNum = pageNum;
            self.hasNextPage =[[resultDic objectForKey:@"hasNextPage"] integerValue];
            if (self.mjBool){
                [self.layouts removeAllObjects];
            }
            [self returnRefreshData:resultDic];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 205){
            [self alertViewmessage:[resultDic objectForKey:@"msg"]];
            [self.layouts removeAllObjects];
            [self.indicator stopAnimating];
            [self.announcementTableView showEmptyViewWithType:NoContentTypeOrder];
            [self mjreloadDataTableViewAction];
        }else if ([[resultDic objectForKey:@"status"] integerValue] == 329){
            [InternetServices requestLoginPostForUsername:[self userInfoReaduserkey:@"userName"] password:[self userInfoReaduserkey:@"passWord"]];
            [self announcementsetPOSTDataAction:pageNum];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 296 ||[[resultDic objectForKey:@"status"] integerValue] == 301 || [[resultDic objectForKey:@"status"] integerValue] == 328 || [[resultDic objectForKey:@"status"] integerValue] == 330){
            [self.indicator stopAnimating];
            [self mjreloadDataTableViewAction];
            [InternetServices logOutPOSTkeystr:[self userInfoReaduserkey:@"userName"]]; //退出登录
            [self alertViewmessage:[resultDic objectForKey:@"msg"]];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 342){   //小区 管理员失效
            [self userInfowriteuserkey:@"role" uservalue:@"0"];       // 小区 管理员标识
            [self alertViewmessage:[resultDic objectForKey:@"msg"]];
            [self.layouts removeAllObjects];
            [self.indicator stopAnimating];
            [self.announcementTableView showEmptyViewWithType:NoContentTypeNetwork];
            [self mjreloadDataTableViewAction];
        } else {
            [self.indicator stopAnimating];
            [self mjreloadDataTableViewAction];
        }
        
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [self.layouts removeAllObjects];
        [self.indicator stopAnimating];
        [self.announcementTableView showEmptyViewWithType:NoContentTypeNetwork];
        [self mjreloadDataTableViewAction];
        if (error.code == -1009){
            [self promptInformationActionWarningString:@"您的网络有异常"];
        } else {
            [self promptInformationActionWarningString:[NSString stringWithFormat:@"%ld",(long)error.code]];
        }
        
    }];
}

- (void)returnRefreshData:(NSDictionary *)resultDic {
    NSMutableArray *resultDataArr =[resultDic objectForKey:@"data"];

  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (int i = 0; i < resultDataArr.count; i ++) {
            NSMutableArray *dataArray = [NSMutableArray array];
            NSDictionary * resultDataDic =resultDataArr[i];
            NSString *strimage=[resultDataDic objectForKey:@"notification_pictrue_path"];
            NSString *thumbnailimage=[resultDataDic objectForKey:@"notification_thumbnail_pictrue_path"];
            if (![strimage isKindOfClass:[NSNull class]] && strimage.length > 8){
            NSArray *temp=[strimage componentsSeparatedByString:@","];
            NSArray *thumbnailtemp=[thumbnailimage componentsSeparatedByString:@"@"];
             for (int j = 0; j < temp.count; j++) {
               NSString *thumbnail =[NSString stringWithFormat:@"http://sycalid.cn//%@",thumbnailtemp[j]];
               NSString *large = [NSString stringWithFormat:@"http://sycalid.cn//%@",temp[j]];
                DSImagesData *imagesData =[[DSImagesData alloc] init];
                imagesData.thumbnailImage.width = 750;
                imagesData.thumbnailImage.height = 500;
                imagesData.thumbnailImage.url = [NSURL URLWithString:thumbnail];
                imagesData.largeImage.width = 750;
                imagesData.largeImage.height = 500;
                imagesData.largeImage.url = [NSURL URLWithString:large];
                [dataArray addObject:imagesData];
              }
                
            }
            NSString *desc = [resultDataDic objectForKey:@"notification_content"];
            DSDemoModel *model = [[DSDemoModel alloc] init];
            model.imageDataArray = dataArray;
            model.describe = desc;
            model.timebe = [NSString stringWithFormat:@"%@\n%@",[[resultDataDic objectForKey:@"publish_time"] substringWithRange:NSMakeRange(2, 8)],[[resultDataDic objectForKey:@"publish_time"] substringWithRange:NSMakeRange(11, 8)]];
            model.titlebe = [resultDataDic objectForKey:@"notification_title"];
            DSDemoLayout *layout = [[DSDemoLayout alloc] initWithDSDemoMode:model];
            [self.layouts addObject:layout];
        }      
      
        if (self.layouts.count == 0){
           [self.announcementTableView showEmptyViewWithType:NoContentTypeOrder];
        } else {
            [self.announcementTableView removeEmptyView];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicator stopAnimating];
            [self mjreloadDataTableViewAction];
        });
    });
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
// 刷新Tableview
- (void)mjreloadDataTableViewAction {
        [self.announcementTableView reloadData];
        if (self.mjBool){
             [self.announcementTableView.mj_header endRefreshing];
        } else {
             [self.announcementTableView.mj_footer endRefreshing];
        }

}
@end
