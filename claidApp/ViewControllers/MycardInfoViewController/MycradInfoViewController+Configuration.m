//
//  MycradInfoViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2017/5/8.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "MycradInfoViewController+Configuration.h"
#import "MycradInfoViewController+LogicalFlow.h"
#import "UIColor+Utility.h"
#import "UIScreen+Utility.h"


@implementation MycradInfoViewController (Configuration)
- (void)configureViews {
    [self getPOSTuserInfoAction];
    [self myinfoTableViewEdit];
    [self addGestRecognizer];
}

#pragma mark - TableView
- (void)myinfoTableViewEdit {
    [self myInfoEditBoolAction:NO];
    self.fileName = @"wu.png";
    self.imagedata = [UIImage imageNamed:@"my_blue"];
    [self.myInfoTableView registerNib:[UINib nibWithNibName:@"MyInfoAvatarTableViewCell" bundle:nil] forCellReuseIdentifier:MY_INFO_AVTAR_TABLEVIEW_CELL];
    [self.myInfoTableView registerNib:[UINib nibWithNibName:@"MyInfoCommunityTableViewCell" bundle:nil] forCellReuseIdentifier:MY_INFO_COMMUNITY_TABLEVIEW_CELL];
    [self.myInfoTableView registerNib:[UINib nibWithNibName:@"MyInfoTableViewCell" bundle:nil] forCellReuseIdentifier:MY_INFO_TABLEVIEW_CELL];
    [self.myInfoTableView registerNib:[UINib nibWithNibName:@"MyInfoSetUpTableViewCell" bundle:nil] forCellReuseIdentifier:MY_INFO_SETUP_TABLEVIEW_CELL];
    
    self.myInfoTableView.delegate = self;
    self.myInfoTableView.dataSource = self;
    self.mydataArray = [NSMutableArray arrayWithObjects:@"头像",@"名称",@"账号",@"当前小区",@"设置", nil];
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        if (indexPath.row == 0){
            return 200;
        } else if (indexPath.row == 4) {
            return 180;
        } else {
            return 50;
        }
   
}
#pragma mark - 空白处收起键盘
- (void)addGestRecognizer {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    tap.numberOfTouchesRequired =1;
    tap.numberOfTapsRequired =1;
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}
- (void)tapped:(UIGestureRecognizer *)gestureRecognizer{
    [self.view endEditing:YES];
}

- (void)myInfoEditBoolAction:(BOOL)boolData{
    if(boolData){
        self.myInfoEditButton.tintColor = [UIColor whiteColor];
    } else {
        self.myInfoEditButton.tintColor = [UIColor colorFromHexCode:@"C2C2C2"];
    }
    self.editBool = boolData;
}

@end
