//
//  MyViewController.m
//  claidApp
//
//  Created by kevinpc on 2016/10/18.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "MyViewController.h"
#import "MyViewController+Configuration.h"
#import "installViewController.h"
#import "MyViewController+Animation.h"
#import "KaiKaViewController.h"
#import "LanyaViewController.h"

@implementation MyViewController

+ (instancetype) create {
    MyViewController *myViewController = [[MyViewController alloc] initWithNibName:@"MyViewController" bundle:nil];
    return myViewController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 点击  UItableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     if (indexPath.row == 0){
         KaiKaViewController *kaiKaVC = [KaiKaViewController create];
         [self hideTabBarAndpushViewController:kaiKaVC];
     } else if (indexPath.row == 2){
         LanyaViewController *lanyaVC = [LanyaViewController create];
         [self hideTabBarAndpushViewController:lanyaVC];
     }

}
//  管理员 设置 登录 跳转
- (IBAction)shezhiButtonAction:(id)sender {
    installViewController *installVC = [installViewController create];
    [self hideTabBarAndpushViewController:installVC];
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
