//
//  RegisterViewController+LogicalFlow.h
//  claidApp
//
//  Created by kevinpc on 2016/11/1.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController (LogicalFlow)

- (void)registerPostForUsername:(NSString *)username password:(NSString *)password oraKey:(NSString *)orakey;

@end
