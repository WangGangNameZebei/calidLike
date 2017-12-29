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

@implementation CommunityViewControllerDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [self communityAnnounityTableView:tableView indexPath:indexPath];
    } else {
        return [self myTableView:tableView indexPath:indexPath];
    }
    
}

#pragma mark 自定cell
- (UITableViewCell *)myTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    ClassificationTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:CLASSIFCATION_TYPE_CELL];
    return cell;
}

- (UITableViewCell *)communityAnnounityTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    CommunityAnnounityCell *cell = [tableView dequeueReusableCellWithIdentifier:COMMUNITY_ANNOUNITY_CELL];
    NSMutableArray *imageData = [NSMutableArray new];
    if (self.resultDataDic){
        cell.caTimeLabel.text = [self.resultDataDic objectForKey:@"publish_time"];
        cell.caTitleLabel.text = [self.resultDataDic objectForKey:@"notification_title"];
        cell.catextInfoLabel.text = [self.resultDataDic objectForKey:@"notification_content"];
        NSString *strimage=[self.resultDataDic objectForKey:@"notification_pictrue_path"];
        if (![strimage isKindOfClass:[NSNull class]] ){
            NSArray *temp=[strimage componentsSeparatedByString:@","];
            //NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://sycalid.cn//%@",temp[0]]];
           // UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
            
            
            for (int j = 0; j < temp.count; j++) {
                NSString *thumbnail =[NSString stringWithFormat:@"http://sycalid.cn//%@",temp[j]];
                [imageData addObject:thumbnail];
            }
       }
        [cell animationImplementationAction:imageData];
    } else {
        cell.caTimeLabel.text = @"无";
        cell.caTitleLabel.text = @"暂无公告";
        cell.catextInfoLabel.text = @"...";
    }
    return cell;
}

@end
