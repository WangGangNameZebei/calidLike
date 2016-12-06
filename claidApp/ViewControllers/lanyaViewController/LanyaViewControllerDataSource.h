//
//  LanyaViewControllerDataSource.h
//  claidApp
//
//  Created by kevinpc on 2016/12/2.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LanyaViewControllerDataSource : NSObject<UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *lanyaNameArray;
@property (strong, nonatomic) NSMutableArray *lanyaNameTouArray;
@end
