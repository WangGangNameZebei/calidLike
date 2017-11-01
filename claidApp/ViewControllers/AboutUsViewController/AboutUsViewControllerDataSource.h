//
//  AboutUsViewControllerDataSource.h
//  claidApp
//
//  Created by Zebei on 2017/10/23.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUsViewControllerDataSource : NSObject<UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *myDataArray;
@property (strong, nonatomic) NSMutableArray *myImageArray;
@end
