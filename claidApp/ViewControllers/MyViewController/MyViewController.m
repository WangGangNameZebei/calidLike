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
     if (indexPath.row == 2){
         LanyaViewController *lanyaVC = [LanyaViewController create];
         lanyaVC.titleNameString = [NSString stringWithFormat:@"蓝牙"];
         [self hideTabBarAndpushViewController:lanyaVC];
        
     } else if (indexPath.row == 4) {
        self.customAlertView = [[UIAlertView alloc] initWithTitle:@"请输入管理员口令" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [self.customAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
         UITextField *nameField = [self.customAlertView textFieldAtIndex:0];
         nameField.placeholder = @"您的口令是..";
        [self.customAlertView show];
        
     }else if (indexPath.row == 1 || indexPath.row == 5 || indexPath.row == 7) {
         NSLog(@"空白区");
     } else {
         [self promptInformationActionWarningString:@"此功能暂未开通!"];
     }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        UITextField *nameField = [alertView textFieldAtIndex:0];
        if ([nameField.text isEqual:@"calid"]) {
           installViewController *installVC = [installViewController create];
            [self hideTabBarAndpushViewController:installVC];
        }
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
