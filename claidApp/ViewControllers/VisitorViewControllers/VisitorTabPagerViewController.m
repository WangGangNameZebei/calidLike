//
//  VisitorTabPagerViewController.m
//  claidApp
//
//  Created by kevinpc on 2017/8/11.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "VisitorTabPagerViewController.h"
#import "UIScreen+Utility.h"

@implementation VisitorTabPagerViewController

+ (instancetype) create {
    VisitorTabPagerViewController *visitorTPVC = [[VisitorTabPagerViewController alloc] initWithNibName:@"VisitorTabPagerViewController" bundle:nil];
    return visitorTPVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadBaseUI];
}
- (void)loadView{
    [super loadView];
    [self initialization];
}


- (void)initialization{
    _itemArray = [NSMutableArray arrayWithObjects:@"小门",@"开车", nil];
}

- (void)loadBaseUI{
    _headScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,[UIScreen screenHeight] -44, [UIScreen mainScreen].bounds.size.width, 44)];
    _headScrollView.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    for (int i = 0; i<_itemArray.count; i++) {
        UIButton *itemButton = [[UIButton alloc]initWithFrame:CGRectMake(i*([UIScreen mainScreen].bounds.size.width/_itemArray.count), 0, [UIScreen mainScreen].bounds.size.width/_itemArray.count, 44)];
        itemButton.tag = 100+i;
        itemButton.backgroundColor = [UIColor clearColor];
        NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor purpleColor],NSFontAttributeName:[UIFont systemFontOfSize:14.0f]};
        [itemButton setAttributedTitle:[[NSAttributedString alloc]initWithString:_itemArray[i] attributes:dic] forState:UIControlStateNormal];
        [itemButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_headScrollView addSubview:itemButton];
    }
    [_headScrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 44)];
    _headScrollView.showsHorizontalScrollIndicator = NO;
    _headScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_headScrollView];
    
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 44 -64)];
    _contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_contentView];
    
    [self addSubControllers];
}

#pragma mark - privatemethods
- (void)addSubControllers{
    self.visitorViewController = [[VisitorViewController alloc]initWithNibName:@"VisitorViewController" bundle:nil];
    [self addChildViewController:self.visitorViewController];
    
    self.visitorCarViewController = [[VisitorCarViewController alloc]initWithNibName:@"VisitorCarViewController" bundle:nil];
    [self addChildViewController:self.visitorCarViewController];
    
    
    //调整子视图控制器的Frame已适应容器View
    [self fitFrameForChildViewController: self.visitorViewController];
    //设置默认显示在容器View的内容
    [self.contentView addSubview: self.visitorViewController.view];
    
    NSLog(@"%@",NSStringFromCGRect(self.contentView.frame));
    NSLog(@"%@",NSStringFromCGRect( self.visitorViewController.view.frame));
    
    _currentVC = self.visitorViewController;
}

- (void)buttonClick:(UIButton *)sender{
    if ((sender.tag == 100 && _currentVC ==  self.visitorViewController) || (sender.tag == 101 && _currentVC ==  self.visitorCarViewController)) {
        return;
    }
    switch (sender.tag) {
        case 100:{
            [self fitFrameForChildViewController: self.visitorViewController];
            [self transitionFromOldViewController:_currentVC toNewViewController: self.visitorViewController];
        }
            break;
        case 101:{
            [self fitFrameForChildViewController:self.visitorCarViewController];
            [self transitionFromOldViewController:_currentVC toNewViewController:self.visitorCarViewController];
        }
            break;
    }
}

- (void)fitFrameForChildViewController:(UIViewController *)chileViewController{
    CGRect frame = self.contentView.frame;
    frame.origin.y = 0;
    chileViewController.view.frame = frame;
}

//转换子视图控制器
- (void)transitionFromOldViewController:(UIViewController *)oldViewController toNewViewController:(UIViewController *)newViewController{
    [self transitionFromViewController:oldViewController toViewController:newViewController duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newViewController didMoveToParentViewController:self];
            _currentVC = newViewController;
        }else{
            _currentVC = oldViewController;
        }
    }];
}

//移除所有子视图控制器
- (void)removeAllChildViewControllers{
    for (UIViewController *vc in self.childViewControllers) {
        [vc willMoveToParentViewController:nil];
        [vc removeFromParentViewController];
    }
}


- (IBAction)tabPagerReturnButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
