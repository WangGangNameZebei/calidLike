//
//  ViewRepairViewController+LogicalFow.h
//  claidApp
//
//  Created by Zebei on 2017/12/23.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "ViewRepairViewController.h"

@interface ViewRepairViewController (LogicalFow)

- (void)getDataPostpptRepairsByConditinorepairsPPTstatus:(NSInteger)statusString pageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize;  //获取报修
- (void)getDataPostPropertyOperationsSubmittedid:(NSString *)dataid repairsStatus:(NSInteger)repairsStatus;     //处理报修

@end
