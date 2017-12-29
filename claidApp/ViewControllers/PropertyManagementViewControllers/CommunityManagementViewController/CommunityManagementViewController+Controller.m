//
//  CommunityManagementViewController+Controller.m
//  claidApp
//
//  Created by Zebei on 2017/11/14.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "CommunityManagementViewController+Controller.h"
#import "CommunityTableViewCell.h"

@implementation CommunityManagementViewController (Controller)

- (void)configureViews {
    [self communityManagementTableViewEdit];
}

- (void)communityManagementTableViewEdit {
    self.communityArray = [NSMutableArray arrayWithObjects:@"上传公告",@"记录查询",@"查看报修",@"园区信息", nil];
    [self.communityManagementTableView registerNib:[UINib nibWithNibName:@"CommunityTableViewCell" bundle:nil] forCellReuseIdentifier:COMMUNITY_CELL_NIB];
    self.communityManagementViewControllerDataSource = [CommunityManagementViewControllerDataSource new];
    self.communityManagementTableView.delegate = self;
    self.communityManagementTableView.dataSource = self.communityManagementViewControllerDataSource;
    self.communityManagementViewControllerDataSource.myDataArray = self.communityArray;
}

#pragma mark - UITableview Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 60;
}

@end
