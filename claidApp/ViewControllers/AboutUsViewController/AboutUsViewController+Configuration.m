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
#import "AboutUsViewController+LogicalFlow.h"

@implementation AboutUsViewController (Configuration)

- (void)configureViews {
    [self aboutusTableViewEdit];
    [self tableViewFooterVersionEdit];
    [self singleTonEdit];
}
- (void)manageApplicationsEdits {
    NSString  *strLanya = FAKAQI_TON_UUID_STR;
    if (strLanya.length < 3) {
        [self.managementSingleTon startScan]; // 扫描
    } else {
        [self.managementSingleTon getPeripheralWithIdentifierAndConnect:strLanya];
    }
}

- (void)aboutusTableViewEdit {
    [self.aboutUsTableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:My_TABLEVIEW_CELL];
    self.aboutUsViewControllerDataSource = [AboutUsViewControllerDataSource new];
    self.aboutUsTableView.delegate = self;
    self.aboutUsTableView.dataSource = self.aboutUsViewControllerDataSource;
    self.aboutUsViewControllerDataSource.myDataArray = [NSMutableArray arrayWithObjects:@"使用教学",@"意见反馈",@"检查更新",@"软件分享",@"管理申请", nil];
    self.aboutUsViewControllerDataSource.myImageArray = [NSMutableArray arrayWithObjects:@"tutorial_blue",@"my_feedback_blue",@"upgradeApp_blue",@"app_shareIt_blue",@"applyformanagement_blue", nil];
}

- (void)tableViewFooterVersionEdit {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [NSString stringWithFormat:@"当前版本:    %@",[infoDic objectForKey:@"CFBundleShortVersionString"]];
    self.versionLabel.text = appVersion;
}
- (void)singleTonEdit {
    self.managementSingleTon = [ManagementSingleTon sharedInstance];
    [self.managementSingleTon initialization];
    self.managementSingleTon.delegate = self;
}
#pragma mark-蓝牙 delegate
- (void)managementtishiFrame:(NSString *)string {
    if ([string isEqualToString:@"寻到发卡器"]){
       [self.managementSingleTon getPeripheralWithIdentifierAndConnect:FAKAQI_TON_UUID_STR];
    } else if ([string isEqualToString:@"连接成功"]) {
         [self.managementSingleTon sendCommand:@"99"];       //发送数据
        [self promptInformationActionWarningString:@"链接到发卡器"];
    } else if (string.length == 106  && [[string substringWithRange:NSMakeRange(0,2)] isEqualToString:@"bb"]){
        [self checkStatusOfCardPOSTdataStr:[string substringWithRange:NSMakeRange(2, 104)]];
    } else if (string.length == 96  && [[string substringWithRange:NSMakeRange(0,2)] isEqualToString:@"00"]){
         [self administratorApplicationPOSTdataaccountsstr:[string substringWithRange:NSMakeRange(46,11)] pptCellId:[string substringWithRange:NSMakeRange(0,8)] role:[string substringWithRange:NSMakeRange(91,1)]];
    } else {
        
    }
}




@end
