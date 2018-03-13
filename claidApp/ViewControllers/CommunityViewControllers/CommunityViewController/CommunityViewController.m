//
//  CommunityViewController.m
//  claidApp
//
//  Created by Zebei on 2017/12/13.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "CommunityViewController.h"
#import "CommunityViewController+Configuration.h"
#import "CommunityViewController+LogicalFlow.h"
#import "AnnouncementViewController.h"      //  查看公告

@implementation CommunityViewController

+ (instancetype)create {
    CommunityViewController *communityViewController = [[CommunityViewController alloc] initWithNibName:@"CommunityViewController" bundle:nil];
    return communityViewController;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
   
    [self announcementsetPOSTDataAction];
    [self getpostInfoAction];
}

#pragma mark-点击TableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        AnnouncementViewController *annoucementVC = [AnnouncementViewController create];
        [self hideTabBarAndpushViewController:annoucementVC];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
