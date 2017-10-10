//
//  PropertyActivationViewController+LogicalFlow.h
//  claidApp
//
//  Created by kevinpc on 2017/5/31.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "PropertyActivationViewController.h"

@interface PropertyActivationViewController (LogicalFlow)


- (void)propertyActivationPostForUserData:(NSString *)userData userInfo:(NSString *)userInfo userEqInfo:(NSString *)userEqInfo userPhone:(NSString *)userPhone;  //  上传数据

- (void)checkStatusOfCardPOSTdataStr:(NSString *)dataStr;       //效验发卡器
- (void)districtInfoPOSTNameStr:(NSString *)nameStr dataStr:(NSString *)dataStr;        //园区信息提交
@end
