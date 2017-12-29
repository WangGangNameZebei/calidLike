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

#import "UIColor+Utility.h"

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

   
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请确认电话号码是否正确"  message:self.pAPhoneNumberTextField.text delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"是的", nil];
    alertView.tag = 1;
    [alertView show];
    
}

#pragma mark  提示框代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    self.propertyNameAlertView =nil;
    if (alertView.tag ==1){
        if (buttonIndex == 1) {
            NSString *cardData = [AESCrypt decrypt:[[NSUserDefaults standardUserDefaults] objectForKey:@"wuyeFKAESData"] password:AES_PASSWORD];
        [self propertyActivationPostForUserData:cardData userInfo:[self.userInfo substringWithRange:NSMakeRange(0,104)] userEqInfo:[self.userInfo substringWithRange:NSMakeRange(104,104)] userPhone:self.pAPhoneNumberTextField.text];
        }
    } else {
        
        if (buttonIndex == alertView.firstOtherButtonIndex) {
            UITextField *nameField = [alertView textFieldAtIndex:0];
            
            
            if (nameField.tag == 10) {
                UITextField *dizhiField = [alertView textFieldAtIndex:1];
                
                self.dizhiString = [NSString stringWithFormat:@"%@%@",self.dizhiString,dizhiField.text];  //地址
                [self districtInfoPOSTNameStr:nameField.text dataStr:self.dizhiString];
            } else if (nameField.tag == 0) {
                [self districtInfoPOSTNameStr:nameField.text dataStr:@""];

            } else if (nameField.tag == 1) {
                self.dizhiString = [NSString stringWithFormat:@"%@%@",self.dizhiString,nameField.text];  //地址
                [self districtInfoPOSTNameStr:@"" dataStr:self.dizhiString];
            }
        
            
        }
    
   }
}
- (IBAction)chongzhiButtonAction:(id)sender {
    if (self.stopBiaoshi == 0) {
        self.stopBiaoshi = 1;
        [self.chongzhiButton setImage:[UIImage imageNamed:@"gouxian_gray"] forState:UIControlStateNormal];
    } else {
        self.stopBiaoshi = 0;
        [self.chongzhiButton setImage:[UIImage imageNamed:@"gouxian_blue"] forState:UIControlStateNormal];
    }
    
}
// 链接蓝牙按钮
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
//  页面返回按钮
- (IBAction)returnButtonAction:(id)sender {
    [self.paSingleTon disConnection];       // 退出前 断开蓝牙
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
