//
//  VisitorTabPagerViewController.m
//  claidApp
//
//  Created by kevinpc on 2017/8/11.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "VisitorTabPagerViewController.h"
#import "UIScreen+Utility.h"
#import "UIColor+Utility.h"

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
    _contentView = [[UIView alloc]initWithFrame:CGRectMake(0,[UIScreen screenHeight] -44, [UIScreen mainScreen].bounds.size.width, 44)];

    SPPageMenu  *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 0 ,[UIScreen screenWidth], 44) trackerStyle:SPPageMenuTrackerStyleRect];
    pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
    pageMenu.selectedItemTitleColor =   [UIColor blackColor];
    pageMenu.unSelectedItemTitleColor = [UIColor colorFromHexCode:@"#999999"];
    // 传递数组，默认选中第1个
    [pageMenu setItems:self.itemArray selectedItemIndex:0];
    // 设置代理
    pageMenu.delegate = self;
    [self.contentView addSubview:pageMenu];
    self.pageMenu = pageMenu;
    [self.view addSubview:self.contentView];
    
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
#pragma mrak- pageMenu DeleGate
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedAtIndex:(NSInteger)index {
    if ((index== 0 && _currentVC ==  self.visitorViewController) || (index == 1 && _currentVC ==  self.visitorCarViewController)) {
        return;
    }
    switch (index) {
        case 0:{
            [self fitFrameForChildViewController: self.visitorViewController];
            [self transitionFromOldViewController:_currentVC toNewViewController: self.visitorViewController];
        }
            break;
        case 1:{
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
