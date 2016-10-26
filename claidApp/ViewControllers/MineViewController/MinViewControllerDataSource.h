//
//  MinViewControllerDataSource.h
//  claidApp
//
//  Created by kevinpc on 2016/10/19.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MinViewControllerDataSource : NSObject<UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *dataArray;
@end
