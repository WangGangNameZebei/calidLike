//
//  installViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2016/11/2.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "installViewController+Configuration.h"
#import "MinFuncTionTableViewCell.h"
#import "SingleTon+tool.h"
#import "UIScreen+Utility.h"
#import "UIColor+Utility.h"
#import "installViewController+Animation.h"

#define SECTIONHEIGHT 70


@implementation installViewController (Configuration)

- (void)configureViews {
    [self myTableViewInitEdit];
    [self lanyaEdit];
    [self installTableHeaderViewEdit];
    [self pickerConfirmEdit];
}
- (void)lanyaEdit {
    self.sinTon = [SingleTon sharedInstance];
    self.sinTon.installDelegate = self;
    
}
- (void)myTableViewInitEdit {
    if (!self.installDataArray) {
        self.installDataArray = [NSMutableArray array];
    }
    NSArray *groupNames = [self installDataArrayEdit];
    [self.installTableView registerNib:[UINib nibWithNibName:@"MinFuncTionTableViewCell" bundle:nil] forCellReuseIdentifier:MINN_FUNCTION_CELL_NIB];
    self.installVCDataSource = [installViewControllerDataSource new];
    self.installVCDataSource.delegate = self;
    self.installTableView.tableHeaderView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0,[UIScreen screenWidth], 60))];
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
    self.tool = [DBTool sharedDBTool];
    NSArray *data = [self.tool selectWithClass:[InstallCardData class] params:nil];
    if (data.count == 0){
      groupNames = @[@[],@[],@[],@[],@[],@[],@[],@[]];
    } else {
        for (int i=0;i<data.count;i++)
        {
            InstallCardData *iCardData = data[i];
            if (iCardData.identification == 12) {
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
        groupNames = [NSArray arrayWithObjects:diZhiArrar,shiJianArrar,tongBuArrar,chuChangArrar,kaiFangArrar,qingkongGuashiArrar,guaShiArrar,jieGuaArrar, nil];
    }
    return groupNames;
}

#pragma mark - 控制板手机灵敏度修改
- (void)installTableHeaderViewEdit {
    self.lingminduBool = NO;
    self.sensitivityView = [[UIView alloc] initWithFrame:self.installTableView.tableHeaderView.frame];
   
     UILabel *xzLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.sensitivityView.frame.size.height / 2  - 10, 200, 20)];
     xzLabel.text = [NSString stringWithFormat:@"设置控制板的灵敏度     :"];
      [self.sensitivityView addSubview:xzLabel];
    
    self.canshuheaderButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.canshuheaderButton setFrame:CGRectMake(210, self.sensitivityView.frame.size.height / 2  - 10, 80, 20)];
      [self.canshuheaderButton addTarget:self action:@selector(canshuheaderButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.canshuheaderButton setTitle:@"选择"forState:UIControlStateNormal];
     [self.canshuheaderButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //设置点击的时候高亮
    self.canshuheaderButton.showsTouchWhenHighlighted = YES;
    [self.sensitivityView addSubview:self.canshuheaderButton];
    
    UIButton *sendButon = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sendButon setFrame:CGRectMake([UIScreen screenWidth]  - 80, self.sensitivityView.frame.size.height / 2 -10, 50, 20)];
     [sendButon addTarget:self action:@selector(sendheaderButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [sendButon.layer setMasksToBounds:YES];
    [sendButon.layer setCornerRadius:8.0];
    [sendButon.layer setBorderWidth:1.0];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace, (CGFloat[]){0.000,0.537,0.506,1});
    [sendButon.layer setBorderColor:colorref];
    
    [sendButon setTitle:@"设置"forState:UIControlStateNormal];
     [sendButon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //设置点击的时候高亮
    self.canshuheaderButton.showsTouchWhenHighlighted = YES;
    [self.sensitivityView addSubview:sendButon];
    
    
    UIView *fGView = [[UIView alloc] initWithFrame:CGRectMake(0, self.sensitivityView.frame.size.height - 1, self.sensitivityView.frame.size.width, 1)];
    fGView.backgroundColor = [UIColor colorFromHexCode:@"#C2C2C2"];
    [self.sensitivityView addSubview:fGView];
    
   [self.installTableView.tableHeaderView addSubview:self.sensitivityView];
   
    self.numberPickerArrar = [[NSMutableArray alloc] initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09", nil];
    
}

- (void)pickerConfirmEdit {
    self.pickerConfirmView = [[UIView alloc] initWithFrame:(CGRectMake(0,[UIScreen screenHeight] + 100, self.view.frame.size.width, 235))];
    self.pickerConfirmView.backgroundColor = [UIColor colorFromHexCode:@"#EAEAEA"];
    self.pickerConfirmView.hidden = YES;
    
    
    self.returnButton = [[UIButton alloc] initWithFrame:(CGRectMake(5, 0, 60, 35))];
    [self.returnButton setTitle:@"返回" forState:UIControlStateNormal];
    [self.returnButton setTitleColor:[UIColor colorFromHexCode:@"#1C86EE"] forState:UIControlStateNormal];
    [self.returnButton addTarget:self action:@selector(pickerReturnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.pickerConfirmView addSubview:self.returnButton];
    
    
    
    self.confirmButon = [[UIButton alloc] initWithFrame:(CGRectMake([UIScreen screenWidth] - 70, 0,60, 35))];
    [self.confirmButon setTitle:@"确认" forState:UIControlStateNormal];
    [self.confirmButon setTitleColor:[UIColor colorFromHexCode:@"#1C86EE"] forState:UIControlStateNormal];
    [self.confirmButon addTarget:self action:@selector(pickerConfirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.pickerConfirmView addSubview:self.confirmButon];
    
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:(CGRectMake(0, self.pickerConfirmView.frame.size.height - 200, [UIScreen screenWidth], 200))];
    self.pickerView.backgroundColor = [UIColor colorFromHexCode:@"#6CA6CD"];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    [self.pickerConfirmView addSubview:self.pickerView];
    
    
    [self.view addSubview:self.pickerConfirmView];

}



- (void)canshuheaderButtonAction:(UIButton *)button {

    if (self.pickerConfirmView.hidden) {
        [self animationShowPickerConfirmView];
    } else {
        [self animationHidePickerConfirmView];
    }
    
}

- (void)sendheaderButtonAction:(UIButton *)button {
    if([self.canshuheaderButton.titleLabel.text isEqualToString:@"选择"]){
         [self promptInformationActionWarningString:@"请选择灵敏度参数"];
    } else {
    SingleTon *ton = [SingleTon sharedInstance];
    NSString *uuidstr = SINGLE_TON_UUID_STR;
    if (!uuidstr) {
        [ton startScan]; //扫描
        return;
    }
    self.lingminduBool =YES;
    [ton installShoudongConnectClick:SINGLE_TON_UUID_STR];
    }
    
}
#pragma mark pickerView 上按钮的方法实现
- (void)pickerReturnAction:(UIButton *)button {
    [self animationHidePickerConfirmView];
    [self.canshuheaderButton setTitle:@"选择" forState:UIControlStateNormal];
}

- (void)pickerConfirmAction:(UIButton *)button {
     [self animationHidePickerConfirmView];
}

#pragma mark UIPickerView
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return [UIScreen screenWidth];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.canshuheaderButton setTitle:[self.numberPickerArrar objectAtIndex:row] forState:UIControlStateNormal];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.numberPickerArrar objectAtIndex:row];
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
- (void)deleteDataCell:(id)sender {
    ZBGroup *group = self.installDataArray[self.selectIndexPath.section];
    NSArray *arr=group.items;
    self.installCardData = arr[self.selectIndexPath.row];
     [self.tool deleteRecordWithClass:[InstallCardData class] andKey:@"installName" isEqualValue:self.installCardData.installName];
    [self refreshInstallTableView];
}

- (void)handleCopyCell:(id)sender{
    self.modifyAlertView = [[UIAlertView alloc] initWithTitle:@"请输入备注" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [self.modifyAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    UITextField *nameField = [self.modifyAlertView textFieldAtIndex:0];
     nameField.placeholder = @"您的备注是..";
    [self.modifyAlertView show];

   // [self.installTableView reloadData];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        UITextField *nameField = [alertView textFieldAtIndex:0];
        ZBGroup *group = self.installDataArray[self.selectIndexPath.section];
        NSArray *arr=group.items;
        self.installCardData = arr[self.selectIndexPath.row];
        
        InstallCardData * iCData = [InstallCardData initinstallNamestr:nameField.text installData:self.installCardData.installData identification:self.installCardData.identification];
        [self.tool updateWithObj:iCData andKey:@"installName" isEqualValue:self.installCardData.installName];
        [self refreshInstallTableView];
    }
    
    
}
// 用于UIMenuController显示，缺一不可
-(BOOL)canBecomeFirstResponder{
    return YES;
}
// 用于UIMenuController显示，缺一不可
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action ==@selector(handleCopyCell:) || action ==@selector(deleteDataCell:)){
        return YES;
    }
    return NO;//隐藏系统默认的菜单项
}

#pragma mark - 蓝牙 Delegate
- (void)installDoSomethingtishiFrame:(NSString *)string {
    if ([string isEqualToString:@"设置成功"]){
        [self refreshInstallTableView];
    } else if ([string isEqualToString:@"已连接"] || [string isEqualToString:@"已断开"]){
      self.installLanyaLabel.text = string;
    } else {
       [self promptInformationActionWarningString:string];
    }
}
- (void)installEditInitPeripheralData:(NSInteger)data {
    if (data == 1) {
        
        if (self.lingminduBool){
            NSString *message = self.canshuheaderButton.titleLabel.text;
            if ([message isEqualToString:@"01"]){
                message = @"00";
            }
            message = [NSString stringWithFormat:@"%@0181000101FF%@00000000000000000000000000000000000000000000000000000000000000000000",@"cc",message];
            [self.sinTon sendCommand:message];       //发送控制板灵敏度
            self.lingminduBool = NO;
        } else{
          NSString *message = @"0180010101FF3344556600000000000000000000000000000000000000000000000000000000000000";
          message = [NSString stringWithFormat:@"%@%@",@"cc",message];
             [self.sinTon sendCommand:message];       //发送数据
        }
       
    } else if (data == 2){
         [self.sinTon installShoudongConnectClick:SINGLE_TON_UUID_STR];
    } else if (data == 3){
        [self promptInformationActionWarningString:@"设置成功！"];
    
    } else if (data == 4) {     //扫描到 发卡器  去连接
        [self.sinTon shoudongConnectClick:FAKAQI_TON_UUID_STR];
    
    } else {
        ZBGroup *group = self.installDataArray[self.selectIndexPath.section];
        NSArray *arr=group.items;
        self.installCardData = arr[self.selectIndexPath.row];
        NSString *strOne = [self.installCardData.installData substringWithRange:NSMakeRange(0,104)];
        NSString *strTow = [[SingleTon sharedInstance] jiamiaTostringAcction:strOne numberKey:data];
        strTow = [NSString stringWithFormat:@"%@%@",strTow,[[SingleTon sharedInstance] jiamiaTostringAcction:[self.installCardData.installData substringWithRange:NSMakeRange(104, 104)] numberKey:data]];
        [self.sinTon sendCommand:[NSString stringWithFormat:@"AA%@",strTow]];     //发送数据
    }
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
    NSArray *nameArray=@[@" 地址卡",@" 时间卡",@" 同步卡",@" 出厂卡",@" 开放卡",@" 清空挂失卡",@" 挂失卡",@" 解挂卡"];
    nameLabel.text=nameArray[section];
    //添加view显示内容数量
    UIView *numberView=[[UIView alloc] initWithFrame:CGRectMake([UIScreen screenWidth] - 50, (SECTIONHEIGHT-25)/2, 25, 25)];
    numberView.backgroundColor = [UIColor colorFromHexCode:@"#1296db"];
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
    FGView.backgroundColor = [UIColor colorFromHexCode:@"#C2C2C2"];
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
//button的响应点击事件
- (void) buttonClicked:(UIButton *) sender {
    //改变模型数据里面的展开收起状态
    ZBGroup *group2 = self.installDataArray[sender.tag - 200];
    group2.folded = !group2.isFolded;
    [self.installTableView reloadData];
}
///刷新 installView
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
@end
