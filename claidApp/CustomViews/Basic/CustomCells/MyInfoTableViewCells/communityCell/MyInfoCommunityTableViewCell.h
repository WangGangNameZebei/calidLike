//
//  MyInfoCommunityTableViewCell.h
//  claidApp
//
//  Created by Zebei on 2018/2/1.
//  Copyright © 2018年 kevinpc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SXSearchHeadView.h"

#define MY_INFO_COMMUNITY_TABLEVIEW_CELL @"MyInfoCommunityTableViewCell"

@interface MyInfoCommunityTableViewCell : UITableViewCell


@property (strong,nonatomic) SXSearchHeadView *selectNameView;
@property (strong, nonatomic) NSMutableArray *myinfoNameArray;

@end
