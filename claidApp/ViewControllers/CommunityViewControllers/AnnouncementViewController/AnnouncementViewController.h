//
//  AnnouncementViewController.h
//  claidApp
//
//  Created by Zebei on 2017/12/16.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "DSImagesData.h"
#import "DSDemoModel.h"
#import "DSDemoLayout.h"
#import "DSImageDemoCell.h"
#import "DSImageScrollItem.h"
#import "DSImageShowView.h"
#import "YYImageCoder.h"
#import <MJRefresh.h>  // 上拉加载下拉刷新
#import "MyTableView.h"
#import "NoContentView.h"

@interface AnnouncementViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,DSImageBrowseCellDelegate>


@property (strong, nonatomic) IBOutlet MyTableView *announcementTableView;

@property (nonatomic, strong) NSMutableArray *layouts;

@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, assign) NSInteger pageNum;  //  页数
@property (nonatomic, assign) NSInteger hasNextPage;    // 是否有下一页  1 有  0 无
@property (nonatomic, assign) BOOL mjBool;
@end
