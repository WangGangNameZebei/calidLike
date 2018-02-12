//
//  ViewRepairViewController+LogicalFow.m
//  claidApp
//
//  Created by Zebei on 2017/12/23.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "ViewRepairViewController+LogicalFow.h"
#import <AFHTTPRequestOperationManager.h>
#import "InternetServices.h"

@implementation ViewRepairViewController (LogicalFow)
- (void)getDataPostpptRepairsByConditinorepairsPPTstatus:(NSInteger)statusString pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    [manager.requestSerializer setValue:[self userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];
    NSDictionary *parameters = @{@"accounts":[self userInfoReaduserkey:@"userName"], @"ppt_cell_id":[self userInfoReaduserkey:@"districtNumber"],@"repairs_ppt_status":    @(statusString),@"pageNum":@(pageNum),@"pageSize":@(pageSize)};
    [manager POST:ADMIN_REVIEW_REPAIR_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        
        if ([[resultDic objectForKey:@"status"] integerValue] == 200) {
            if (self.mjBool) {
                switch (self.pageMenu.selectedItemIndex) {
                    case 0:
                        [self.layoutsOneArr removeAllObjects];
                        break;
                    case 1:
                        [self.layoutsTowArr removeAllObjects];
                        break;
                    case 2:
                        [self.layoutsThreeArr removeAllObjects];
                        break;
                    case 3:
                        [self.layoutsFourArr removeAllObjects];
                        break;
                    default:
                        [self.layoutsFiveArr removeAllObjects];
                        break;
                }
            }
            [self returnRefreshData:resultDic];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 205) {
            [self.layouts removeAllObjects];
            [self.viewRepairTableView reloadData];
             [self.viewRepairTableView showEmptyViewWithType:NoContentTypeOrder];
            [self.indicator stopAnimating];
            if (self.mjBool){
                [self.viewRepairTableView.mj_header endRefreshing];
            } else {
                [self.viewRepairTableView.mj_footer endRefreshing];
            }
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 329){
            [InternetServices requestLoginPostForUsername:[self userInfoReaduserkey:@"userName"] password:[self userInfoReaduserkey:@"passWord"]];
            [self getDataPostpptRepairsByConditinorepairsPPTstatus:statusString pageNum:pageNum pageSize:pageSize];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 296 ||[[resultDic objectForKey:@"status"] integerValue] == 301 || [[resultDic objectForKey:@"status"] integerValue] == 328 || [[resultDic objectForKey:@"status"] integerValue] == 330){
            [self.indicator stopAnimating];
            if (self.mjBool){
                [self.viewRepairTableView.mj_header endRefreshing];
            } else {
                [self.viewRepairTableView.mj_footer endRefreshing];
            }
            [InternetServices logOutPOSTkeystr:[self userInfoReaduserkey:@"userName"]]; //退出登录
            [self alertViewmessage:[resultDic objectForKey:@"msg"]];
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 342){   //小区 管理员失效
            [self userInfowriteuserkey:@"role" uservalue:@"0"];       // 小区 管理员标识
            [self alertViewmessage:[resultDic objectForKey:@"msg"]];
            [self.indicator stopAnimating];
            if (self.mjBool){
                [self.viewRepairTableView.mj_header endRefreshing];
            } else {
                [self.viewRepairTableView.mj_footer endRefreshing];
            }
        }  else {
            [self alertViewmessage:[resultDic objectForKey:@"msg"]];
            [self.indicator stopAnimating];
             [self.viewRepairTableView showEmptyViewWithType:NoContentTypeNetwork];
            if (self.mjBool){
                [self.viewRepairTableView.mj_header endRefreshing];
            } else {
                [self.viewRepairTableView.mj_footer endRefreshing];
            }
        }

        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (error.code == -1009){
            [self promptInformationActionWarningString:@"您的网络有异常"];
        } else {
            [self promptInformationActionWarningString:[NSString stringWithFormat:@"%ld",(long)error.code]];
        }
        [self.layouts removeAllObjects];
        [self.viewRepairTableView showEmptyViewWithType:NoContentTypeNetwork];
        [self.indicator stopAnimating];
        [self mjreloadDataTableViewAction];
    }];
}

// 处理  报修
- (void)getDataPostPropertyOperationsSubmittedid:(NSString *)dataid repairsStatus:(NSInteger)repairsStatus {
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    [manager.requestSerializer setValue:[self userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];

    NSDictionary *parameters = @{@"id":dataid, @"ppt_cell_id":[self userInfoReaduserkey:@"districtNumber"],@"repairs_ppt_status":    @(repairsStatus)};
    [manager POST:ADMIN_TO_HANDLE_REPAIR_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析 
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
        
        [self alertViewmessage:[resultDic objectForKey:@"msg"]];

        

        
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
    self.dataNextPageArr[self.pageMenu.selectedItemIndex] =@(dataNumber);
    dataNumber = [[resultDic objectForKey:@"pageNum"] integerValue];
    self.dataPageArr[self.pageMenu.selectedItemIndex] =@(dataNumber);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (int i = 0; i < resultDataArr.count; i ++) {
             NSMutableArray *dataArray = [NSMutableArray array];
             NSDictionary *resultDataDic = resultDataArr[i];
            NSString *strimage=[resultDataDic objectForKey:@"repairs_pictrue_path"];
            NSString *thumbnailimage=[resultDataDic objectForKey:@"repairs_thumbnai_pictrue_path"];
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
            NSString *desc = [resultDataDic objectForKey:@"repairs_content"];
            ViewRepairModel *model = [[ViewRepairModel alloc] init];
            model.imageDataArray = dataArray;
            model.describe = desc;
            model.idtextString = [NSString stringWithFormat:@"%@",[resultDataDic objectForKey:@"id"]];
            model.nameString = [resultDataDic objectForKey:@"name"];
            model.timebe = [NSString stringWithFormat:@"  %@  \n  %@  ",[[resultDataDic objectForKey:@"repairs_time"] substringWithRange:NSMakeRange(2, 8)],[[resultDataDic objectForKey:@"repairs_time"] substringWithRange:NSMakeRange(11, 8)]];
            model.phoneNumberbe = [resultDataDic objectForKey:@"accounts"];
            if ([[resultDataDic objectForKey:@"repairs_ppt_status"] integerValue] == 1){
               model.buttonTextbe = @"处理";
            } else if ([[resultDataDic objectForKey:@"repairs_ppt_status"] integerValue] == 2){
                model.buttonTextbe = @"完成";
            } else if ([[resultDataDic objectForKey:@"repairs_ppt_status"] integerValue] == 3) {
                 model.buttonTextbe = @"已拒绝";
            } else if ([[resultDataDic objectForKey:@"repairs_ppt_status"] integerValue] == 4) {
                model.buttonTextbe = @"已删除";
            } else { 
                model.buttonTextbe = @"已完成";
            }
            ViewRepairLayout *layout = [[ViewRepairLayout alloc] initWithDSDemoMode:model];
            if (self.pageMenu.selectedItemIndex == 0){
                 [self.layoutsOneArr addObject:layout];
            } else if (self.pageMenu.selectedItemIndex == 1) {
                 [self.layoutsTowArr addObject:layout];
            } else if (self.pageMenu.selectedItemIndex == 2) {
                 [self.layoutsThreeArr addObject:layout];
            } else if (self.pageMenu.selectedItemIndex == 3) {
                 [self.layoutsFourArr addObject:layout];
            } else {
                  [self.layoutsFiveArr addObject:layout];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicator stopAnimating];
            if (self.pageMenu.selectedItemIndex == 0){
                self.layouts = self.layoutsOneArr;
            } else if (self.pageMenu.selectedItemIndex == 1) {
                self.layouts = self.layoutsTowArr;
            } else if (self.pageMenu.selectedItemIndex == 2) {
                self.layouts = self.layoutsThreeArr;
            } else if (self.pageMenu.selectedItemIndex == 3) {
                self.layouts = self.layoutsFourArr;
            } else {
                self.layouts = self.layoutsFiveArr;
            }
            if (self.layouts.count == 0){
                [self.viewRepairTableView showEmptyViewWithType:NoContentTypeOrder];
            } else {
                [self.viewRepairTableView removeEmptyView];
            }
            [self mjreloadDataTableViewAction];
        });
    });
}
// 刷新Tableview
- (void)mjreloadDataTableViewAction {
        [self.viewRepairTableView reloadData];
        if (self.mjBool){
            [self.viewRepairTableView.mj_header endRefreshing];
        } else {
           [self.viewRepairTableView.mj_footer endRefreshing];
        }
        
}
@end
