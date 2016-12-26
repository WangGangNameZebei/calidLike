//
//  ZBGroup.h
//  claidApp
//
//  Created by kevinpc on 2016/12/26.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBGroup : NSObject
//联系人数据
@property(nonatomic,strong)NSMutableArray *items;
//大小(分组中有多少项)
@property (nonatomic, readonly) NSUInteger size;
//是否折叠
@property (nonatomic, assign, getter=isFolded) BOOL folded;

//初始化方法
- (instancetype) initWithItem:(NSMutableArray *)item;
@end
