//
//  installViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2016/11/2.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "installViewController+Configuration.h"
#import "MinFuncTionTableViewCell.h"
#import "CalidTool.h"
#import "UIScreen+Utility.h"
#import "UIColor+Utility.h"
#import "installViewController+Animation.h"
#import "installViewController+LogicalFlow.h"

#define SECTIONHEIGHT 70


@implementation installViewController (Configuration)

- (void)configureViews {
    [self myTableViewInitEdit];
    [self lanyaEdit];
    [self installTableHeaderViewEdit];
    [self installTableHeaderConfirmtheobjectEdit];
    [self refreshInstallTableView];         //刷新控制器 修改样式
}
#pragma mark - 蓝牙初始化
- (void)lanyaEdit {
    self.sinTon = [InstallWardensingleTon iwsharedInstance];
    [self.sinTon iwinitialization];
    self.sinTon.installDelegate = self;
}
#pragma mark - tableView初始化
- (void)myTableViewInitEdit {
    if (!self.installDataArray) {
        self.installDataArray = [NSMutableArray array];
    }
    NSArray *groupNames = [self installDataArrayEdit];
    [self.installTableView registerNib:[UINib nibWithNibName:@"MinFuncTionTableViewCell" bundle:nil] forCellReuseIdentifier:MINN_FUNCTION_CELL_NIB];
    self.installVCDataSource = [installViewControllerDataSource new];
    self.installVCDataSource.delegate = self;
    self.installTableView.tableFooterView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0,[UIScreen screenWidth], 50))];
    self.installTableView.delegate = self;
    self.installTableView.dataSource = self.installVCDataSource;
    
    //这是一个分组的模型类
    for (NSMutableArray *name in groupNames) {
        ZBGroup *group1 = [[ZBGroup alloc] initWithItem:name];
        [self.installDataArray addObject:group1];
    }
    self.installVCDataSource.installDataArray = self.installDataArray;
    
}
- (NSArray *)installDataArrayEdit {
    NSArray *groupNames = [NSArray array];
    NSMutableArray *diZhiArrar = [NSMutableArray array];
    NSMutableArray *shiJianArrar = [NSMutableArray array];
    NSMutableArray *tongBuArrar = [NSMutableArray array];
    NSMutableArray *chuChangArrar = [NSMutableArray array];
    NSMutableArray *kaiFangArrar = [NSMutableArray array];
    NSMutableArray *qingkongGuashiArrar = [NSMutableArray array];
    NSMutableArray *guaShiArrar = [NSMutableArray array];
    NSMutableArray *jieGuaArrar = [NSMutableArray array];
    NSMutableArray *yonghuArrar = [NSMutableArray array];
    self.tool = [DBTool sharedDBTool];
    NSArray *data = [self.tool selectWithClass:[InstallCardData class] params:nil];
    if (data.count == 0){
      groupNames = @[@[],@[],@[],@[],@[],@[],@[],@[],@[]];
    } else {
        for (int i=0;i<data.count;i++)
        {
            InstallCardData *iCardData = data[i];
            if (iCardData.identification == 02){
               [yonghuArrar addObject:data[i]];
            }else if (iCardData.identification == 12) {
                [diZhiArrar addObject:data[i]];
            } else if (iCardData.identification == 22) {
                [shiJianArrar addObject:data[i]];
            } else if (iCardData.identification == 32) {
                [tongBuArrar addObject:data[i]];
            } else if (iCardData.identification == 42) {
                [chuChangArrar addObject:data[i]];
            } else if (iCardData.identification == 52) {
                [kaiFangArrar addObject:data[i]];
            } else if (iCardData.identification == 62) {
                [qingkongGuashiArrar addObject:data[i]];
            } else if (iCardData.identification == 72) {
                [guaShiArrar addObject:data[i]];
            } else {
                [jieGuaArrar addObject:data[i]];
            }
            
        }
       
        groupNames = [NSArray arrayWithObjects:chuChangArrar,tongBuArrar,diZhiArrar,shiJianArrar,yonghuArrar,kaiFangArrar,guaShiArrar,jieGuaArrar,qingkongGuashiArrar, nil];
    }
    if (chuChangArrar.count < 1){           //出厂卡 有数据事才可以设置 灵敏度
        [self lingminduEditAction:NO];
    } else {
        [self lingminduEditAction:YES];
    }
    
    return groupNames;
}

#pragma mark - 控制板手机灵敏度修改
- (void)installTableHeaderViewEdit {
    self.lingminduBool = NO;
    self.setupBool = NO;
    self.restoreBool = NO;
    self.sensitivityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.installTableView.tableFooterView.frame.size.width, self.installTableView.tableFooterView.frame.size.height)];
   
     UILabel *xzLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.sensitivityView.frame.size.height / 2  - 10, 182, 20)];
     xzLabel.text = [NSString stringWithFormat:@"设备灵敏度设置      :"];
      [self.sensitivityView addSubview:xzLabel];
    
    self.canshuheaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(195, self.sensitivityView.frame.size.height / 2  - 10, 50, 20)];
    self.canshuheaderLabel.text =[NSString stringWithFormat:@"未知"];
    
    [self.sensitivityView addSubview:self.canshuheaderLabel];
    
    self.restoreButon = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.restoreButon setFrame:CGRectMake([UIScreen screenWidth]  - 140, self.sensitivityView.frame.size.height / 2 -10, 50, 20)];
    [self.restoreButon addTarget:self action:@selector(restoreheaderButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.restoreButon.layer setMasksToBounds:YES];
    [self.restoreButon.layer setCornerRadius:8.0];

    [self.restoreButon setTitle:@"恢复"forState:UIControlStateNormal];
    [self.restoreButon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.sensitivityView addSubview:self.restoreButon];
    
    
    
    self.sendButon = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.sendButon setFrame:CGRectMake([UIScreen screenWidth]  - 70, self.sensitivityView.frame.size.height / 2 -10, 50, 20)];
     [self.sendButon addTarget:self action:@selector(sendheaderButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.sendButon.layer setMasksToBounds:YES];
    [self.sendButon.layer setCornerRadius:8.0];
    [self.sendButon setTitle:@"设置"forState:UIControlStateNormal];
     [self.sendButon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.sensitivityView addSubview:self.sendButon];
    
    
    UIView *fGView = [[UIView alloc] initWithFrame:CGRectMake(0, self.sensitivityView.frame.size.height - 1, self.sensitivityView.frame.size.width, 1)];
    fGView.backgroundColor = [UIColor setupGreyColor];
    [self.sensitivityView addSubview:fGView];
    
    [self.installTableView.tableFooterView addSubview:self.sensitivityView];
    
}
#pragma mark -灵敏度按钮样视切换
- (void)lingminduEditAction:(BOOL)boolData{
    self.qunxianBool = boolData;
    if(boolData){
        self.sendButon.backgroundColor = [UIColor setipBlueColor];
        self.restoreButon.backgroundColor = [UIColor setipBlueColor];
        self.querenButon.backgroundColor = [UIColor whiteColor];
        [self.querenButon.layer setBorderColor:[UIColor setipBlueColor].CGColor];
    } else {
        self.sendButon.backgroundColor = [UIColor setupGreyColor];
        self.restoreButon.backgroundColor = [UIColor setupGreyColor];
        self.querenButon.backgroundColor = [UIColor setupGreyColor];
        [self.querenButon.layer setBorderColor:[UIColor setupGreyColor].CGColor];
    }
    
}

#pragma mark - 连接控制板确认按钮编辑
- (void)installTableHeaderConfirmtheobjectEdit {

    self.querenButon = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.querenButon setFrame:CGRectMake(0, 0, self.setupView.frame.size.width,  self.setupView.frame.size.height)];
    [self.querenButon addTarget:self action:@selector(qurenKongzhibanButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.querenButon.layer setMasksToBounds:YES];
    [self.querenButon.layer setBorderWidth:0.8];

    [self.querenButon setTitle:@"   请先选择设备 听到'滴'声选择YES/NO"forState:UIControlStateNormal];
    [self.querenButon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.querenButon.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    self.querenButon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.setupView addSubview:self.querenButon];

    
}     

#pragma mark - 控制板手机灵敏度修改 按钮方法
- (void)sendheaderButtonAction:(UIButton *)button {
    if (self.qunxianBool && self.setupBool){
        UIAlertView *jinggaoAlertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"设置后，有可能断开链接，若继续设置需重新选择设备！" delegate:self cancelButtonTitle:@"稍后再试" otherButtonTitles:@"确定", nil];
        jinggaoAlertView.tag = 2;
        [jinggaoAlertView show];
    }
}
- (void)restoreheaderButtonAction:(UIButton *)button {
    if (self.qunxianBool && self.setupBool){
        NSString *message = [NSString stringWithFormat:@"%@0181000101FF09%@000000000000000000000000000000000000000000000000000000000000",@"cc",@"00147369"];//[self userInfoReaduserkey:@"districtNumber"]   修改的
        [self.sinTon iwsendCommand:message];       //发送控制板灵敏度
        if (!self.restoreBool) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self doSomeWorkWithProgress:0.2f];
            });
            
        }
        self.restoreBool = YES;
        self.lingminduBool =YES;
 
    }
}
#pragma mark -确认控制板 按钮方法
- (void)qurenKongzhibanButtonAction:(UIButton *)button {
    if (self.qunxianBool){
        NSString *message = @"d0446973636f6e6e656374696e67000000000000";
        [self.sinTon iwsendCommand:message];       //发送数据
      //  [self.sinTon iwdisConnection];       //  断开蓝牙
        [self userInfowriteuserkey:@"setupNumber" uservalue:@"0000"];  //修改随机数
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 0.6s后自动执行这个block里面的代码
            NSString *uuidstr = SINGLE_TON_UUID_STR;
            if (!uuidstr) {
                [self.sinTon iwstartScan]; //扫描
                return;
            }
            self.restoreBool = NO;
            self.lingminduBool =NO;
            [self.sinTon iwinstallShoudongConnectClick:SINGLE_TON_UUID_STR];
        });

    } else {
       [self promptInformationActionWarningString:@"请先发出厂卡!"];
    }
}



#pragma mark - cell 长按代理
- (void)installLongPress:(UIGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self.installTableView];
    self.selectIndexPath = [self.installTableView indexPathForRowAtPoint:location];
    MinFuncTionTableViewCell *cell = (MinFuncTionTableViewCell *)recognizer.view;
    //这里把cell做为第一响应(cell默认是无法成为responder,需要重写canBecomeFirstResponder方法)
    [cell becomeFirstResponder];
    
    UIMenuItem *itCopy = [[UIMenuItem alloc] initWithTitle:@"修改备注" action:@selector(handleCopyCell:)];
    UIMenuItem *itDelete = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteDataCell:)];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuItems:[NSArray arrayWithObjects:itCopy,itDelete,nil]];
    [menu setTargetRect:cell.frame inView:self.installTableView];
    [menu setMenuVisible:YES animated:YES];
    
}
#pragma mark -  删除一条数据
- (void)deleteDataCell:(id)sender {
    ZBGroup *group = self.installDataArray[self.selectIndexPath.section];
    NSArray *arr=group.items;
    self.installCardData = arr[self.selectIndexPath.row];
     [self.tool deleteRecordWithClass:[InstallCardData class] andKey:@"installName" isEqualValue:self.installCardData.installName];
    [self refreshInstallTableView];
}
#pragma mark -  修改备注
- (void)handleCopyCell:(id)sender{
    self.modifyAlertView = [[UIAlertView alloc] initWithTitle:@"请输入备注" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    self.modifyAlertView.tag = 0;
    [self.modifyAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    UITextField *nameField = [self.modifyAlertView textFieldAtIndex:0];
     nameField.placeholder = @"您的备注是..";
    [self.modifyAlertView show];

   // [self.installTableView reloadData];
}
#pragma mark - AlertView  代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 0){  //修改备注
       if (buttonIndex == alertView.firstOtherButtonIndex) {
          UITextField *nameField = [alertView textFieldAtIndex:0];
          ZBGroup *group = self.installDataArray[self.selectIndexPath.section];
          NSArray *arr=group.items;
          self.installCardData = arr[self.selectIndexPath.row];
        
          InstallCardData * iCData = [InstallCardData initinstallNamestr:nameField.text installData:self.installCardData.installData identification:self.installCardData.identification];
          [self.tool updateWithObj:iCData andKey:@"installName" isEqualValue:self.installCardData.installName];
          [self refreshInstallTableView];
      }
    } else if (alertView.tag == 2) {
        if (buttonIndex == alertView.firstOtherButtonIndex) {
            self.canshuheaderLabel.text =[NSString stringWithFormat:@"9"];
            [self shezhilingminduAction];
            [self determinateExample];
        }
   } else {
        if (buttonIndex == alertView.cancelButtonIndex) {
              NSString *message = @"d0446973636f6e6e656374696e67000000000000";
            [self.sinTon iwsendCommand:message];       //发送数据
           [self userInfowriteuserkey:@"setupNumber" uservalue:@"0000"];  //修改随机数
        } else {
            self.setupBool = YES;  //链接蓝牙
        }
    }
    
}
#pragma mark -  用于UIMenuController显示，缺一不可
-(BOOL)canBecomeFirstResponder{
    return YES;
}
#pragma mark -  用于UIMenuController显示，缺一不可
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action ==@selector(handleCopyCell:) || action ==@selector(deleteDataCell:)){
        return YES;
    }
    return NO;//隐藏系统默认的菜单项
}

#pragma mark - 蓝牙 Delegate
- (void)iwinstallDoSomethingtishiFrame:(NSString *)string {
    if ([string isEqualToString:@"发卡成功"]){
        [self refreshInstallTableView];
    } else if ([string isEqualToString:@"已连接"] || [string isEqualToString:@"已断开"]){
       self.installLanyaLabel.text = string;
        if([string isEqualToString:@"已连接"]) {
            [self.sinTon iwsendCommand:@"99"];       //发送数据
        }
    } else if (string.length == 106  && [[string substringWithRange:NSMakeRange(0,2)] isEqualToString:@"bb"]){
        [self checkStatusOfCardPOSTdataStr:[string substringWithRange:NSMakeRange(2,104)]];
      
    } else if ([string isEqualToString:@"eebb1122330a"] ){
       [self.sinTon iwdisConnection];       //  断开蓝牙
        [self promptInformationActionWarningString:@"设置错误!"];
        
    } else if ([string isEqualToString:@"eebb1122330b"] ){
        
         self.querenAlertView = [[UIAlertView alloc] initWithTitle:@"请您确认设备是否正确?" message:nil delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
         self.querenAlertView.tag = 1;

        [self.querenAlertView show];
        
        
    } else if ([string isEqualToString:@"设置成功!"]) {
        [self promptInformationActionWarningString:string];
    } else {
    
       [self promptInformationActionWarningString:string];
        
    }
}

- (void)iwinstallEditInitPeripheralData:(NSInteger)data {
    if (data == 1) {
        
        if (self.lingminduBool){
           NSString *message = [NSString stringWithFormat:@"%@0181000101FF09%@000000000000000000000000000000000000000000000000000000000000",@"cc",@"00147369"];//[self userInfoReaduserkey:@"districtNumber"]
            [self.sinTon iwsendCommand:message];       //发送控制板灵敏度
            if (!self.restoreBool) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self doSomeWorkWithProgress:0.2f];
                });

            }
            
        } else{
          NSString *message = @"0180010101FF3344556601000000000000000000000000000000000000000000000000000000000000";
          message = [NSString stringWithFormat:@"%@%@",@"cc",message];
             [self.sinTon iwsendCommand:message];       //发送数据
        }
       
    } else if (data == 2){
         [self.sinTon iwinstallShoudongConnectClick:SINGLE_TON_UUID_STR];
    } else if (data == 3){          //设置卡
          if (self.restoreBool && self.lingminduBool) {  //恢复
                  self.canshuheaderLabel.text = @"9";
                  [self promptInformationActionWarningString:@"恢复成功！"];
              self.restoreBool = NO;
              return;
          }
        if (self.lingminduTimer){
            [self.lingminduTimer invalidate];    // 释放函数
            self.lingminduTimer = nil;
        }
        if (self.lingminduTowTimer){
            [self.lingminduTowTimer invalidate];    // 释放函数
            self.lingminduTowTimer = nil;
        }

         self.lingminduTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(lingminduAction) userInfo:nil repeats:NO];
        NSString *message = self.canshuheaderLabel.text;
        self.canshuheaderLabel.text = [NSString stringWithFormat:@"%ld",[message integerValue] - 1];
        message = self.canshuheaderLabel.text;
        
        float progress =1.1f -[[NSString stringWithFormat:@"0.%@",message] floatValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self doSomeWorkWithProgress:progress];
        });
        
       if ([message integerValue]< 1){
            [self lingminduAction];
            if (self.lingminduTimer){
                [self.lingminduTimer invalidate];    // 释放函数
                self.lingminduTimer = nil;
            }
            return;
        }
        message = [NSString stringWithFormat:@"%@0181000101FF0%@%@000000000000000000000000000000000000000000000000000000000000",@"cc",message,@"00147369"];//[self userInfoReaduserkey:@"districtNumber"]
        [self.sinTon iwsendCommand:message];       //发送控制板灵敏度

    } else if (data == 4) {     //扫描到 发卡器  去连接
        [self.sinTon iwshoudongConnectClick:FAKAQI_TON_UUID_STR];
    
    } else if (data == 5) {     // 设置灵敏度 失败
        if (self.lingminduTimer){
            [self.lingminduTimer invalidate];    // 释放函数
            self.lingminduTimer = nil;
        }
        if (self.lingminduTowTimer){
            [self.lingminduTowTimer invalidate];    // 释放函数
            self.lingminduTowTimer = nil;
        }

        if (!self.restoreBool) {
            dispatch_async(dispatch_get_main_queue(), ^{
            [self.progressHUD hide:YES];
            });
        }
        self.lingminduBool = NO;
        self.restoreBool = NO;
        [self promptInformationActionWarningString:@"设置失败！"];
    } else if (data == 6) { // 蓝牙断开链接
         self.setupBool = NO;
    }else {

        ZBGroup *group = self.installDataArray[self.selectIndexPath.section];
        NSArray *arr=group.items;
        self.installCardData = arr[self.selectIndexPath.row];
        NSString *strOne = [self.installCardData.installData substringWithRange:NSMakeRange(0,104)];
        NSString *strTow = [CalidTool jiamiaTostringAcction:strOne numberKey:data];
        strTow = [NSString stringWithFormat:@"%@%@",strTow,[CalidTool  jiamiaTostringAcction:[self.installCardData.installData substringWithRange:NSMakeRange(104, 104)] numberKey:data]];
        [self.sinTon iwsendCommand:[NSString stringWithFormat:@"AA%@",strTow]];     //发送数据
   
    }
}
#pragma mark - 灵敏度 设置 连接 
- (void)shezhilingminduAction {
    self.lingminduTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(lingminduAction) userInfo:nil repeats:NO];
    NSString *message = [NSString stringWithFormat:@"%@0181000101FF09%@000000000000000000000000000000000000000000000000000000000000",@"cc",@"00147369"];//[self userInfoReaduserkey:@"districtNumber"]
    [self.sinTon iwsendCommand:message];       //发送控制板灵敏度
    if (!self.restoreBool) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self doSomeWorkWithProgress:0.2f];
        });
        
    }
     self.restoreBool = NO;
    self.lingminduBool =YES;

}
#pragma mark - 灵敏度 第一个定时器函数
- (void)lingminduAction {
    self.lingminduTowTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(lingminduTowAction) userInfo:nil repeats:NO];
    
   
    NSString *message = self.canshuheaderLabel.text;
   if ([message integerValue] < 1){
        [self lingminduTowAction];
        if (self.lingminduTowTimer){
            [self.lingminduTowTimer invalidate];    // 释放函数
            self.lingminduTowTimer = nil;
        }
       return;
    }
    message = [NSString stringWithFormat:@"%@0181000101FF0%@%@000000000000000000000000000000000000000000000000000000000000",@"cc",message,@"00147369"]; //[self userInfoReaduserkey:@"districtNumber"]
    [self.sinTon iwsendCommand:message];       //发送控制板灵敏度

    
    
}
#pragma mark -  灵敏度 第二个定时器函数
- (void)lingminduTowAction {
    self.lingminduBool = NO;
    NSString *message = self.canshuheaderLabel.text;
    if ([message integerValue] < 9){
        if ([message integerValue] < 2) {
            self.canshuheaderLabel.text = @"2";
        } else {
            self.canshuheaderLabel.text = [NSString stringWithFormat:@"%ld",[message integerValue] + 1];
        }
       
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
         [self doSomeWorkWithProgress:1.0f];
       [self.progressHUD hide:YES];
    });
    [self promptInformationActionWarningString:@"设置成功！"];

}
#pragma mark - UITableView Delegate
//设置headerView高度
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return SECTIONHEIGHT;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //首先创建一个大的view，nameview
    UIView *nameView=[[UIView alloc]init];
    //将分组的名字nameLabel添加到nameview上
    UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(40, 0, [UIScreen screenWidth] - 100, SECTIONHEIGHT)];
    [nameView addSubview:nameLabel];
    nameView.layer.borderWidth=0.2;
    nameView.backgroundColor = [UIColor whiteColor];
    nameView.layer.borderColor=[UIColor grayColor].CGColor;
    NSArray *nameArray=@[@" 出厂卡",@" 同步卡",@" 地址卡",@" 时间卡",@"  用户卡",@" 开放卡",@" 挂失卡",@" 解挂卡",@" 清空挂失卡"];
    nameLabel.text=nameArray[section];
    //添加view显示内容数量
    UIView *numberView=[[UIView alloc] initWithFrame:CGRectMake([UIScreen screenWidth] - 50, (SECTIONHEIGHT-25)/2, 25, 25)];
    numberView.backgroundColor = [UIColor setipBlueColor];
    [nameView addSubview:numberView];
    UILabel *numberLabel=[[UILabel alloc]initWithFrame:numberView.bounds];
    numberLabel.textColor = [UIColor whiteColor];
    numberLabel.textAlignment = NSTextAlignmentCenter;  //居中
    [numberView addSubview:numberLabel];
    numberView.layer.masksToBounds = YES;
    numberView.layer.cornerRadius = 25/2;
    ZBGroup *numbergroup = self.installDataArray[section];
    NSArray *NArr=numbergroup.items;
    numberLabel.text= [NSString stringWithFormat:@"%ld",(unsigned long)NArr.count];
    //割线
    UIView *FGView=[[UIView alloc] initWithFrame:CGRectMake(0, SECTIONHEIGHT-1,[UIScreen screenWidth], 1)];
    FGView.backgroundColor = [UIColor setupGreyColor];
    [nameView addSubview:FGView];
    //添加一个button用于响应点击事件（展开还是收起）
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, self.view.frame.size.width, SECTIONHEIGHT);
    [nameView addSubview:button];
    button.tag = 200 + section;
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    //将显示展开还是收起的状态通过三角符号显示出来
    UIImageView *fuhao=[[UIImageView alloc]initWithFrame:CGRectMake(10, (SECTIONHEIGHT-20)/2, 20, 20)];
    fuhao.tag=section;
    [nameView addSubview:fuhao];
    //根据模型里面的展开还是收起变换图片
    ZBGroup *group = self.installDataArray[section];
    if (group.isFolded==YES) {
        fuhao.image=[UIImage imageNamed:@"left_gray"];
    }else{
        fuhao.image=[UIImage imageNamed:@"under_gray"];
    }
    
    //返回nameView
    return nameView;
}
#pragma mark - button的响应点击事件
- (void) buttonClicked:(UIButton *) sender {
    //改变模型数据里面的展开收起状态
    ZBGroup *group2 = self.installDataArray[sender.tag - 200];
    group2.folded = !group2.isFolded;
    [self.installTableView reloadData];
}
#pragma mark - 刷新 installView
- (void)refreshInstallTableView {
    NSArray *groupNames = [self installDataArrayEdit];
    [self.installDataArray removeAllObjects];
    //这是一个分组的模型类
    for (NSMutableArray *name in groupNames) {
        ZBGroup *group1 = [[ZBGroup alloc] initWithItem:name];
        [self.installDataArray addObject:group1];
    }
    self.installVCDataSource.installDataArray = self.installDataArray;
    [self.installTableView reloadData];
}

#pragma mark - 圆环进度条+文字
- (void)determinateExample {
    
   self.progressHUD  = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    self.progressHUD.mode = MBProgressHUDModeAnnularDeterminate;

     self.progressHUD.labelText = NSLocalizedString(@"设置中...", @"设置中");
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self doSomeWorkWithProgress:0.1f];
    });
    
}
#pragma mark -  进度条 动画
- (void)doSomeWorkWithProgress:(float)progress{
    // This just increases the progress indicator in a loop.
    float progressfloat = [MBProgressHUD HUDForView:self.navigationController.view].progress;
    while (progressfloat < progress) {
        progressfloat += 0.01f;
        dispatch_async(dispatch_get_main_queue(), ^{
            // Instead we could have also passed a reference to the HUD
            // to the HUD to myProgressTask as a method parameter.
            [MBProgressHUD HUDForView:self.navigationController.view].progress = progressfloat;
        });
        usleep(50000);
    }
}
@end
