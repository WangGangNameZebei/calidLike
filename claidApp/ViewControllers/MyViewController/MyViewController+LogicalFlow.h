//
//  MyViewController+LogicalFlow.h
//  claidApp
//
//  Created by kevinpc on 2016/10/24.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController (LogicalFlow)
- (void)theinternetCardupData;     //数据更新
- (void)logOutPOSTkeystr:(NSString *)keyStr;        //退出登录 
@end
