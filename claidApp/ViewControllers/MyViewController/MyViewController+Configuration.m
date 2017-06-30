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
    [self myTableViewInitEdit];
}



- (void)myTableViewInitEdit {
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:My_TABLEVIEW_CELL];
    [self.myTableView registerNib:[UINib nibWithNibName:@"BlankTableViewCell" bundle:nil] forCellReuseIdentifier:BLANK_TABLEVIEW_CELL];
     [self.myTableView registerNib:[UINib nibWithNibName:@"LoginOutTableViewCell" bundle:nil] forCellReuseIdentifier:LOGIN_OUT_TABLEVIEW_CELL];
    self.myViewControllerDataSource = [MyViewControllerDataSource new];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self.myViewControllerDataSource;
    self.myViewControllerDataSource.myDataArray = [NSMutableArray arrayWithObjects:@"物业续卡",@"空",@"我的设置",@"邀请访客",@"我是访客",@"物业设置",@"修改密码",@"数据同步",@"意见反馈",@"2",@"退出登录",@"4", nil];
    self.myViewControllerDataSource.myImageArray = [NSMutableArray arrayWithObjects:@"my_card_blue",@"空",@"my_user_setUp_blue",@"my_visitor_blue-1",@"my_visitor_blue",@"my_setUp_blue",@"my_changethepassword_blue",@"my_updata_blue",@"my_feedback_blue",@"2",@"3"@"4", nil];

}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0){
       return 70;
    } else if (indexPath.row == 1) {
        return 28;
    } else if (indexPath.row == 9) {
        return 100;
    } else {
        return 60;
    }
    
}

@end
