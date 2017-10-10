//
//  RegisterViewController.m
//  claidApp
//
//  Created by kevinpc on 2016/11/1.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterViewController+Configuration.h"
#import "RegisterViewController+LogicalFlow.h"
#import <SMS_SDK/SMSSDK.h>
#import "UIColor+Utility.h"

@implementation RegisterViewController

+ (instancetype)create {
    RegisterViewController *registerViewController = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    return registerViewController;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)registerButtonAction:(id)sender {
    if ([self isMobileNumber:self.phoneNumberTextField.text]){
        [self promptInformationActionWarningString:@"请输入11位手机号码!"];
        return;
    }
    if (self.mishiTextField.text.length==0){
        [self promptInformationActionWarningString:@"推荐码不能为空!"];
        return;
    }
    if (self.passwordTextField.text.length < 6 || self.passwordTextField.text.length > 16){
        [self promptInformationActionWarningString:@"请输入6-16位密码!"];
        return;
    }
    
    if ([self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text] ){
        [SMSSDK commitVerificationCode:self.mishiTextField.text phoneNumber:self.phoneNumberTextField.text zone:@"86" result:^(NSError *error) {
            if (!error) {
               [self registerPostForUsername:self.phoneNumberTextField.text password:self.passwordTextField.text];
            } else {
                [self alertViewmessage:@"验证码错误!"];
            }
        }];

     
    } else {
       [self promptInformationActionWarningString:@"密码输入不一致!"];
    }
    
}

- (IBAction)returnButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//  获取验证码
- (IBAction)verificationButtonAction:(id)sender {
    if ([self isMobileNumber:self.phoneNumberTextField.text]){
        [self promptInformationActionWarningString:@"请输入11位手机号码!"];
        return;
    }
    [self userphoneisrequestPostDataPhoneNumber:self.phoneNumberTextField.text];
    
}
- (void)obtainYanzhengmaAction {
    
    self.timeDown = 59;
    [self handleTimer];
    self.jishuTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
    
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumberTextField.text zone:@"86" result:^(NSError *error) {
        if (error)
        {
            [self.verificationButton  setUserInteractionEnabled:YES];
            self.verificationLabel.text = @"获取验证码";
            
            [self.jishuTimer invalidate];
            self.jishuTimer = nil;
            
        }
        
    }];
    
}
-(void)handleTimer {
    
    if(self.timeDown>=0)
    {
        [self.verificationButton setUserInteractionEnabled:NO];
        NSInteger sec = ((self.timeDown%(24*3600))%3600)%60;
        self.verificationLabel.text = [NSString stringWithFormat:@"%lds后可重发",(long)sec];
        
    }
    else
    {
        [self.verificationButton  setUserInteractionEnabled:YES];
        self.verificationLabel.text = @"重发验证码";

        [self.jishuTimer invalidate];
         self.jishuTimer = nil;
        
    }
    self.timeDown = self.timeDown - 1;
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
