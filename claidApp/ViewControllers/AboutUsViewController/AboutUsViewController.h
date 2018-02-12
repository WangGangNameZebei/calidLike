//
//  AboutUsViewController.h
//  claidApp
//
//  Created by Zebei on 2017/10/21.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "ManagementSingleTon.h"
#import "AboutUsViewControllerDataSource.h"

@interface AboutUsViewController : BaseViewController<managementdelegate,UITableViewDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *aboutUsTableView;
@property (strong, nonatomic) AboutUsViewControllerDataSource *aboutUsViewControllerDataSource;
@property (strong, nonatomic)UIAlertView *ablouusAlertView;                  
@property (strong, nonatomic) IBOutlet UILabel *versionLabel;


@property (strong, nonatomic) ManagementSingleTon *managementSingleTon;
@property (strong, nonatomic)NSString *xiaoquNumber;// 小区号码

@end
