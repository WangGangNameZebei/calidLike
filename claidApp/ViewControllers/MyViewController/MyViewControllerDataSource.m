//
//  MyViewControllerDataSource.m
//  claidApp
//
//  Created by kevinpc on 2016/10/24.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "MyViewControllerDataSource.h"
#import "MyTableViewCell.h"
#import "BlankTableViewCell.h"

@implementation MyViewControllerDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        return [self blankTableView:tableView indexPath:indexPath];
    } else {
        return [self myTableView:tableView indexPath:indexPath];
    }
    return nil;
    
}

#pragma mark 自定cell
- (UITableViewCell *)myTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:My_TABLEVIEW_CELL];
    cell.myCellImageView.image = [UIImage imageNamed:[self.myImageArray objectAtIndex:indexPath.item]];
    cell.myCellLabel.text = [self.myDataArray objectAtIndex:indexPath.row];
    return cell;
}

- (UITableViewCell *)blankTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    BlankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BLANK_TABLEVIEW_CELL];
    return cell;
}
@end
