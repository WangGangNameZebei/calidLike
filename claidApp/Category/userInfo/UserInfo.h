//
//  UserInfo.h
//  claidApp
//
//  Created by kevinpc on 2017/6/30.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
@property (assign, nonatomic) NSString *userkey;            //用户对象
@property (strong, nonatomic) NSString *userValue;         //用户对象信息

+(instancetype)initUserkeystr:(NSString *)userkeystr uservaluestr:(NSString *)uservaluestr;

@end
