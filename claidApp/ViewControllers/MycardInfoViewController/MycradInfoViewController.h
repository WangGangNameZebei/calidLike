//
//  MycradInfoViewController.h
//  claidApp
//
//  Created by kevinpc on 2017/5/6.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "DBTool.h"
#import "ClassUserInfo.h"
#import "SXSearchHeadView.h"


@protocol MycradInfoViewControllerDelegate <NSObject>
@optional
- (void)mycradInfoViewControllerAutomaticSwitchStr:(NSString *)datastr;
@end


@interface MycradInfoViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UISwitch *myInfoshakeSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *myInfoAutomaticSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *myInfoBrightScreenSwitch;
@property (strong, nonatomic) IBOutlet UIView *myInfoNameView;

@property (assign, nonatomic)id<MycradInfoViewControllerDelegate>delegate;

@property (strong, nonatomic) DBTool *dbTool;
@property (strong, nonatomic)ClassUserInfo *infoclassUser;      //数据库类
@property (strong,nonatomic) SXSearchHeadView *selectNameView;
@property (strong, nonatomic) NSMutableArray *myinfoNameArray;

@end
