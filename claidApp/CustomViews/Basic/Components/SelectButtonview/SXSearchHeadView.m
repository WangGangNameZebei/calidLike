//
//  SXSearchHeadView.m
//  TabViewCell
//
//  Created by apple on 2017/8/29.
//  Copyright © 2017年 zebei. All rights reserved.

#import "SXSearchHeadView.h"
#import "SXShowConditionCell.h"
#import "UIScreen+Utility.h"
#import "BaseViewController.h"
#import "SXSearchHeadView+LogicalFlow.h"
#define KHeight 60
#define Kwidth  90
#define KSpace  5

@interface SXSearchHeadView ()<UITableViewDelegate,UITableViewDataSource>

//全局对象
@property (nonatomic,strong) SXSearchHeadView *headView;

//存放种类的数组
//诗的类型
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) BOOL isDataing;
@end

@implementation SXSearchHeadView

static NSString *identify=@"cell";


-(UITableView *)searchTableView{
    if (!_searchTableView) {
        _searchTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, _dataButton.frame.size.height, _dataButton.frame.size.width,[UIScreen screenHeight] - 64 - _dataButton.frame.size.height) style:(UITableViewStylePlain)];
        
        _searchTableView.delegate=self;
        _searchTableView.dataSource=self;
        _searchTableView.backgroundColor=[UIColor whiteColor];
        
        _searchTableView.rowHeight=40;
        
        
        //注册cell
        [_searchTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SXShowConditionCell class]) bundle:nil] forCellReuseIdentifier:identify];
    }
    return _searchTableView;
}


#warning - 适配的是414*736（6P、7P）的屏幕,有需要可以自己改。

- (instancetype)initWithFrame:(CGRect)frame andDataSource:(NSMutableArray *)DataSource{
    
    if (self=[super initWithFrame:frame]) {
        
        //        数据源
        _dataArr=DataSource;

        
        //self的背景颜色
        self.backgroundColor=[UIColor whiteColor];

        //让view上的子视图适应view不让其超过主视图的frame
        self.clipsToBounds=YES;
        
        //初始化button
        _dataButton=[UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat width = frame.size.width;
        //范围
        _dataButton.frame=CGRectMake(0, 0, width, frame.size.height);
        //设置tag值
        _dataButton.tag=100;

         //选中时title的颜色
        [_dataButton setTitleColor:[UIColor blackColor] forState:(UIControlStateSelected)];
       _dataButton.selected=YES;
        //刚进入程序时 默认title为数组中的第一个对象
        [_dataButton setTitle:[[BaseViewController alloc] userInfoReaduserkey:@"districtName"] forState:(UIControlStateNormal)];
        //设置button的image
        [_dataButton setImage:[UIImage imageNamed:@"upwhite"] forState:(UIControlStateNormal)];
        //设置image的内间距    布局
        [_dataButton setImageEdgeInsets:UIEdgeInsetsMake(0, _dataButton.titleLabel.frame.size.width, 0, 0 - _dataButton.titleLabel.frame.size.width)];
        //设置title的内间距    布局
        [_dataButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0-_dataButton.imageView.frame.size.width, 0, _dataButton.imageView.frame.size.width)];
        //button的点击事件
        [_dataButton addTarget:self action:@selector(beginToSearch:) forControlEvents:UIControlEventTouchUpInside];
       
        //添加到View上
        [self addSubview:_dataButton];
    
        [self addSubview:self.searchTableView];
   

    }
    [self changeFrameOfButton:_dataButton];
    return self;
    
}

-(void)changeFrameOfButton:(UIButton *)sender{
    
    //设置image的内间距    布局
    [_dataButton setImageEdgeInsets:UIEdgeInsetsMake(0, _dataButton.titleLabel.frame.size.width, 0, 0 - _dataButton.titleLabel.frame.size.width)];
    //设置title的内间距    布局
    [_dataButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0-_dataButton.imageView.frame.size.width, 0, _dataButton.imageView.frame.size.width)];
}

//开始选择
-(void)beginToSearch:(UIButton *)sender{
    
//    因为有的三个字有的两个字，要调整一下内间距，有一个根据字体大小获得文本长度的方法，有兴趣的可以找一下，我比较懒
    
    [self changeFrameOfButton:sender];
    
    //如果两次点击是同一次button
    if (_selectIndex==sender.tag) {
        _selectIndex=0;
        
        //并且这个tableView‘是打开状态的
        if (_isDataing) {
            //封装方法，让其关闭
            [self restorationForButtonImageView];
            
        }else{
            //如果不是开启状态，打开tableView并显示你所点击的button对应的内容
            [self change:sender.tag];
        }
        
    }else{
        //如果两次点击的不是同一个button，打开tableView并显示你所点击的button对应的内容
        [self change:sender.tag];
        
    }
    //最后，将你所点击的button的下标block传给控制器
    if (_titleBlock) {
        _titleBlock(self.selectIndex);
    }
    //点击之后刷新tableView 以刷新button对应的内容
    [self.searchTableView reloadData];

}

//如果两次点击的不是同一个Button或者点击的是同一个button‘ 但是两次点击的时候tableView都处于关闭状态的时候------调用此方法 。
//有点难讲，这个状态比较少触发，可以打个断点多玩玩
-(void)change:(NSInteger)num{
    
    //既然是要打开，点击的button的下标赋给_selectIndex 以便后面block传给控制器
    _selectIndex=num;
    
    //根据点击不同的button，将其设置为选中状态，打开状态开启，图片旋转，其他的都取消掉

        
        [UIView animateWithDuration:.25 animations:^{
            
          _dataButton.selected=YES;
            
//            点击到的按钮图片旋转，其他的都返回原样
            _dataButton.imageView.transform=CGAffineTransformMakeRotation(M_PI);
            //设置button的image
            [_dataButton setImage:[UIImage imageNamed:@"upblack"] forState:(UIControlStateNormal)];
        }];
        
        _isDataing=YES;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //1.根据分区获取该分区对应的数组
        return self.dataArr.count;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SXShowConditionCell *cell=[tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    
//    看看是否需要显示后面的选中标记
    BOOL isSame = NO;
    
    //根据点击不同的button将不同的数据array中的string置为其标题
    NSString *name;
    

        
//        在赋值的过程中，因为选择过的内容会显示在顶部的按钮上，如果数组里面的字符和按钮相同，就证明那个是上次选择的对象，加个标记
        if ([self.dataArr[indexPath.row] isEqualToString:_dataButton.titleLabel.text]) {
            isSame = YES;
        }
        
        name = self.dataArr[indexPath.row];

    cell.backgroundColor = [UIColor whiteColor];
    
//    isSame取反的原因可以去cell类里面看一眼
    [cell setName:name andIsSelected:!isSame];

    //手势监控  长按键
    UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(cellLongPress:)];
    [cell addGestureRecognizer:longPressGesture];

    return cell;
}
- (void)cellLongPress:(UIGestureRecognizer *)recognizer{
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:self.searchTableView];
        self.selectIndexPath = [self.searchTableView indexPathForRowAtPoint:location];
        self.modifyAlertView = [[UIAlertView alloc] initWithTitle:@"请输入备注" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        self.modifyAlertView.tag = 0;
        [self.modifyAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
        
        UITextField *nameField = [self.modifyAlertView textFieldAtIndex:0];
        nameField.placeholder = @"您的园区备注是...";
        [self.modifyAlertView show];
    }

}

#pragma mark - AlertView  代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 0){  //修改备注
        if (buttonIndex == alertView.firstOtherButtonIndex) {
            UITextField *nameField = [alertView textFieldAtIndex:0];
            if (nameField.text.length < 1) {
                return;
            }
            NSString * nameStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser"];               //记录当前小区
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",self.selectIndexPath.row] forKey:@"currentUser"]; //
            [[BaseViewController alloc] userInfowriteuserkey:@"districtName" uservalue:nameField.text];
            [self changeTheNotePOSTnoteStr:nameField.text];
            self.dataArr[self.selectIndexPath.row] = [[BaseViewController alloc] userInfoReaduserkey:@"districtName"];
            [[NSUserDefaults standardUserDefaults] setObject:nameStr forKey:@"currentUser"];    //恢复当前小区的存储

            [self.searchTableView reloadData];
        }
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row] forKey:@"currentUser"];
        if ([_dataButton.titleLabel.text isEqualToString:self.dataArr[indexPath.row]]) {
            
        }else{
            
            [_dataButton setTitle:self.dataArr[indexPath.row] forState:UIControlStateNormal];
          
        }

    
//    选择完毕，恢复状态
    [self restorationForButtonImageView];
    
    //每当点击cell 说明类型变换了，告诉控制器，需要重新根据标题更新新数据了。
    if (_selectBlock) {
        _selectBlock(@"点击了");
    }
   
    [self.searchTableView reloadData];
    [self changeFrameOfButton:_dataButton];
}

//    当点击了任何一个cell，就说明选择过了，除了按钮的标题要变，其他的都恢复初始状态
-(void)restorationForButtonImageView{
     _dataButton.selected=NO;
    [UIView animateWithDuration:.25 animations:^{
        _dataButton.imageView.transform=CGAffineTransformIdentity;

        
        _isDataing=NO;
        
        
        [_dataButton setImage:[UIImage imageNamed:@"upwhite"] forState:(UIControlStateNormal)];
        _dataButton.selected=YES;
            
    }];
}

@end
