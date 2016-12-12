//
//  LanyaViewControllerDataSource.m
//  claidApp
//
//  Created by kevinpc on 2016/12/2.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "LanyaViewControllerDataSource.h"
#import "MyTableViewCell.h"
#import "BlankTableViewCell.h"
#import "MinFuncTionTableViewCell.h"
#import "LoginOutTableViewCell.h"
#import "SingleTon.h"

@implementation LanyaViewControllerDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lanyaNameArray.count + 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [self myTableView:tableView indexPath:indexPath];
    } else if (indexPath.row == 1) {
        return [self blankTableView:tableView indexPath:indexPath];
    } else if (indexPath.row == (self.lanyaNameArray.count + 3)){
        return [self duanKaiLanyaNameView:tableView indexPath:indexPath];
    } else {
        return [self lanyaNameView:tableView indexPath:indexPath];
    }
    
}

#pragma mark 自定cell
- (UITableViewCell *)myTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:My_TABLEVIEW_CELL];
    cell.myCellImageView.image = [UIImage imageNamed:@"my_bluetooth_blue"];
    cell.myCellLabel.text =@"扫描蓝牙";
    return cell;
}

- (UITableViewCell *)blankTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    BlankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BLANK_TABLEVIEW_CELL];
    return cell;
}

- (UITableViewCell *)lanyaNameView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    
  
    MinFuncTionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MINN_FUNCTION_CELL_NIB];
    if  (indexPath.row == (self.lanyaNameArray.count + 2) || indexPath.row == (self.lanyaNameArray.count + 4)){
        cell.lanyaNameLabel.text = @"";
    } else {
       CBPeripheral *periphe = [self.lanyaNameArray objectAtIndex:(indexPath.row - 2)];
       cell.lanyaNameLabel.text = periphe.name;
    }
    return cell;
}
- (UITableViewCell *)duanKaiLanyaNameView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    LoginOutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LOGIN_OUT_TABLEVIEW_CELL];
    cell.loginOutLabel.text = @"断开蓝牙";
    return cell;
}
@end
