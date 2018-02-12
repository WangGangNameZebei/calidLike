//
//  RecordQueryViewControllerDataSource.h
//  claidApp
//
//  Created by Zebei on 2018/1/4.
//  Copyright © 2018年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordQueryViewControllerDataSource : NSObject<UITableViewDataSource>
@property(strong, nonatomic) NSMutableArray *myDataArray;
@end
