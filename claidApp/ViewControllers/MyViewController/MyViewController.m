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
     if (indexPath.row == 0){       // 续卡
         self.customAlertView = [[UIAlertView alloc] initWithTitle:@"请输入管理员口令" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
         [self.customAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
         self.customAlertView.tag = 0;
         UITextField *nameField = [self.customAlertView textFieldAtIndex:0];
         nameField.tag = 0;
         nameField.secureTextEntry = YES;
         nameField.placeholder = @"您的口令是...";
         [self.customAlertView show];
        
     } else if (indexPath.row == 3) {   //卡信息
         MycradInfoViewController *mycradinfoVC = [MycradInfoViewController create];
         [self hideTabBarAndpushViewController:mycradinfoVC];
     } else if (indexPath.row == 2 || indexPath.row == 9 || indexPath.row == 11) {
         NSLog(@"空白区");
     } else if (indexPath.row == 4){        // 邀请访客
         invitaionCodeViewController *inviCodeVC = [invitaionCodeViewController create];
         [self hideTabBarAndpushViewController:inviCodeVC];
         
     } else if (indexPath.row == 5){     // 我是 访客
        VisitorViewController *visitor = [VisitorViewController create];
        [self hideTabBarAndpushViewController:visitor];
     } else if (indexPath.row == 1) {     //物业设置
         self.customAlertView = [[UIAlertView alloc] initWithTitle:@"请输入管理员口令" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
         [self.customAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
         self.customAlertView.tag = 1;
         UITextField *nameField = [self.customAlertView textFieldAtIndex:0];
         nameField.tag = 1;
         nameField.secureTextEntry = YES;
         nameField.placeholder = @"您的口令是..";
         [self.customAlertView show];
         
     } else if (indexPath.row == 6){        // 密码修改
         ChangeThePasswordViewController *changethePasswordVC = [ChangeThePasswordViewController create];
         [self hideTabBarAndpushViewController:changethePasswordVC];
     } else if (indexPath.row == 7) {        // 数据更新
         [self theinternetCardupData];
     } else if (indexPath.row == 8) {       // 意见反馈
         AboutUsViewController *aboutUsVC = [AboutUsViewController create];
         [self hideTabBarAndpushViewController:aboutUsVC];
     } else if (indexPath.row == 10) {        //退出登入
         self.customAlertView = [[UIAlertView alloc] initWithTitle:@"退出登录" message:@"退出登录会删除您的所有信息，确定退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
         self.customAlertView.tag = 2;
         [self.customAlertView show];
     } else {
         [self promptInformationActionWarningString:@"此功能暂未开通!"];
     }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == alertView.firstOtherButtonIndex && (alertView.tag == 0 || alertView.tag == 1)) {
        UITextField *nameField = [alertView textFieldAtIndex:0];
        
        if ([nameField.text isEqual:@"admin"] && nameField.tag ==0) {
                PropertyActivationViewController *pAViewController = [PropertyActivationViewController create];
                    pAViewController.titleLabelString = @"物业激活";
                    [self hideTabBarAndpushViewController:pAViewController];
        } else if ([nameField.text isEqual:@"calid"] && nameField.tag == 1){
                installViewController *installVC = [installViewController create];
                [self hideTabBarAndpushViewController:installVC];
        }
        
    } else if (buttonIndex == alertView.firstOtherButtonIndex && alertView.tag == 2) {
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
