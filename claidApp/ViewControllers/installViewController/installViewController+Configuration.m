//
//  installViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2016/11/2.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "installViewController+Configuration.h"
#import "MyTableViewCell.h"
#import "BlankTableViewCell.h"
#import "UIScreen+Utility.h"
#import "UIColor+Utility.h"

#define SECTIONHEIGHT 80


@implementation installViewController (Configuration)

- (void)configureViews {
    [self myTableViewInitEdit];
}

- (void)myTableViewInitEdit {
    if (!self.installDataArray) {
        self.installDataArray = [NSMutableArray array];
    }
      NSArray *groupNames = @[@[@"出厂1",@"出厂2"],@[@"时间1",@"时间2"],@[@"同步1",@"同步2"],@[@"地址1",@"地址2",@"地址3",@"地址4",@"地址5",@"地址6",@"地址7",@"地址8"]];
//    [self.installTableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:My_TABLEVIEW_CELL];
//    [self.installTableView registerNib:[UINib nibWithNibName:@"BlankTableViewCell" bundle:nil] forCellReuseIdentifier:BLANK_TABLEVIEW_CELL];
    self.installVCDataSource = [installViewControllerDataSource new];
    self.installTableView.delegate = self;
    self.installTableView.dataSource = self.installVCDataSource;
    
  
    //这是一个分组的模型类
    for (NSMutableArray *name in groupNames) {
        ZBGroup *group1 = [[ZBGroup alloc] initWithItem:name];
        [self.installDataArray addObject:group1];
    }
    self.installVCDataSource.installDataArray = self.installDataArray;

//    self.installVCDataSource.installDataArray = [NSMutableArray arrayWithObjects:@"连接蓝牙",@"空",@"出厂卡刷卡",@"地址卡刷卡",@"时间卡刷卡",@"同步卡刷卡",@"用户卡刷卡",@"查看信息", nil];
//    self.installVCDataSource.installImageArray = [NSMutableArray arrayWithObjects:@"kaika.png",@"空",@"shiduankaiqi.png",@"touxiang.png",@"woxinxi.png",@"weixin.png",@"touxiang.png",@"kaxinxi.png", nil];
    
}

#pragma mark - UITableView Delegate
//设置headerView高度
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return SECTIONHEIGHT;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
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
