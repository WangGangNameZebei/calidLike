//
//  InstallCardData.h
//  claidApp
//
//  Created by kevinpc on 2016/12/26.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstallCardData : NSObject
@property (strong,nonatomic) NSString *installName;                 //实际名字
@property (strong,nonatomic) NSString *installNamePractical;         //备注名字
@property (strong, nonatomic) NSString *installData;                //刷卡数据
@property (assign, nonatomic) NSInteger identification;

+(instancetype)initinstallNamestr:(NSString *)installNamestr installData:(NSString *)installdata identification:(NSInteger )identification;

@end
