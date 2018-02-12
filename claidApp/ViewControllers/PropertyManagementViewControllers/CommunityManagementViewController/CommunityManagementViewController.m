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
         uploadVC.transitioningDelegate = self;
       [self presentViewController:uploadVC animated:YES completion:nil];
    } else if (indexPath.row == 1){
        RecordQueryViewController *recordQueryVC =  [RecordQueryViewController create];
         recordQueryVC.transitioningDelegate = self;
       [self presentViewController:recordQueryVC animated:YES completion:nil];
    } else if (indexPath.row == 2) {
        ViewRepairViewController *viewRepairVC = [ViewRepairViewController create];
         viewRepairVC.transitioningDelegate = self;
        [self presentViewController:viewRepairVC animated:YES completion:nil];
    } else {
        ParkModifyViewController *parkModiftyVC = [ParkModifyViewController create];
        parkModiftyVC.transitioningDelegate = self;
        [self presentViewController:parkModiftyVC animated:YES completion:nil];
    }
    
}
#pragma Mark - UIViewControllerTransitioningDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[PresentTransitionAnimated alloc] init];
}
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[DismissTransitionAnimated alloc] init];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
