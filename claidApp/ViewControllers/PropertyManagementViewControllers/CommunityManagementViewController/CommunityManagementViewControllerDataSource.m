//
//  CommunityManagementViewControllerDataSource.m
//  claidApp
//
//  Created by Zebei on 2017/11/14.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "CommunityManagementViewControllerDataSource.h"
#import "CommunityTableViewCell.h"
#import "UIColor+Utility.h"

@implementation CommunityManagementViewControllerDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
       return [self myTableView:tableView indexPath:indexPath];
    return nil;
}

#pragma mark 自定cell
- (UITableViewCell *)myTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    CommunityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:COMMUNITY_CELL_NIB];
    cell.communityLabel.text = [self.myDataArray objectAtIndex:indexPath.row];
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
} 
@end
