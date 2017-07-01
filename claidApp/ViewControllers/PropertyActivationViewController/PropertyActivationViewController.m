//
//  PropertyActivationViewController.m
//  claidApp
//
//  Created by kevinpc on 2017/5/3.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "PropertyActivationViewController.h"
#import "PropertyActivationViewController+Configuration.h"
#import "PropertyActivationViewController+LogicalFlow.h"
#import "MBProgressHUD.h"

@implementation PropertyActivationViewController

+ (instancetype) create {
    PropertyActivationViewController *properActionVC = [[PropertyActivationViewController alloc] initWithNibName:@"PropertyActivationViewController" bundle:nil];
    return properActionVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pARegisteredButtonAction:(id)sender {
    if (self.userInfo.length < 10){
        [self promptInformationActionWarningString:@"物业未发卡!"];
        return;
    }
    if (self.pAPhoneNumberTextField.text.length!=11){
        [self promptInformationActionWarningString:@"请输入正确电话号码!"];
        return;
    }
    
    if (self.pAPasswordTextField.text.length < 6 || self.pAPasswordTextField.text.length > 16){
        [self promptInformationActionWarningString:@"请输入6-16位字符组合!"];
        return;
    }
    if ([self.pAPasswordTextField.text isEqualToString:self.pAConfirmPasswordTextField.text] ){
      // 注册信息 点击   注册
    } else {
        [self promptInformationActionWarningString:@"密码输入不一致!"];
    }
    NSString *cardData = [AESCrypt decrypt:[[NSUserDefaults standardUserDefaults] objectForKey:@"lanyaAESData"] password:AES_PASSWORD];
    [self propertyActivationPostForUserData:cardData userInfo:[self.userInfo substringWithRange:NSMakeRange(0,104)] userEqInfo:[self.userInfo substringWithRange:NSMakeRange(104,104)] userPhone:self.pAPhoneNumberTextField.text password:self.pAPasswordTextField.text];
}

- (IBAction)saoMiaoButtonAction:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.label.text = NSLocalizedString(@"扫秒蓝牙中...", @"HUD loading title");
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self.paSingleTon startScan]; // 扫描
        [self doSomeWork];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.propertyActionViewControllerDataSource.pAVCDataSourceArray = self.paLnyaNameArray;
           [self.paVCTableiVew reloadData];
            [hud hideAnimated:YES];
        });
    });
}
- (IBAction)returnButtonAction:(id)sender {
    if ([self.titleLabelString isEqualToString:@"续卡"]){
       [self theinternetCardupData];
    }
    [self.paSingleTon disConnection];       // 退出前 断开蓝牙
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mrak - UItavleView-delegate- 点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        CBPeripheral *periphe = [self.paLnyaNameArray objectAtIndex:(indexPath.row)];

        [self.paSingleTon connectClick:periphe];
}

#pragma mark - Tasks
- (void)doSomeWork {
    // Simulate by just waiting.
    sleep(3.);
}

@end
