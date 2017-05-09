//
//  MycradInfoViewController.h
//  claidApp
//
//  Created by kevinpc on 2017/5/6.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "MycradInfoViewControllerDataSource.h"
#import "DBTool.h"
#import "ClassUserInfo.h"

@interface MycradInfoViewController : BaseViewController<UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *myCradInfoTableView;
@property (strong, nonatomic) IBOutlet UISwitch *myInfoshakeSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *myInfoBrightScreenSwitch;

@property (strong, nonatomic) MycradInfoViewControllerDataSource *mycradInfoViewControllerDataSource;
@property (strong, nonatomic) DBTool *dbTool;
@property (strong, nonatomic)ClassUserInfo *infoclassUser;      //数据库类

@property (strong, nonatomic) NSMutableArray *myinfotextArray;

@end
