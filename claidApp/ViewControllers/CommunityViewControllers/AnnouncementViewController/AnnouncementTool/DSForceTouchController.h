//
//  DSForceTouchController
//  DSImageBrowse
//
//  Created by Zebei on 2017/8/14.
//  Copyright © 2017年 Zebei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSImageScrollItem.h"
#import "DSImageScrollView.h"

@interface DSForceTouchController : UIViewController

//预览图片视图
@property (nonatomic, strong) YYAnimatedImageView *imageView;
//预览图片数据
@property (nonatomic, strong) DSImageScrollItem *item;
//预览图片Rect
@property (nonatomic, assign) CGRect imageRect;
//action 例如@[@"收藏",@"保存"] 不大于4
@property (nonatomic, strong) NSMutableArray *actionTitles;
//action回调
@property (nonatomic, copy) void (^actionBlock)(NSInteger index);

@end
