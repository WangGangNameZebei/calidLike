//
//  UserInfo.m
//  claidApp
//
//  Created by kevinpc on 2017/6/30.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
+(instancetype)initUserkeystr:(NSString *)userkeystr uservaluestr:(NSString *)uservaluestr {
    UserInfo *userIF = [[UserInfo alloc] init];
    userIF.userkey = userkeystr;
    userIF.userValue = uservaluestr;
    return userIF;
}
@end
