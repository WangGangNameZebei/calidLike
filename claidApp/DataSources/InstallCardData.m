//
//  InstallCardData.m
//  claidApp
//
//  Created by kevinpc on 2016/12/26.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "InstallCardData.h"

@implementation InstallCardData

+(instancetype)initinstallNamestr:(NSString *)installNamestr installData:(NSString *)installdata {
    InstallCardData *installCardData = [[InstallCardData alloc] init];
    installCardData.installName = installNamestr;
    installCardData.installData = installdata;
    return installCardData;
}

@end
