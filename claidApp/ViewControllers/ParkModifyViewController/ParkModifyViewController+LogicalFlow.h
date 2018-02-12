//
//  ParkModifyViewController+LogicalFlow.h
//  claidApp
//
//  Created by kevinpc on 2017/9/15.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "ParkModifyViewController.h"

@interface ParkModifyViewController (LogicalFlow)
- (void)getpostInfoAction; // 获取信息
- (void)districtInfoPOSTNameStr:(NSString *)nameStr dataStr:(NSString *)dataStr propertyName:(NSString *)propertyName propertyPhone:(NSString *)propertyPhone;
@end
