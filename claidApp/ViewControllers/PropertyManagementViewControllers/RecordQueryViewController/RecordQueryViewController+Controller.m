//
//  RecordQueryViewController+Controller.m
//  claidApp
//
//  Created by Zebei on 2017/11/27.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "RecordQueryViewController+Controller.h"
#import "UIScreen+Utility.h"
#import "RecordQueryTableViewCell.h"
#import "RecordQueryViewController+LogicalFlow.h"

@implementation RecordQueryViewController (Controller)

- (void)configureViews {
    [self dataInitAction];
    [self initDSImageBrowseView];
    [self recordQueryTableViewEdit];
    [self loadNewData];
}

- (void)dataInitAction {
    self.pageNum = 1;
    self.rqDataArrar = [NSMutableArray new];
    self.accounts = @"";
    self.swipingTime = @"";
    self.swipingEndTime = @"";
    self.swipingStatusText= @"";
    self.swipingAddressText = @"";
}

- (void)recordQueryTableViewEdit {
    
    [self.recordQueryTableView registerNib:[UINib nibWithNibName:@"RecordQueryTableViewCell" bundle:nil] forCellReuseIdentifier:RECORD_QUERY_TABLEVIEW_CELL];
    self.recordQueryViewControllerDataSource = [RecordQueryViewControllerDataSource new];
    self.recordQueryTableView.dataSource = self.recordQueryViewControllerDataSource;
    self.recordQueryTableView.delegate = self;
    self.recordQueryViewControllerDataSource.myDataArray = self.rqDataArrar;
    
    __weak typeof(self) weakSelf = self;
    self.recordQueryTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //刷新时候，需要执行的代码。一般是请求最新数据，请求成功之后，刷新列表
        [weakSelf loadNewData];
    }];
    self.recordQueryTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //刷新时候，需要执行的代码。一般是请求更多数据，请求成功之后，刷新列表
        [weakSelf loadNoreData];
    }];
    self.recordQueryTableView.noContentViewTapedBlock = ^{
        [weakSelf loadNewData];
    };
}
- (void)initDSImageBrowseView {
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.indicator.size = CGSizeMake(80, 80);
    self.indicator.center = CGPointMake([UIScreen screenWidth] / 2, [UIScreen screenHeight] / 2);
    self.indicator.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.670];
    self.indicator.clipsToBounds = YES;
    self.indicator.layer.cornerRadius = 6;
    [self.indicator startAnimating];
    [self.view addSubview:self.indicator];
    
}
#pragma mark- MJRefresh delegate
- (void)loadNewData {
    self.mjBool = YES;
    [self.indicator startAnimating];
    [self getPOSTConditionRecordQuerypageNum:1 accounts:self.accounts swipingTime:self.swipingTime swipingEndTime:self.swipingEndTime swipingStatus:self.swipingStatusText swipingAddress:self.swipingAddressText];
}
- (void)loadNoreData{
    self.mjBool = NO;
    if (self.hasNextPage != 0 && self.rqDataArrar.count > 0){
       [self getPOSTConditionRecordQuerypageNum:self.pageNum + 1 accounts:self.accounts swipingTime:self.swipingTime swipingEndTime:self.swipingEndTime swipingStatus:self.swipingStatusText swipingAddress:self.swipingAddressText];
    } else {
        [self promptInformationActionWarningString:@"没有更多的数据了"];
        [self.recordQueryTableView.mj_footer endRefreshing];
    }
    
}

#pragma mark- cell 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 128;
}
@end
