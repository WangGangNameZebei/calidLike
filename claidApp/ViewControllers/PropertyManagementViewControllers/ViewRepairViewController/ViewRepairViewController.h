//
//  ViewRepairViewController.h
//  claidApp
//
//  Created by Zebei on 2017/12/22.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "SPPageMenu.h" //分类
#import <MJRefresh.h>  // 上拉加载下拉刷新
#import "DSImagesData.h"
#import "ViewRepairModel.h"
#import "ViewRepairLayout.h"
#import "ViewRepairTableViewCell.h"
#import "DSImageScrollItem.h"
#import "DSImageShowView.h"
#import "YYImageCoder.h"

#import "MyTableView.h"
#import "NoContentView.h"
@interface ViewRepairViewController : BaseViewController <SPPageMenuDelegate,DSImageBrowseCellDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *pageMenuView;

@property (strong, nonatomic) IBOutlet MyTableView *viewRepairTableView;

@property (strong, nonatomic)NSArray *dataClassificationArray;
@property (nonatomic, weak) SPPageMenu *pageMenu;

@property (nonatomic, strong) NSMutableArray *layouts;
@property (nonatomic, strong) NSMutableArray *layoutsOneArr;
@property (nonatomic, strong) NSMutableArray *layoutsTowArr;
@property (nonatomic, strong) NSMutableArray *layoutsThreeArr;
@property (nonatomic, strong) NSMutableArray *layoutsFourArr;
@property (nonatomic, strong) NSMutableArray *layoutsFiveArr;
@property (nonatomic, strong) NSMutableArray *dataPageArr; //下标下个数字代表对应当前页数
@property (nonatomic, strong) NSMutableArray *dataNextPageArr; // 下标下的数字代表是否有下页
@property (nonatomic, assign) BOOL mjBool;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;


@property (nonatomic, assign) NSInteger cellButtonTag;
@property (nonatomic, strong) NSString *cellButtonName;

@end
