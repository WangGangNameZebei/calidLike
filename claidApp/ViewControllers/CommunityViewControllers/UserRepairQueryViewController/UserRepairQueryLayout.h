//
//  UserRepairQueryLayout.h
//  claidApp
//
//  Created by Zebei on 2017/12/27.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewRepairModel.h"
#import "DSImageLayout.h"

@interface UserRepairQueryLayout : NSObject
- (instancetype)initWithDSDemoMode:(ViewRepairModel *)model;

@property (nonatomic, strong) ViewRepairModel *model;
@property (nonatomic, strong) DSImageLayout *imageLayout;
@property (nonatomic, assign) CGFloat descHeight;
@property (nonatomic, assign) CGFloat cellHeight;

@end
