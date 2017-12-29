//
//  MyViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2016/10/24.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "MyViewController+Configuration.h"
#import "MyTableViewCell.h"
#import "BlankTableViewCell.h"
#import "LoginOutTableViewCell.h"

@implementation MyViewController (Configuration)

- (void)configureViews {
    [self createAdatabaseAction];  //创建数据库
    [self myTableViewInitEdit];
}


- (void)myTableViewInitEdit {
    [self.myTableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:My_TABLEVIEW_CELL];
    [self.myTableView registerNib:[UINib nibWithNibName:@"BlankTableViewCell" bundle:nil] forCellReuseIdentifier:BLANK_TABLEVIEW_CELL];
     [self.myTableView registerNib:[UINib nibWithNibName:@"LoginOutTableViewCell" bundle:nil] forCellReuseIdentifier:LOGIN_OUT_TABLEVIEW_CELL];
    self.myViewControllerDataSource = [MyViewControllerDataSource new];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self.myViewControllerDataSource;
    [self myTableViewInitdataArray];
}
// 数据编辑
- (void)myTableViewInitdataArray {
    if([[self userInfoReaduserkey:@"role"] isEqualToString:@"1"]){
        self.myViewControllerDataSource.myDataArray = [NSMutableArray arrayWithObjects:@"社区管理",@"物业管理",@"设备设置",@"空",@"我的设置",@"邀请访客",@"我是访客",@"修改密码",@"数据同步",@"关于我们",@"2",@"退出登录",@"4", nil];
        self.myViewControllerDataSource.myImageArray = [NSMutableArray arrayWithObjects:@"community_blue",@"my_card_blue",@"my_user_setUp_blue",@"空",@"my_setUp_blue",@"my_visitor_blue-1",@"my_visitor_blue",@"my_changethepassword_blue",@"my_updata_blue",@"my_aboutus_blue",@"2",@"3"@"4", nil];
    } else {
        self.myViewControllerDataSource.myDataArray = [NSMutableArray arrayWithObjects:@"我的设置",@"邀请访客",@"我是访客",@"修改密码",@"数据同步",@"关于我们",@"2",@"退出登录",@"4", nil];
        self.myViewControllerDataSource.myImageArray = [NSMutableArray arrayWithObjects:@"my_setUp_blue",@"my_visitor_blue-1",@"my_visitor_blue",@"my_changethepassword_blue",@"my_updata_blue",@"my_aboutus_blue",@"2",@"3"@"4", nil];
    }
}
#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([[self userInfoReaduserkey:@"role"] isEqualToString:@"1"]){
        if (indexPath.row == 3) {
            return 25;
        } else if (indexPath.row == 10) {
            return 100;
        } else {
            return 60;
        }
    } else {
        if (indexPath.row == 6){
            return 100;
        } else {
            return 60;
        }
    }

    
}

@end
