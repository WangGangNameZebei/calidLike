//
//  installViewController.h
//  claidApp
//
//  Created by kevinpc on 2016/11/2.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "installViewControllerDataSource.h"
#import "ZBGroup.h"

@interface installViewController : BaseViewController <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *installTableView;

@property (strong, nonatomic) installViewControllerDataSource *installVCDataSource;
@property (strong, nonatomic) NSMutableArray *installDataArray;

@end
