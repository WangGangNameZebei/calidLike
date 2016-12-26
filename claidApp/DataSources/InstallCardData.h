//
//  InstallCardData.h
//  claidApp
//
//  Created by kevinpc on 2016/12/26.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstallCardData : NSObject
@property (strong,nonatomic) NSString *installName;
@property (strong, nonatomic) NSString *installData;

+(instancetype)initinstallNamestr:(NSString *)installNamestr installData:(NSString *)installdata;

@end
