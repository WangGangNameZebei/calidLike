//
//  MyViewController.h
//  claidApp
//
//  Created by kevinpc on 2016/10/18.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "MyViewControllerDataSource.h"

@interface MyViewController : BaseViewController <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) MyViewControllerDataSource *myViewControllerDataSource;
@end
