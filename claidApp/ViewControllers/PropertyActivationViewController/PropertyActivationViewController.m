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
    
    if ([self isMobileNumber:self.pAPhoneNumberTextField.text]){
        [self promptInformationActionWarningString:@"请输入正确电话号码!"];
        return;
    }
    if (!self.pAPasswordLabel.hidden) {
        if (self.pAPasswordTextField.text.length < 6 || self.pAPasswordTextField.text.length > 16){
            [self promptInformationActionWarningString:@"请输入6-16位密码!"];
            return;
        }
        if ([self.pAPasswordTextField.text isEqualToString:self.pAConfirmPasswordTextField.text] ){
            // 注册信息 点击   注册
        } else {
            [self promptInformationActionWarningString:@"密码输入不一致!"];
            return;
        }
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请确认电话号码是否正确"  message:self.pAPhoneNumberTextField.text delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"是的", nil];
    [alertView show];
    
}
#pragma mark  提示框代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString *cardData = [AESCrypt decrypt:[[NSUserDefaults standardUserDefaults] objectForKey:@"lanyaAESData"] password:AES_PASSWORD];
        [self propertyActivationPostForUserData:cardData userInfo:[self.userInfo substringWithRange:NSMakeRange(0,104)] userEqInfo:[self.userInfo substringWithRange:NSMakeRange(104,104)] userPhone:self.pAPhoneNumberTextField.text password:self.pAPasswordTextField.text];
    } else {
        NSLog(@"点击了取消按钮");
    }
}
- (IBAction)chongzhiButtonAction:(id)sender {
    if (self.pAPasswordLabel.hidden) {
        [self.chongzhiButton setImage:[UIImage imageNamed:@"gouxian_blue"] forState:UIControlStateNormal];
        self.pAPasswordLabel.hidden = NO;
        self.pAConfirmPasswordLabel.hidden = NO;
        self.pAPasswordView.hidden = NO;
        self.pAConfirmPasswordView.hidden = NO;
    } else {
        [self.chongzhiButton setImage:[UIImage imageNamed:@"gouxian_gray"] forState:UIControlStateNormal];
        self.pAPasswordLabel.hidden = YES;
        self.pAConfirmPasswordLabel.hidden = YES;
        self.pAPasswordView.hidden = YES;
        self.pAConfirmPasswordView.hidden = YES;
        self.pAPasswordTextField.text = @"";
    }
    
}
- (IBAction)saoMiaoButtonAction:(id)sender {
    if ([self.pALanyaLabel.text isEqualToString:@"已连接"]){
        [self.paSingleTon disConnection];       // 退出前 断开蓝牙
    } else {   
        NSString  *strLanya = FAKAQI_TON_UUID_STR;
        if (strLanya.length < 3) {
            [self.paSingleTon startScan]; // 扫描
        } else {
            [self.paSingleTon getPeripheralWithIdentifierAndConnect:strLanya];
        }
    }
}
- (IBAction)returnButtonAction:(id)sender {
    if ([self.titleLabelString isEqualToString:@"续卡"]){
       [self theinternetCardupData];
    }
    [self.paSingleTon disConnection];       // 退出前 断开蓝牙
    [self.navigationController popViewControllerAnimated:YES];
}


@end
