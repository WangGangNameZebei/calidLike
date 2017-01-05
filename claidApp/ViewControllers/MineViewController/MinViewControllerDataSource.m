//
//  MinViewControllerDataSource.m
//  claidApp
//
//  Created by kevinpc on 2016/10/19.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "MinViewControllerDataSource.h"
#import "MinFuncTionTableViewCell.h"
#import "SingleTon.h"

@implementation MinViewControllerDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    MinFuncTionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MINN_FUNCTION_CELL_NIB forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ( indexPath.section < self.dataArray.count) {
        CBPeripheral *periphe = [self.dataArray objectAtIndex:indexPath.section];
        cell.lanyaNameLabel.text = periphe.name;
    } else {
        cell.lanyaNameLabel.text = [NSString stringWithFormat:@"%@",@"断开蓝牙"];
    }
    return cell;
   
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     return self.dataArray.count + 1;
}
@end
