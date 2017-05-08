//
//  MycradInfoViewControllerDataSource.h
//  claidApp
//
//  Created by kevinpc on 2017/5/8.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MycradInfoViewControllerDataSource : NSObject<UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *infoTitleArray;
@property (strong, nonatomic) NSMutableArray *infoTextArray;

@end
