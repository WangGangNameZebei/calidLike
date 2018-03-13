//
//  MyInfoCommunityTableViewCell.h
//  claidApp
//
//  Created by Zebei on 2018/2/1.
//  Copyright © 2018年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXSearchHeadView.h"
#import "BaseViewController.h"

#define MY_INFO_COMMUNITY_TABLEVIEW_CELL @"MyInfoCommunityTableViewCell"

@interface MyInfoCommunityTableViewCell : UITableViewCell


@property (strong,nonatomic) SXSearchHeadView *selectNameView;
@property (strong, nonatomic) NSMutableArray *myinfoNameArray;
@property (strong, nonatomic) IBOutlet UISwitch *myInfoshakeSwitch;     //摇一摇
@property (strong, nonatomic) IBOutlet UISwitch *myInfoAutomaticSwitch;     // 自动
@property (strong, nonatomic) IBOutlet UISwitch *myInfoBrightScreenSwitch;      //亮屏
@property (strong, nonatomic) IBOutlet UISwitch *myInfoShockSwitch;     //震动

@property (strong, nonatomic) BaseViewController *baseVC;

@end
