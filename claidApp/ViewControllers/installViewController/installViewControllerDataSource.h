//
//  installViewControllerDataSource.h
//  claidApp
//
//  Created by kevinpc on 2016/11/2.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstallCardData.h"
@protocol installViewControllerDelegate <NSObject>
@optional
- (void)installLongPress:(UIGestureRecognizer *)recognizer;     // 长按cell
@end

@interface installViewControllerDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *installDataArray;
@property (strong, nonatomic)InstallCardData *installCardData;      //数据库类

@property (nonatomic, assign) id <installViewControllerDelegate> delegate;

@end
