//
//  RetrieveThePasswordViewController.m
//  claidApp
//
//  Created by kevinpc on 2017/9/26.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "RetrieveThePasswordViewController.h"
#import "RetrieveThePasswordViewController+LogicalFlow.h"
#import "RetrieveThePasswordViewController+Configuration.h"
#import <SMS_SDK/SMSSDK.h>
#import "RetrieveTowpasswordViewController.h"

@implementation RetrieveThePasswordViewController
+ (instancetype) create {
    RetrieveThePasswordViewController *retrieveThepasswordVC = [[RetrieveThePasswordViewController alloc] initWithNibName:@"RetrieveThePasswordViewController" bundle:nil];
    return retrieveThepasswordVC;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}
- (IBAction)returnButtonAction:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)nextButtonAction:(id)sender {
    [SMSSDK commitVerificationCode:self.verificationCodeTextField.text phoneNumber:self.phoneNumberTextField.text zone:@"86" result:^(NSError *error) {
        if (!error) {
            RetrieveTowpasswordViewController *retrieveTowVC = [RetrieveTowpasswordViewController create];
            retrieveTowVC.phoneNumberStr = self.phoneNumberTextField.text;
           [self hideTabBarAndpushViewController:retrieveTowVC];
        } else {
            [self alertViewmessage:@"验证码错误!"];
        }
    }];
}
// 验证码
- (IBAction)yanzhengmaButtonAction:(id)sender {
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
            [self.yanzhengmaBUtton  setUserInteractionEnabled:YES];
            self.yanzhengmaLabel.text = @"获取验证码";
            
            [self.jishuTimer invalidate];
            self.jishuTimer = nil;
            
        }
        
    }];
}

-(void)handleTimer {
    
    if(self.timeDown>=0)
    {
        [self.yanzhengmaBUtton setUserInteractionEnabled:NO];
        NSInteger sec = ((self.timeDown%(24*3600))%3600)%60;
        self.yanzhengmaLabel.text = [NSString stringWithFormat:@"%lds后可重发",(long)sec];
        
    }
    else
    {
        [self.yanzhengmaBUtton  setUserInteractionEnabled:YES];
        self.yanzhengmaLabel.text = @"重发验证码";
        
        [self.jishuTimer invalidate];
        self.jishuTimer = nil;
        
    }
    self.timeDown = self.timeDown - 1;
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
