//
//  UserRepairQueryViewController+LogicalFlow.m
//  claidApp
//
//  Created by Zebei on 2017/12/27.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "UserRepairQueryViewController+LogicalFlow.h"
#import <AFHTTPRequestOperationManager.h>

@implementation UserRepairQueryViewController (LogicalFlow)

- (void)setuserRepairQueryPostDataStatus:(NSInteger)userstatus pageNum:(NSInteger)pageNum {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    [manager.requestSerializer setValue:[self userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];
    NSDictionary *parameters = @{@"accounts":[self userInfoReaduserkey:@"userName"], @"ppt_cell_id":[self userInfoReaduserkey:@"districtNumber"],@"repairs_user_status":    @(userstatus),@"pageNum":@(pageNum),@"pageSize":@(10)};
    [manager POST:USER_REPAIR_QUERY_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        
        if ([[resultDic objectForKey:@"status"] integerValue] == 200) {
            if (self.mjBool) {
                switch (self.userpageMenu.selectedItemIndex) {
                    case 0:
                        [self.layoutsOneArr removeAllObjects];
                        break;
                    case 1:
                        [self.layoutsTowArr removeAllObjects];
                        break;
                    case 2:
                        [self.layoutsThreeArr removeAllObjects];
                        break;
                    default:
                        [self.layoutsFourArr removeAllObjects];
                        break;
                }
            }
            NSLog(@"=========hgsuysu---%@",resultDic);
            [self returnRefreshData:resultDic];
        }  else if ([[resultDic objectForKey:@"status"] integerValue] == 205) {
            [self.layouts removeAllObjects];
            [self.userRepairQueryTableView reloadData];
            [self.indicator stopAnimating];
            if (self.mjBool){
                [self.userRepairQueryTableView.mj_header endRefreshing];
            } else {
                [self.userRepairQueryTableView.mj_footer endRefreshing];
            }
        } else {
            [self.layouts removeAllObjects];
            [self.userRepairQueryTableView reloadData];
             [self.indicator stopAnimating];
            if (self.mjBool){
                [self.userRepairQueryTableView.mj_header endRefreshing];
            } else {
                [self.userRepairQueryTableView.mj_footer endRefreshing];
            }
        }
        
        NSLog(@"-----=====--  %@=======%@",[resultDic objectForKey:@"msg"],[resultDic objectForKey:@"status"]);
        
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
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    return manager;
}

- (void)returnRefreshData:(NSDictionary *)resultDic {
    NSMutableArray * resultDataArr =[resultDic objectForKey:@"data"];
    NSInteger dataNumber = [[resultDic objectForKey:@"hasNextPage"] integerValue];
    self.dataNextPageArr[self.userpageMenu.selectedItemIndex] =@(dataNumber);
    dataNumber = [[resultDic objectForKey:@"pageNum"] integerValue];
    self.dataPageArr[self.userpageMenu.selectedItemIndex] =@(dataNumber);
    NSLog(@"====================%@---2---%@-----",self.dataNextPageArr,self.dataPageArr);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (int i = 0; i < resultDataArr.count; i ++) {
            NSMutableArray *dataArray = [NSMutableArray array];
            NSDictionary *resultDataDic = resultDataArr[i];
            NSString *strimage=[resultDataDic objectForKey:@"repairs_pictrue_path"];
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
            NSString *desc = [resultDataDic objectForKey:@"repairs_content"];
            ViewRepairModel *model = [[ViewRepairModel alloc] init];
            model.imageDataArray = dataArray;
            model.describe = desc;
            model.idtextString = [NSString stringWithFormat:@"%@",[resultDataDic objectForKey:@"id"]];
            model.timebe = [NSString stringWithFormat:@"%@",[resultDataDic objectForKey:@"repairs_time"]];
            
            model.phoneNumberbe = [resultDataDic objectForKey:@"accounts"];
            if ([[resultDataDic objectForKey:@"repairs_ppt_status"] integerValue] == 1){
                model.buttonTextbe = @"待处理";
            } else if ([[resultDataDic objectForKey:@"repairs_ppt_status"] integerValue] == 2){
                model.buttonTextbe = @"处理中";
            } else if ([[resultDataDic objectForKey:@"repairs_ppt_status"] integerValue] == 3) {
                model.buttonTextbe = @"已拒绝";
            } else if ([[resultDataDic objectForKey:@"repairs_ppt_status"] integerValue] == 4) {
                model.buttonTextbe = @"已删除";
            } else {
                model.buttonTextbe = @"已完成";
            }
            
            UserRepairQueryLayout *layout = [[UserRepairQueryLayout alloc] initWithDSDemoMode:model];
            if (self.userpageMenu.selectedItemIndex == 0){
                [self.layoutsOneArr addObject:layout];
            } else if (self.userpageMenu.selectedItemIndex == 1) {
                [self.layoutsTowArr addObject:layout];
            } else if (self.userpageMenu.selectedItemIndex == 2) {
                [self.layoutsThreeArr addObject:layout];
            } else  {
                [self.layoutsFourArr addObject:layout];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicator stopAnimating];
            if (self.userpageMenu.selectedItemIndex == 0){
                self.layouts = self.layoutsOneArr;
            } else if (self.userpageMenu.selectedItemIndex == 1) {
                self.layouts = self.layoutsTowArr;
            } else if (self.userpageMenu.selectedItemIndex == 2) {
                self.layouts = self.layoutsThreeArr;
            } else {
                self.layouts = self.layoutsFourArr;
            }
            [self mjreloadDataTableViewAction];
        });
    });
}
// 刷新Tableview
- (void)mjreloadDataTableViewAction {
    //这里假设2秒之后获取到了更多的数据，刷新tableview，并且结束刷新控件的刷新状态
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.userRepairQueryTableView reloadData];
        [weakSelf.userRepairQueryTableView.mj_header endRefreshing];
        [weakSelf.userRepairQueryTableView.mj_footer endRefreshing];
        
    });
}

@end
