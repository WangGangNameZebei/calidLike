//
//  AboutUsViewController+Configuration.m
//  claidApp
//
//  Created by Zebei on 2017/10/23.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "AboutUsViewController+Configuration.h"
#import "MyTableViewCell.h"
#import "UIScreen+Utility.h"
#import "UIColor+Utility.h"

@implementation AboutUsViewController (Configuration)

- (void)configureViews {
    [self aboutusTableViewEdit];
    [self tableViewFooterVersionEdit];
}

- (void)aboutusTableViewEdit {
    [self.aboutUsTableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:My_TABLEVIEW_CELL];
    self.aboutUsViewControllerDataSource = [AboutUsViewControllerDataSource new];
    self.aboutUsTableView.delegate = self;
    self.aboutUsTableView.dataSource = self.aboutUsViewControllerDataSource;
    self.aboutUsViewControllerDataSource.myDataArray = [NSMutableArray arrayWithObjects:@"使用教学",@"意见反馈",@"软件分享", nil];
    self.aboutUsViewControllerDataSource.myImageArray = [NSMutableArray arrayWithObjects:@"tutorial_blue",@"my_feedback_blue",@"app_shareIt_blue", nil];
}

- (void)tableViewFooterVersionEdit {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [NSString stringWithFormat:@"当前版本:    %@",[infoDic objectForKey:@"CFBundleShortVersionString"]];
    self.versionLabel.text = appVersion;
}
@end
