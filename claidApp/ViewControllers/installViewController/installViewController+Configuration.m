//
//  installViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2016/11/2.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "installViewController+Configuration.h"
#import "MyTableViewCell.h"
#import "BlankTableViewCell.h"


@implementation installViewController (Configuration)

- (void)configureViews {
    [self myTableViewInitEdit];
}

- (void)myTableViewInitEdit {
    [self.installTableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:My_TABLEVIEW_CELL];
    [self.installTableView registerNib:[UINib nibWithNibName:@"BlankTableViewCell" bundle:nil] forCellReuseIdentifier:BLANK_TABLEVIEW_CELL];
    self.installVCDataSource = [installViewControllerDataSource new];
    self.installTableView.delegate = self;
    self.installTableView.dataSource = self.installVCDataSource;
    self.installVCDataSource.installDataArray = [NSMutableArray arrayWithObjects:@"连接蓝牙",@"空",@"出厂卡刷卡",@"地址卡刷卡",@"时间卡刷卡",@"同步卡刷卡",@"用户卡刷卡",@"查看信息", nil];
    self.installVCDataSource.installImageArray = [NSMutableArray arrayWithObjects:@"kaika.png",@"空",@"shiduankaiqi.png",@"touxiang.png",@"woxinxi.png",@"weixin.png",@"touxiang.png",@"kaxinxi.png", nil];
    
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
