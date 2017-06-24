//
//  ChangeThePasswordViewController+LogicalFlow.h
//  claidApp
//
//  Created by kevinpc on 2017/6/24.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "ChangeThePasswordViewController.h"

@interface ChangeThePasswordViewController (LogicalFlow)

- (void)changeThePasswordPOSTForoldpasssword:(NSString *)oldpassword newpassword:(NSString *)newpassword;       // 修改 密码  接口

@end
