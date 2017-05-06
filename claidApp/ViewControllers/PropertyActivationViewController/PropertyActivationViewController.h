//
//  PropertyActivationViewController.h
//  claidApp
//
//  Created by kevinpc on 2017/5/3.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "PropertyActivationSingleTon.h"
#import "PropertyActivationViewControllerDataSource.h"

@interface PropertyActivationViewController : BaseViewController <pALanyaDelegate,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *paVCTableiVew;

@property (strong, nonatomic) PropertyActivationSingleTon *paSingleTon;
@property (strong, nonatomic) NSMutableArray *paLnyaNameArray;
@property (strong, nonatomic) PropertyActivationViewControllerDataSource *propertyActionViewControllerDataSource;

@end
