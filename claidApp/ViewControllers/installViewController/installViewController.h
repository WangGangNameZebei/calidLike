//
//  installViewController.h
//  claidApp
//
//  Created by kevinpc on 2016/11/2.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "installViewControllerDataSource.h"
#import "installLanyaDataSource.h"
#import "InstallLanyaDataDelegate.h"
#import "ZBGroup.h"
#import "SingleTon.h"           //蓝牙
#import "DBTool.h"              //数据库
#import "InstallCardData.h"
@interface installViewController : BaseViewController <UITableViewDelegate,installLanyaDelegate,installViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *installTableView;
@property (strong, nonatomic) IBOutlet UITableView *lanyaTableView;
@property (strong, nonatomic) SingleTon *sinTon;        //蓝牙

@property (strong, nonatomic) installViewControllerDataSource *installVCDataSource;     //刷卡
@property (strong, nonatomic) installLanyaDataSource *iLanyaDataSource;     //蓝牙
@property (strong, nonatomic) InstallLanyaDataDelegate *iLanyaDelegate;     //蓝牙名字

@property (strong, nonatomic) NSMutableArray *installDataArray;     // 蓝牙卡分类 数组
@property (strong, nonatomic) NSMutableArray *lanyaNameArray;       //蓝牙名字数组
// 被选中cell的IndexPath;
@property (nonatomic, strong) NSIndexPath *selectIndexPath;
@property (strong, nonatomic)UIAlertView *modifyAlertView;

@property (strong,nonatomic)DBTool *tool;                   //数据库
@property (strong, nonatomic)InstallCardData *installCardData;      //数据库类

@end
