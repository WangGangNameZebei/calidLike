//
//  PropertyActivationViewControllerDataSource.m
//  claidApp
//
//  Created by kevinpc on 2017/5/3.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "PropertyActivationViewControllerDataSource.h"
#import "MinFuncTionTableViewCell.h"
#import "PropertyActivationSingleTon.h"

@implementation PropertyActivationViewControllerDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pAVCDataSourceArray.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        return [self lanyaNameView:tableView indexPath:indexPath];
    
}

#pragma mark 自定cell

- (UITableViewCell *)lanyaNameView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    
    MinFuncTionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MINN_FUNCTION_CELL_NIB];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CBPeripheral *periphe = [self.pAVCDataSourceArray objectAtIndex:(indexPath.row)];
        cell.lanyaNameLabel.text = periphe.name;
  
    return cell;
}

@end
