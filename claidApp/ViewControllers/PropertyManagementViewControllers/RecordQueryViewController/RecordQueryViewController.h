//
//  RecordQueryViewController.h
//  claidApp
//
//  Created by Zebei on 2017/11/27.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"

@interface RecordQueryViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIView *recordQueryView;
@property (strong, nonatomic) IBOutlet UIButton *yhButton;  //  用户按钮
@property (strong, nonatomic) IBOutlet UIButton *timeButton; //  时间按钮
@property (strong, nonatomic) IBOutlet UIButton *dzButton;  //   地址按钮
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *recordQueryViewheight;

@property (strong, nonatomic) IBOutlet UIView *searchView;
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;

@end
