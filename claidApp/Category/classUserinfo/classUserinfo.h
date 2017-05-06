//
//  ClassUserInfo.h
//  claidApp
//
//  Created by kevinpc on 2017/5/4.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassUserInfo : NSObject

@property (strong, nonatomic) NSString *uniqueCodeStr;      // 小区的唯一吗
@property (strong, nonatomic) NSString *userNameStr;        //名称
@property (strong, nonatomic) NSString *validityStr;        //有效期
@property (strong, nonatomic) NSString *addressStr;         //楼层
@property (strong, nonatomic) NSString *telePhoneStr;       //电话
@property (strong, nonatomic) NSString *noteStr;            //备注
@property (strong, nonatomic) NSString *eqIdStr;            //地址


+(instancetype)classUserinfouniqueCodeStr:(NSString *)uniqueCodeStr userNameStr:(NSString *)userNameStr validityStr:(NSString *)validityStr addressStr:(NSString *)addressStr telePhoneStr:(NSString *)telePhoneStr noteStr:(NSString *)noteStr eqIdStr:(NSString *)eqIdStr;


@end
