//
//  CommunityManagementViewController.m
//  claidApp
//
//  Created by Zebei on 2017/11/14.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "CommunityManagementViewController.h"
#import "CommunityManagementViewController+Controller.h"
#import "UploadViewController.h"        //  上传公告
#import "RecordQueryViewController.h"  //   查看记录
#import "ViewRepairViewController.h"  //    查看报修
#import "ParkModifyViewController.h" //     园区信息
@implementation CommunityManagementViewController

+ (instancetype) create {
    CommunityManagementViewController *communityManagementVC = [[CommunityManagementViewController alloc] initWithNibName:@"CommunityManagementViewController" bundle:nil];
    return communityManagementVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}
- (IBAction)communityTableView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 点击  UItableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0){
        UploadViewController *uploadVC = [UploadViewController create];
        uploadVC.titleString = @"公告上传";
     [self presentViewController:uploadVC animated:YES completion:nil];
    } else if (indexPath.row == 1){
        RecordQueryViewController *recordQueryVC =  [RecordQueryViewController create];
       [self presentViewController:recordQueryVC animated:YES completion:nil];
    } else if (indexPath.row == 2) {
        ViewRepairViewController *viewRepairVC = [ViewRepairViewController create];
        [self presentViewController:viewRepairVC animated:YES completion:nil];
    } else {
        ParkModifyViewController *parkModiftyVC = [ParkModifyViewController create];
        [self presentViewController:parkModiftyVC animated:YES completion:nil];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
