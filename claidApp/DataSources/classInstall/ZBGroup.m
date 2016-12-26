//
//  ZBGroup.m
//  claidApp
//
//  Created by kevinpc on 2016/12/26.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "ZBGroup.h"

@implementation ZBGroup
//初始化方法
- (instancetype) initWithItem:(NSMutableArray *)item{
    if (self = [super init]) {
        self.folded=YES;
        _items = item;
    }
    return self;
}

//每个组内有多少联系人
- (NSUInteger) size {
    return _items.count;
}

@end
