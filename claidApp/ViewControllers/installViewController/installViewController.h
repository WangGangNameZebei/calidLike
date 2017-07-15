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
#import "SingleTon.h"           //蓝牙
#import "DBTool.h"              //数据库
#import "InstallCardData.h"

@interface installViewController : BaseViewController <UITableViewDelegate,installLanyaDelegate,installViewControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *installTableView;
@property (strong, nonatomic) IBOutlet UILabel *installLanyaLabel;
@property (strong, nonatomic) SingleTon *sinTon;        //蓝牙

@property (strong, nonatomic) installViewControllerDataSource *installVCDataSource;     //刷卡


@property (strong, nonatomic) NSMutableArray *installDataArray;     // 蓝牙卡分类 数组
// 被选中cell的IndexPath;
@property (nonatomic, strong) NSIndexPath *selectIndexPath;
@property (strong, nonatomic)UIAlertView *modifyAlertView;

@property (strong,nonatomic)DBTool *tool;                   //数据库
@property (strong, nonatomic)InstallCardData *installCardData;      //数据库类


@property (assign, nonatomic) BOOL lingminduBool;       //灵敏度
@property (strong, nonatomic)UIView *sensitivityView;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSMutableArray *numberPickerArrar;
@property (strong, nonatomic) UIView *pickerConfirmView;
@property (strong, nonatomic) UIButton *canshuheaderButton;
@property (strong, nonatomic) UIButton *returnButton;
@property (strong, nonatomic) UIButton *confirmButon;
@end
