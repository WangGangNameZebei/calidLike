//
//  ClassUserInfo.m
//  claidApp
//
//  Created by kevinpc on 2017/5/4.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "ClassUserInfo.h"

@implementation ClassUserInfo

+(instancetype)classUserinfouniqueCodeStr:(NSString *)uniqueCodeStr userNameStr:(NSString *)userNameStr validityStr:(NSString *)validityStr addressStr:(NSString *)addressStr telePhoneStr:(NSString *)telePhoneStr noteStr:(NSString *)noteStr eqIdStr:(NSString *)eqIdStr {
    ClassUserInfo *classUserinfo = [[ClassUserInfo alloc] init];
    classUserinfo.uniqueCodeStr = uniqueCodeStr;
    classUserinfo.userNameStr = userNameStr;
    classUserinfo.validityStr = validityStr;
    classUserinfo.addressStr = addressStr;
    classUserinfo.telePhoneStr = telePhoneStr;
    classUserinfo.noteStr = noteStr;
    classUserinfo.eqIdStr = eqIdStr;
    return  classUserinfo;
}

@end
