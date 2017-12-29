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
#import "MyViewController+LogicalFlow.h"
#import "VisitorViewController.h"
#import "invitaionCodeViewController.h"
#import "MycradInfoViewController.h"
#import "PropertyActivationViewController.h"
#import "ChangeThePasswordViewController.h"
#import "AboutUsViewController.h"
#import "LoginViewController.h"
#import "CommunityManagementViewController.h" //  园区管理

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
     if([[self userInfoReaduserkey:@"role"] isEqualToString:@"1"]){
         if (indexPath.row == 0){  // 社区管理
             CommunityManagementViewController *communityManagementVC = [CommunityManagementViewController create];
             [self presentViewController:communityManagementVC animated:YES completion:nil];
         } else if (indexPath.row == 1){       // 续卡
             PropertyActivationViewController *pAViewController = [PropertyActivationViewController create];
             [self presentViewController:pAViewController animated:YES completion:nil];
         } else if (indexPath.row == 4) {   //卡信息
             MycradInfoViewController *mycradinfoVC = [MycradInfoViewController create];
             [self hideTabBarAndpushViewController:mycradinfoVC];
         } else if (indexPath.row == 3 || indexPath.row == 10 || indexPath.row == 12) {
             NSLog(@"空白区");
         } else if (indexPath.row == 5){        // 邀请访客
             invitaionCodeViewController *inviCodeVC = [invitaionCodeViewController create];
             [self hideTabBarAndpushViewController:inviCodeVC];
             
         } else if (indexPath.row == 6){     // 我是 访客
             VisitorViewController *visitor = [VisitorViewController create];
             [self hideTabBarAndpushViewController:visitor];
         } else if (indexPath.row == 2) {     //物业设置
             installViewController *installVC = [installViewController create];
             //[installVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
             [self presentViewController:installVC animated:YES completion:nil];
             
         } else if (indexPath.row == 7){        // 密码修改
             ChangeThePasswordViewController *changethePasswordVC = [ChangeThePasswordViewController create];
             [self hideTabBarAndpushViewController:changethePasswordVC];
         } else if (indexPath.row == 8) {        // 数据更新
             [self theinternetCardupData];
         } else if (indexPath.row == 9) {       // 关于我们
             AboutUsViewController *aboutUsVC = [AboutUsViewController create];
             [self hideTabBarAndpushViewController:aboutUsVC];
         } else if (indexPath.row == 11) {        //退出登入
             self.customAlertView = [[UIAlertView alloc] initWithTitle:@"退出登录" message:@"退出登录会删除您的所有信息，确定退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
             self.customAlertView.tag = 2;
             [self.customAlertView show];
         } else {
             [self promptInformationActionWarningString:@"此功能暂未开通!"];
         }

     } else {
          if (indexPath.row == 0) {   //卡信息
             MycradInfoViewController *mycradinfoVC = [MycradInfoViewController create];
             [self hideTabBarAndpushViewController:mycradinfoVC];
         } else if (indexPath.row == 6 || indexPath.row == 8) {
             NSLog(@"空白区");
         } else if (indexPath.row == 1){        // 邀请访客
             invitaionCodeViewController *inviCodeVC = [invitaionCodeViewController create];
             [self hideTabBarAndpushViewController:inviCodeVC];
             
         } else if (indexPath.row == 2){     // 我是 访客
             VisitorViewController *visitor = [VisitorViewController create];
             [self hideTabBarAndpushViewController:visitor];
         } else if (indexPath.row == 3){        // 密码修改
             ChangeThePasswordViewController *changethePasswordVC = [ChangeThePasswordViewController create];
             [self hideTabBarAndpushViewController:changethePasswordVC];
         } else if (indexPath.row == 4) {        // 数据更新
             [self theinternetCardupData];
         } else if (indexPath.row == 5) {       // 关于我们
             AboutUsViewController *aboutUsVC = [AboutUsViewController create];
             [self hideTabBarAndpushViewController:aboutUsVC];
         } else if (indexPath.row == 7) {        //退出登入
             self.customAlertView = [[UIAlertView alloc] initWithTitle:@"退出登录" message:@"退出登录会删除您的所有信息，确定退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
             self.customAlertView.tag = 2;
             [self.customAlertView show];
         } else {
             [self promptInformationActionWarningString:@"此功能暂未开通!"];
         }

     }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == alertView.firstOtherButtonIndex && alertView.tag == 2) {
        [InternetServices logOutPOSTkeystr:[self userInfoReaduserkey:@"userName"]];
    }
    
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
