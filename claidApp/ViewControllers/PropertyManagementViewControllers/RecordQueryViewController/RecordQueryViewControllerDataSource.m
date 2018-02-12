//
//  RecordQueryViewControllerDataSource.m
//  claidApp
//
//  Created by Zebei on 2018/1/4.
//  Copyright © 2018年 kevinpc. All rights reserved.
//

#import "RecordQueryViewControllerDataSource.h"
#import "RecordQueryTableViewCell.h"
@implementation RecordQueryViewControllerDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self myTableView:tableView indexPath:indexPath];
}

#pragma mark 自定cell
- (UITableViewCell *)myTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    RecordQueryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RECORD_QUERY_TABLEVIEW_CELL];
    NSDictionary *dataDictionary = self.myDataArray[indexPath.row];
    cell.swipingTimeLabel.text = [dataDictionary objectForKey:@"swiping_time"];
    cell.accountsLabel.text = [NSString stringWithFormat:@"%@",[dataDictionary objectForKey:@"accounts"]];
    cell.swipingStatusLabel.text = [NSString stringWithFormat:@"%@",[dataDictionary objectForKey:@"swiping_status"]];
    cell.swipingAddress.text = [NSString stringWithFormat:@"%@",[dataDictionary objectForKey:@"swiping_address"]];
    cell.swipingSensitivityLabel.text = [NSString stringWithFormat:@"%@",[dataDictionary objectForKey:@"swiping_sensitivity"]];
    return cell;
}


@end
