//
//  MycradInfoViewController+LogicalFlow.h
//  claidApp
//
//  Created by Zebei on 2018/2/1.
//  Copyright © 2018年 kevinpc. All rights reserved.
//

#import "MycradInfoViewController.h"

@interface MycradInfoViewController (LogicalFlow)
- (void)getPOSTuserInfoAction;  // 获取用户个人信息
- (void)uploadPOSTuserInfoActionUserNameString:(NSString *)userNameString; // 上传用户个人信息
@end
