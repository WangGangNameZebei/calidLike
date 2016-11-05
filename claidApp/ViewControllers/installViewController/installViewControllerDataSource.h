//
//  installViewControllerDataSource.h
//  claidApp
//
//  Created by kevinpc on 2016/11/2.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface installViewControllerDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *installDataArray;
@property (strong, nonatomic) NSMutableArray *installImageArray;

@end
