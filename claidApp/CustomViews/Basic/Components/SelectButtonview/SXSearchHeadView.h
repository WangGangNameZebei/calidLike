//
//  SXSearchHeadView.h
//  News Of History
//
//  Created by qingyun on 16/9/28.
//  Copyright © 2016年 zebei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXSearchHeadView : UIView<UIAlertViewDelegate>

@property (nonatomic,strong) void(^titleBlock)(NSInteger);
@property (nonatomic,strong) NSString *peomType;
@property (nonatomic,strong) void(^selectBlock)(NSString *);
//处于搜索状态时显示的tableView
@property (nonatomic,strong) UITableView *searchTableView;
@property (nonatomic,strong) UIButton *dataButton;

//当前button的值
@property (nonatomic,assign) NSInteger selectIndex;
@property (nonatomic, strong) NSIndexPath *selectIndexPath;       //记录长按哪个
@property (strong, nonatomic)UIAlertView *modifyAlertView;        //修改名称
//标识当前选中的button下标
@property(nonatomic)NSUInteger preIndex;

- (instancetype)initWithFrame:(CGRect)frame andDataSource:(NSMutableArray *)DataSource;


@end
