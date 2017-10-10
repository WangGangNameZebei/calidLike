//
//  VisitorViewController.h
//  claidApp
//
//  Created by kevinpc on 2017/1/16.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "VisitorSingleTon.h"
#import "VisitorViewControllerDataSource.h"
#import "VisitorCalss.h"
#import "DBTool.h"

@interface VisitorViewController : BaseViewController <UITableViewDelegate,UITextFieldDelegate,VisitorDataToVCDelegate>
@property (strong, nonatomic) IBOutlet UIButton *returnButton;
@property (strong, nonatomic) IBOutlet UIView *visitorView;
@property (strong, nonatomic) IBOutlet UITextField *visitorTextField;
@property (strong, nonatomic) IBOutlet UIImageView *visitorImageView;
@property (strong, nonatomic) IBOutlet UIButton *shukaButton;
@property (strong, nonatomic) IBOutlet UIView *ownerChoiceView;     //访客选择View
@property (strong, nonatomic) IBOutlet UITableView *visitorTableView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ownerChoiceViewTopConstraint;        //访客选择 View约束


@property (strong, nonatomic) VisitorSingleTon *visitorton;
@property (strong,nonatomic)DBTool *tool;                   //数据库
@property (strong, nonatomic)VisitorCalss *visitorClassData;      //数据库类
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSArray *readDataArr;
@property (strong, nonatomic) VisitorCalss *viReadClass;
@property (assign, nonatomic) BOOL readBool;   //数据库请求请求标识;
@property (assign, nonatomic) BOOL requestBool;   //网络数据请求标识;
@property (strong, nonatomic) VisitorViewControllerDataSource *visitorViewControllerDataSource;

@end
