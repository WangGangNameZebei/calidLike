//
//  installViewControllerDataSource.m
//  claidApp
//
//  Created by kevinpc on 2016/11/2.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "installViewControllerDataSource.h"
#import "MyTableViewCell.h"
#import "BlankTableViewCell.h"
#import "ZBGroup.h"

@implementation installViewControllerDataSource

//这是tabview创建多少组的回调
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.installDataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZBGroup *group = self.installDataArray[section];
    return group.isFolded? 0: group.size;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 1) {
//        return [self blankTableView:tableView indexPath:indexPath];
//    } else {
//        return [self myTableView:tableView indexPath:indexPath];
//    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
    }
    //将模型里的数据赋值给cell
    ZBGroup *group = self.installDataArray[indexPath.section];
    NSArray *arr=group.items;
    cell.textLabel.text = arr[indexPath.row];
   // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;

    
}

#pragma mark 自定cell
- (UITableViewCell *)myTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:My_TABLEVIEW_CELL];
   cell.myCellImageView.image = [UIImage imageNamed:[self.installImageArray objectAtIndex:indexPath.item]];
    cell.myCellLabel.text = [self.installDataArray objectAtIndex:indexPath.row];
    return cell;
}

- (UITableViewCell *)blankTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    BlankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BLANK_TABLEVIEW_CELL];
    return cell;
}

@end
