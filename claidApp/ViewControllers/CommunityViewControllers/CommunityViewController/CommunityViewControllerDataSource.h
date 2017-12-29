//
//  CommunityViewControllerDataSource.h
//  claidApp
//
//  Created by Zebei on 2017/12/13.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunityViewControllerDataSource : NSObject<UITableViewDataSource>

@property(strong, nonatomic) NSMutableArray *myDataArray;
@property(strong, nonatomic) NSDictionary * resultDataDic;
@end
