//
//  VisitorViewControllerDataSource.h
//  claidApp
//
//  Created by kevinpc on 2017/3/24.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisitorCalss.h"
@interface VisitorViewControllerDataSource : NSObject<UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *beizhuNameArray;
@property (strong, nonatomic) VisitorCalss *viDataSourceCalss;
@end
