//
//  installViewController.h
//  claidApp
//
//  Created by kevinpc on 2016/11/2.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "installViewControllerDataSource.h"
#import "ZBGroup.h"
#import "InstallWardensingleTon.h"           //蓝牙
#import "DBTool.h"              //数据库
#import "InstallCardData.h"
#import <MBProgressHUD.h>


@interface installViewController : BaseViewController <UITableViewDelegate,installLanyaDelegate,installViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *installTableView;
@property (strong, nonatomic) IBOutlet UILabel *installLanyaLabel;
@property (strong, nonatomic) IBOutlet UIView *setupView;  //确认控制板 View
@property (strong, nonatomic)InstallWardensingleTon *sinTon;        //蓝牙

@property (strong, nonatomic) installViewControllerDataSource *installVCDataSource;     //刷卡


@property (strong, nonatomic) NSMutableArray *installDataArray;     // 蓝牙卡分类 数组
// 被选中cell的IndexPath;
@property (nonatomic, strong) NSIndexPath *selectIndexPath;
@property (strong, nonatomic)UIAlertView *modifyAlertView;
@property (strong, nonatomic)UIAlertView *querenAlertView;
@property (strong,nonatomic)DBTool *tool;                   //数据库
@property (strong, nonatomic)InstallCardData *installCardData;      //数据库类

@property (strong, nonatomic) NSTimer * lingminduTimer; //设置灵敏度 定时器
@property (strong, nonatomic) NSTimer * lingminduTowTimer; //第二次 定时器
@property (assign, nonatomic) BOOL setupBool;       //设置卡链接标识
@property (assign, nonatomic) BOOL lingminduBool;       //灵敏度
@property (assign, nonatomic) BOOL restoreBool;       //恢复灵敏度
@property (assign, nonatomic) BOOL qunxianBool;         //设置灵敏度的权限
@property (strong, nonatomic) UIButton *restoreButon;       //恢复按钮
@property (strong, nonatomic) UIButton *sendButon;          //设置按钮
@property (strong, nonatomic) UIButton *querenButon;        //确认控制板按钮
@property (strong, nonatomic)UIView *sensitivityView;
@property (strong, nonatomic) UILabel *canshuheaderLabel;
@property (strong, nonatomic) MBProgressHUD *progressHUD;



@end
