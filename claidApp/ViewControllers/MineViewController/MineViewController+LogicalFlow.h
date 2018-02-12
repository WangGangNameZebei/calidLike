//
//  MineViewController+LogicalFlow.h
//  claidApp
//
//  Created by kevinpc on 2016/10/19.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController (LogicalFlow)
- (void)loginPostForUsername:(NSString *)username password:(NSString *)password;   //后台登陆
@end
