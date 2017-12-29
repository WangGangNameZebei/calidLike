//
//  CommunityViewController.h
//  claidApp
//
//  Created by Zebei on 2017/12/13.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "CommunityViewControllerDataSource.h"

@interface CommunityViewController : BaseViewController<UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *communityTableView;
@property (strong, nonatomic) CommunityViewControllerDataSource *communityViewControllerDataSource;
@end
