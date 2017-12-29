//
//  AnnouncementViewController+LogicalFlow.m
//  claidApp
//
//  Created by Zebei on 2017/12/16.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "AnnouncementViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>


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
            NSLog(@"-----------  %@",resultDic);
            [self returnRefreshData:resultDic];
        } else {
             [self.indicator stopAnimating];
             [self mjreloadDataTableViewAction];
        }
        
         NSLog(@"-----=====--  %@",[resultDic objectForKey:@"msg"]);
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
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
            if (![strimage isKindOfClass:[NSNull class]] && strimage.length > 8){
            NSArray *temp=[strimage componentsSeparatedByString:@","];
           
             for (int j = 0; j < temp.count; j++) {
               NSString *thumbnail =[NSString stringWithFormat:@"http://sycalid.cn//%@",temp[j]];
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
            model.timebe = [NSString stringWithFormat:@"  %@  \n  %@  ",[[resultDataDic objectForKey:@"publish_time"] substringWithRange:NSMakeRange(2, 8)],[[resultDataDic objectForKey:@"publish_time"] substringWithRange:NSMakeRange(11, 8)]];
            model.titlebe = [resultDataDic objectForKey:@"notification_title"];
            DSDemoLayout *layout = [[DSDemoLayout alloc] initWithDSDemoMode:model];
            [self.layouts addObject:layout];
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
    //这里假设2秒之后获取到了更多的数据，刷新tableview，并且结束刷新控件的刷新状态
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.announcementTableView reloadData];
        if (self.mjBool){
             [weakSelf.announcementTableView.mj_header endRefreshing];
        } else {
             [weakSelf.announcementTableView.mj_footer endRefreshing];
        }
        
    });
}
@end
