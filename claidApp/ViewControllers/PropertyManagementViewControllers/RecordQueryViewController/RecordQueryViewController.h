//
//  RecordQueryViewController.h
//  claidApp
//
//  Created by Zebei on 2017/11/27.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "CQSideBarManager.h"
#import "ConditionInquiryView.h"
#import "RecordQueryViewControllerDataSource.h"
#import <MJRefresh.h>  // 上拉加载下拉刷新
#import "DSImageScrollItem.h" // size 

#import "MyTableView.h"
#import "NoContentView.h"
@interface RecordQueryViewController : BaseViewController<CQSideBarManagerDelegate,ConditionInquiryViewDelegate,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet MyTableView *recordQueryTableView;

@property (strong, nonatomic) ConditionInquiryView *conditionInquiryView;
@property (strong, nonatomic) NSMutableArray *rqDataArrar;
@property (strong, nonatomic) RecordQueryViewControllerDataSource *recordQueryViewControllerDataSource;


@property (strong, nonatomic) NSString *accounts;
@property (strong, nonatomic) NSString *swipingTime;
@property (strong, nonatomic) NSString *swipingEndTime;
@property (strong, nonatomic) NSString *swipingStatusText;
@property (strong, nonatomic) NSString *swipingAddressText;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, assign) NSInteger pageNum;  //  页数
@property (nonatomic, assign) NSInteger hasNextPage;    // 是否有下一页  1 有  0 无
@property (nonatomic, assign) BOOL mjBool;
@end
