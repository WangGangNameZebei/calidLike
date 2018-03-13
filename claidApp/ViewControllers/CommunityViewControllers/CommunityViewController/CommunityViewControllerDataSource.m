//
//  CommunityViewControllerDataSource.m
//  claidApp
//
//  Created by Zebei on 2017/12/13.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "CommunityViewControllerDataSource.h"
#import "ClassificationTypeCell.h"
#import "CommunityAnnounityCell.h"
#import "CommunityPropertyTableViewCell.h"

@implementation CommunityViewControllerDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.myDataArray.count ==2){
        if (indexPath.row == 0) {
            return [self communityAnnounityTableView:tableView indexPath:indexPath];
        } else {
            return [self myTableView:tableView indexPath:indexPath];
        }
    } else {
        if (indexPath.row == 0) {
            return [self communityAnnounityTableView:tableView indexPath:indexPath];
        } else if (indexPath.row == 1){
            return [self communityPropertyTableView:tableView indexPath:indexPath];
        }else {
            return [self myTableView:tableView indexPath:indexPath];
        }
    }
    
    
}

#pragma mark 自定cell
- (UITableViewCell *)myTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    ClassificationTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:CLASSIFCATION_TYPE_CELL];
    return cell;
}

- (UITableViewCell *)communityPropertyTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    CommunityPropertyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:COMMUNITY_PROPERTY_TABLEVIEW_CELL];
     cell.nameLabel.text =[NSString stringWithFormat:@"%@",self.mypropertyArray[0]];
    cell.numberLabel.text =[NSString stringWithFormat:@"%@",self.mypropertyArray[1]];
    
    return cell;
}

- (UITableViewCell *)communityAnnounityTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    CommunityAnnounityCell *cell = [tableView dequeueReusableCellWithIdentifier:COMMUNITY_ANNOUNITY_CELL];
    NSMutableArray *imageData = [NSMutableArray new];
    if (self.resultDataDic.count > 0){
        NSString *strimage=[self.resultDataDic objectForKey:@"notification_pictrue_path"];
        if (![strimage isKindOfClass:[NSNull class]] && strimage.length > 10){
            NSArray *temp=[strimage componentsSeparatedByString:@","];
            for (int j = 0; j < temp.count; j++) {
                NSString *thumbnail =[NSString stringWithFormat:@"http://sycalid.cn//%@",temp[j]];
                [imageData addObject:thumbnail];
            }
        } else {
            NSString *thumbnail =[NSString stringWithFormat:@"http://sycalid.cn/data/image/notification/final/notification_pic_default.png"];
            [imageData addObject:thumbnail];
        }
        if (self.status == 200){
            [cell setinfocaTimeText:[self.resultDataDic objectForKey:@"publish_time"] caTitleText:[self.resultDataDic objectForKey:@"notification_title"] caTextinfo:[self.resultDataDic objectForKey:@"notification_content"] dataImageArr:imageData];
        } else {
             [cell setinfocaTimeText:@"  " caTitleText:@"暂无公告" caTextinfo:@"..." dataImageArr:imageData];
        }
        
    } else {
        NSString *thumbnail =[NSString stringWithFormat:@"http://sycalid.cn/data/image/notification/final/notification_not.png"];
        [imageData addObject:thumbnail];
        [cell setinfocaTimeText:@"  " caTitleText:@"暂无公告" caTextinfo:@"..." dataImageArr:imageData];
    }
    return cell;
}

@end
