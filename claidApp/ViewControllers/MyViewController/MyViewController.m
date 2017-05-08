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
#import "LanyaViewController.h"
#import "LoginViewController.h"
#import "VisitorViewController.h"
#import "invitaionCodeViewController.h"
#import "MycradInfoViewController.h"

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
     if (indexPath.row == 2){       // 蓝牙
         LanyaViewController *lanyaVC = [LanyaViewController create];
         lanyaVC.titleNameString = [NSString stringWithFormat:@"蓝牙"];
         [self hideTabBarAndpushViewController:lanyaVC];
        
     } else if (indexPath.row == 3) {   //卡信息
         MycradInfoViewController *mycradinfoVC = [MycradInfoViewController create];
         [self hideTabBarAndpushViewController:mycradinfoVC];
     } else if (indexPath.row == 6) {     //物业设置
        self.customAlertView = [[UIAlertView alloc] initWithTitle:@"请输入管理员口令" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [self.customAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
         UITextField *nameField = [self.customAlertView textFieldAtIndex:0];
         nameField.placeholder = @"您的口令是..";
        [self.customAlertView show];
        
     } else if (indexPath.row == 1 || indexPath.row == 7 || indexPath.row == 9) {
         NSLog(@"空白区");
     } else if (indexPath.row == 8) {        //退出登入
         [self clearAllUserDefaultsData];
         LoginViewController *loginViewController = [LoginViewController create];
         UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
         navigationController.navigationBarHidden = YES;
         UIApplication.sharedApplication.delegate.window.rootViewController = navigationController;
     } else if (indexPath.row == 5){     // 我是 访客
        VisitorViewController *visitor = [VisitorViewController create];
        [self hideTabBarAndpushViewController:visitor];
     } else if (indexPath.row == 4){        // 邀请访客
         invitaionCodeViewController *inviCodeVC = [invitaionCodeViewController create];
         [self hideTabBarAndpushViewController:inviCodeVC];
     
     }else {
         [self promptInformationActionWarningString:@"此功能暂未开通!"];
     }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        UITextField *nameField = [alertView textFieldAtIndex:0];
        if ([nameField.text isEqual:@"admin"]) {
           installViewController *installVC = [installViewController create];
            [self hideTabBarAndpushViewController:installVC];
        }
    }
    

}

//清除数据
- (void)clearAllUserDefaultsData {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults dictionaryRepresentation];
    for (id  key in dic) {
        [userDefaults removeObjectForKey:key];
    }
    [userDefaults synchronize];
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
