//
//  PropertyActivationViewController+LogicalFlow.h
//  claidApp
//
//  Created by kevinpc on 2017/5/31.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "PropertyActivationViewController.h"

@interface PropertyActivationViewController (LogicalFlow)
- (void)propertyActivationPostForUserData:(NSString *)userData userInfo:(NSString *)userInfo userEqInfo:(NSString *)userEqInfo userPhone:(NSString *)userPhone password:(NSString *)password;  //  上传数据
- (void)theinternetCardupData;      //更新数据
@end
