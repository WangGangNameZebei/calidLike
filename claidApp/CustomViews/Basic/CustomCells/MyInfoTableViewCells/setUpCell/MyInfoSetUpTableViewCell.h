//
//  MyInfoSetUpTableViewCell.h
//  claidApp
//
//  Created by Zebei on 2018/2/1.
//  Copyright © 2018年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

#define MY_INFO_SETUP_TABLEVIEW_CELL @"MyInfoSetUpTableViewCell"

@interface MyInfoSetUpTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UISwitch *myInfoshakeSwitch;     //摇一摇
@property (strong, nonatomic) IBOutlet UISwitch *myInfoAutomaticSwitch;     // 自动
@property (strong, nonatomic) IBOutlet UISwitch *myInfoBrightScreenSwitch;      //亮屏
@property (strong, nonatomic) IBOutlet UISwitch *myInfoShockSwitch;     //震动

@property (strong, nonatomic) BaseViewController *baseVC;
@end
