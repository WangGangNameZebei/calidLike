//
//  VisitorViewControllerDataSource.m
//  claidApp
//
//  Created by kevinpc on 2017/3/24.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "VisitorViewControllerDataSource.h"
#import "MinFuncTionTableViewCell.h"

@implementation VisitorViewControllerDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.beizhuNameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MinFuncTionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MINN_FUNCTION_CELL_NIB];
    
    self.viDataSourceCalss = self.beizhuNameArray[indexPath.row];
    cell.lanyaNameLabel.text =self.viDataSourceCalss.visitorRemarks;
    return cell;
    
}

@end
