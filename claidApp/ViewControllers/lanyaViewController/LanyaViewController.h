//
//  LanyaViewController.h
//  claidApp
//
//  Created by kevinpc on 2016/12/2.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "LanyaViewControllerDataSource.h"
#import "SingleTon.h"

@interface LanyaViewController : BaseViewController<UITableViewDelegate,sendDataToVCDelegate>
@property (weak, nonatomic) IBOutlet UITableView *lanyaTableView;

@property (strong, nonatomic) LanyaViewControllerDataSource *lanyaViewControllerDataSource;
@property (strong, nonatomic) NSMutableArray *lanyaNameHuoquArray;

@property (strong, nonatomic) SingleTon *sinTon;
@end
