//
//  MycradInfoViewControllerDataSource.m
//  claidApp
//
//  Created by kevinpc on 2017/5/8.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "MycradInfoViewControllerDataSource.h"
#import "MycradInfoTableViewCell.h"

@implementation MycradInfoViewControllerDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        return [self myTableView:tableView indexPath:indexPath];

}

#pragma mark 自定cell
- (UITableViewCell *)myTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    MycradInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MY_CRAD_INFO_TABLEVIEW_CELL];
    cell.myInfoTitleLabel.text = [self.infoTitleArray objectAtIndex:indexPath.row];
    cell.myInfotextLabel.text = [self.infoTextArray objectAtIndex:indexPath.row];
    return cell;
}


@end
