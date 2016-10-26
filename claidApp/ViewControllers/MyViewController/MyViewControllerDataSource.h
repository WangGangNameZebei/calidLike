//
//  MyViewControllerDataSource.h
//  claidApp
//
//  Created by kevinpc on 2016/10/24.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewControllerDataSource : NSObject<UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *myDataArray;
@property (strong, nonatomic) NSMutableArray *myImageArray;

@end
