//
//  LanyaViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2016/12/2.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "LanyaViewController+Configuration.h"
#import "MyTableViewCell.h"
#import "BlankTableViewCell.h"
#import "MinFuncTionTableViewCell.h"
#import "LoginOutTableViewCell.h"
#import "LanyaHeadTableViewCell.h"

@implementation LanyaViewController (Configuration)



- (void)configureViews {
    [self LanyainitData];
    [self myTableViewInitEdit];
}

- (void)LanyainitData {
    self.lanyaTitleLabel.text = self.titleNameString;
    self.sinTon = [SingleTon sharedInstance];
    self.sinTon.delegate = self;
    self.lanyaNameHuoquArray = [NSMutableArray array];
}

- (void)myTableViewInitEdit {
    [self.lanyaTableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:My_TABLEVIEW_CELL];
    [self.lanyaTableView registerNib:[UINib nibWithNibName:@"BlankTableViewCell" bundle:nil] forCellReuseIdentifier:BLANK_TABLEVIEW_CELL];
    [self.lanyaTableView registerNib:[UINib nibWithNibName:@"MinFuncTionTableViewCell" bundle:nil] forCellReuseIdentifier:MINN_FUNCTION_CELL_NIB];
    [self.lanyaTableView registerNib:[UINib nibWithNibName:@"LoginOutTableViewCell" bundle:nil] forCellReuseIdentifier:LOGIN_OUT_TABLEVIEW_CELL];
     [self.lanyaTableView registerNib:[UINib nibWithNibName:@"LanyaHeadTableViewCell" bundle:nil] forCellReuseIdentifier:LANYA_HEAD_TABELEVIEW_CELL];
    
    self.lanyaViewControllerDataSource = [LanyaViewControllerDataSource new];
    self.lanyaTableView.delegate = self;
    self.lanyaTableView.dataSource = self.lanyaViewControllerDataSource;
    self.lanyaViewControllerDataSource.lanyaNameArray = self.lanyaNameHuoquArray;
}

#pragma mark - 蓝牙 Delegate
- (void)DoSomethingEveryFrame:(NSMutableArray *)array {
    self.lanyaNameHuoquArray = array;
}
- (void)DoSomethingtishiFrame:(NSString *)string {
    [self promptInformationActionWarningString:string];
    [self.lanyaTableView reloadData];
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 2) {
        return 30;
    } else if (indexPath.row == 1) {
        return 60;
    } else if (indexPath.row == 3){
        return 70;
    } else if (indexPath.row == 4) {
        return 15;
    } else {
        return 55;
    }
    
}

@end
