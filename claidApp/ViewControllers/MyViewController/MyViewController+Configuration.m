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

@implementation MyViewController (Configuration)

- (void)configureViews {
    [self myTableViewInitEdit];
}

- (void)myTableViewInitEdit {
    [self.myTableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:My_TABLEVIEW_CELL];
    [self.myTableView registerNib:[UINib nibWithNibName:@"BlankTableViewCell" bundle:nil] forCellReuseIdentifier:BLANK_TABLEVIEW_CELL];
    self.myViewControllerDataSource = [MyViewControllerDataSource new];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self.myViewControllerDataSource;
    self.myViewControllerDataSource.myDataArray = [NSMutableArray arrayWithObjects:@"开卡",@"空",@"准时段开启蓝牙",@"修改电梯",@"修改我的信息",@"绑定微信",@"上传头像",@"查看卡信息", nil];
    self.myViewControllerDataSource.myImageArray = [NSMutableArray arrayWithObjects:@"kaika.png",@"空",@"shiduankaiqi.png",@"touxiang.png",@"woxinxi.png",@"weixin.png",@"touxiang.png",@"kaxinxi.png", nil];

}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0){
       return 70;
    } else if (indexPath.row == 1) {
        return 28;
    } else {
        return 60;
    }
    
}

@end
