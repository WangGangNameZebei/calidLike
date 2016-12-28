//
//  installViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2016/11/2.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "installViewController+Configuration.h"
#import "MinFuncTionTableViewCell.h"

#import "UIScreen+Utility.h"
#import "UIColor+Utility.h"

#define SECTIONHEIGHT 70


@implementation installViewController (Configuration)

- (void)configureViews {
    [self myTableViewInitEdit];
    [self lanyaTableViewEdit];
}
- (void)lanyaTableViewEdit {
    self.lanyaNameArray = [NSMutableArray array];
    self.sinTon = [SingleTon sharedInstance];
    self.sinTon.installDelegate = self;
    
     [self.lanyaTableView registerNib:[UINib nibWithNibName:@"MinFuncTionTableViewCell" bundle:nil] forCellReuseIdentifier:MINN_FUNCTION_CELL_NIB];
    self.iLanyaDataSource = [installLanyaDataSource new];
    self.iLanyaDelegate = [InstallLanyaDataDelegate new];
    self.lanyaTableView.delegate = self.iLanyaDelegate;
    self.lanyaTableView.dataSource = self.iLanyaDataSource;
    self.iLanyaDataSource.lanyaNameArray = self.lanyaNameArray;
    
}
- (void)myTableViewInitEdit {
    if (!self.installDataArray) {
        self.installDataArray = [NSMutableArray array];
    }
      NSArray *groupNames = @[@[@"出厂1",@"出厂2"],@[@"时间1",@"时间2"],@[@"同步1",@"同步2"],@[@"地址1",@"地址2",@"地址3",@"地址4",@"地址5",@"地址6",@"地址7",@"地址8"]];
   [self.installTableView registerNib:[UINib nibWithNibName:@"MinFuncTionTableViewCell" bundle:nil] forCellReuseIdentifier:MINN_FUNCTION_CELL_NIB];
    self.installVCDataSource = [installViewControllerDataSource new];
    self.installVCDataSource.delegate = self;
    self.installTableView.delegate = self;
    self.installTableView.dataSource = self.installVCDataSource;
    
  
    //这是一个分组的模型类
    for (NSMutableArray *name in groupNames) {
        ZBGroup *group1 = [[ZBGroup alloc] initWithItem:name];
        [self.installDataArray addObject:group1];
    }
    self.installVCDataSource.installDataArray = self.installDataArray;
    
}
#pragma mark - cell 长按代理
- (void)installLongPress:(UIGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self.installTableView];
    self.selectIndexPath = [self.installTableView indexPathForRowAtPoint:location];
    MinFuncTionTableViewCell *cell = (MinFuncTionTableViewCell *)recognizer.view;
    //这里把cell做为第一响应(cell默认是无法成为responder,需要重写canBecomeFirstResponder方法)
    [cell becomeFirstResponder];
    
    UIMenuItem *itCopy = [[UIMenuItem alloc] initWithTitle:@"修改备注" action:@selector(handleCopyCell:)];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuItems:[NSArray arrayWithObjects:itCopy,nil]];
    [menu setTargetRect:cell.frame inView:self.installTableView];
    [menu setMenuVisible:YES animated:YES];
    
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
        //UITextField *nameField = [alertView textFieldAtIndex:0];
      
    }
    
    
}
// 用于UIMenuController显示，缺一不可
-(BOOL)canBecomeFirstResponder{
    return YES;
}
// 用于UIMenuController显示，缺一不可
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action ==@selector(handleCopyCell:)){
        return YES;
    }
    return NO;//隐藏系统默认的菜单项
}

#pragma mark - 蓝牙 Delegate
- (void)installDoSomethingEveryFrame:(NSMutableArray *)array {
    self.lanyaNameArray = array;
}

- (void)installDoSomethingtishiFrame:(NSString *)string {
    [self promptInformationActionWarningString:string];
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
    nameView.layer.borderColor=[UIColor grayColor].CGColor;
    NSArray *nameArray=@[@" 出厂卡",@" 时间卡",@" 同步卡",@" 地址卡"];
    nameLabel.text=nameArray[section];
    //添加view显示内容数量
    UIView *numberView=[[UIView alloc] initWithFrame:CGRectMake([UIScreen screenWidth] - 50, (SECTIONHEIGHT-25)/2, 25, 25)];
    numberView.backgroundColor = [UIColor redColor];
    [nameView addSubview:numberView];
    UILabel *numberLabel=[[UILabel alloc]initWithFrame:numberView.bounds];
    numberLabel.textColor = [UIColor whiteColor];
    numberLabel.textAlignment = 1;  //居中
    [numberView addSubview:numberLabel];
    numberView.layer.masksToBounds = YES;
    numberView.layer.cornerRadius = 25/2;
    ZBGroup *numbergroup = self.installDataArray[section];
    NSArray *NArr=numbergroup.items;
    numberLabel.text= [NSString stringWithFormat:@"%ld",NArr.count];
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
@end
