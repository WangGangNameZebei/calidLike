//
//  CommunityViewController+Configuration.m
//  claidApp
//
//  Created by Zebei on 2017/12/13.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "CommunityViewController+Configuration.h"
#import "ClassificationTypeCell.h"
#import "CommunityAnnounityCell.h"
#import "CommunityPropertyTableViewCell.h"
#import "CommunityViewController+LogicalFlow.h"

@implementation CommunityViewController (Configuration)

- (void)configureViews {
    [self communityTableViewEdit];
    [self announcementsetPOSTDataAction];
    [self getpostInfoAction];
}

- (void)communityTableViewEdit{
    self.propertyNameString = @"";
    self.propertyNumberString = @"";
    [self.communityTableView registerNib:[UINib nibWithNibName:@"ClassificationTypeCell" bundle:nil] forCellReuseIdentifier:CLASSIFCATION_TYPE_CELL];
    [self.communityTableView registerNib:[UINib nibWithNibName:@"CommunityAnnounityCell" bundle:nil] forCellReuseIdentifier:COMMUNITY_ANNOUNITY_CELL];
    [self.communityTableView registerNib:[UINib nibWithNibName:@"CommunityPropertyTableViewCell" bundle:nil] forCellReuseIdentifier:COMMUNITY_PROPERTY_TABLEVIEW_CELL];
    self.communityViewControllerDataSource = [CommunityViewControllerDataSource new];
    self.communityTableView.dataSource = self.communityViewControllerDataSource;
    self.communityTableView.delegate = self;
    self.communityViewControllerDataSource.myDataArray = [NSMutableArray arrayWithObjects:@"查看公告",@"我要报修", nil];
    
}

#pragma mark- cell 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.propertyNameString.length >1 && self.propertyNumberString.length>1){
        if (indexPath.row == 0){
            return 243;
        } else if (indexPath.row == 1){
            return 50;
        }else {
            return 160;
        }
    } else {
        if (indexPath.row == 0){
            return 243;
        } else {
            return 160;
        }
    }
    
   
}
@end
