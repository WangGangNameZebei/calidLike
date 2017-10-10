//
//  MyViewController.h
//  claidApp
//
//  Created by kevinpc on 2016/10/18.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "MyViewControllerDataSource.h"
#import "InternetServices.h"

@interface MyViewController : BaseViewController <UITableViewDelegate,UIApplicationDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic)UIAlertView *customAlertView;                  //管理员口令
@property (strong, nonatomic) MyViewControllerDataSource *myViewControllerDataSource;


@end
