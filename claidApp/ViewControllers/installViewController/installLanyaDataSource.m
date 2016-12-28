//
//  installLanyaDataSource.m
//  claidApp
//
//  Created by kevinpc on 2016/12/27.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "installLanyaDataSource.h"
#import "SingleTon.h"
#import "MinFuncTionTableViewCell.h"

@implementation installLanyaDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lanyaNameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self lanyaNameView:tableView indexPath:indexPath];
}

#pragma mark 自定cell

- (UITableViewCell *)lanyaNameView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    
    MinFuncTionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MINN_FUNCTION_CELL_NIB];
        CBPeripheral *periphe = [self.lanyaNameArray objectAtIndex:indexPath.row];
        cell.lanyaNameLabel.text = periphe.name;

    return cell;
}


@end
