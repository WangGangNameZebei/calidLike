//
//  CommunityManagementViewController.h
//  claidApp
//
//  Created by Zebei on 2017/11/14.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "CommunityManagementViewControllerDataSource.h"
#import "PresentTransitionAnimated.h"
#import "DismissTransitionAnimated.h"

@interface CommunityManagementViewController : BaseViewController<UITableViewDelegate,UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) IBOutlet UITableView *communityManagementTableView;
@property (strong, nonatomic)CommunityManagementViewControllerDataSource *communityManagementViewControllerDataSource;
@property (strong, nonatomic) NSMutableArray *communityArray;

@end
