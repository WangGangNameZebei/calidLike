//
//  AboutUsViewControllerDataSource.m
//  claidApp
//
//  Created by Zebei on 2017/10/23.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "AboutUsViewControllerDataSource.h"
#import "MyTableViewCell.h"

@implementation AboutUsViewControllerDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self myTableView:tableView indexPath:indexPath];
}

#pragma mark 自定cell
- (UITableViewCell *)myTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:My_TABLEVIEW_CELL];
    cell.myCellImageView.image = [UIImage imageNamed:[self.myImageArray objectAtIndex:indexPath.item]];
    cell.myCellLabel.text = [self.myDataArray objectAtIndex:indexPath.row];
    return cell;
}

@end
