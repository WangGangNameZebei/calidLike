//
//  UserRepairQueryViewController.h
//  claidApp
//
//  Created by Zebei on 2017/12/27.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "SPPageMenu.h" //分类
#import <MJRefresh.h>  // 上拉加载下拉刷新
#import "DSImagesData.h"
#import "ViewRepairModel.h"
#import "UserRepairQueryLayout.h"
#import "UserRepairTableViewCell.h"
#import "DSImageScrollItem.h"
#import "DSImageShowView.h"
#import "YYImageCoder.h"

@interface UserRepairQueryViewController : BaseViewController <SPPageMenuDelegate,DSImageBrowseCellDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *userRepairQueryTableView;
@property (strong, nonatomic) IBOutlet UIView *pageMenuView;

@property (strong, nonatomic)NSArray *datapageMenuArray;
@property (nonatomic, weak) SPPageMenu *userpageMenu;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@property (nonatomic, strong) NSMutableArray *layouts;
@property (nonatomic, strong) NSMutableArray *layoutsOneArr;
@property (nonatomic, strong) NSMutableArray *layoutsTowArr;
@property (nonatomic, strong) NSMutableArray *layoutsThreeArr;
@property (nonatomic, strong) NSMutableArray *layoutsFourArr;
@property (nonatomic, strong) NSMutableArray *dataPageArr; //下标下个数字代表对应当前页数
@property (nonatomic, strong) NSMutableArray *dataNextPageArr; // 下标下的数字代表是否有下页
@property (nonatomic, assign) BOOL mjBool;
@end
