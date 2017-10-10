//
//  RegisterViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2016/11/1.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "RegisterViewController+Configuration.h"
#import "UIColor+Utility.h"


@implementation RegisterViewController (Configuration)

- (void)configureViews {
    [self textFieldViewEdit];
    [self phoneNumberAndpasswordViewEdit];
    [self addGestRecognizer];
}


//textField 编辑
- (void)textFieldViewEdit {
    self.phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;        //数字键盘
    self.phoneNumberTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.phoneNumberTextField.delegate = self;
    
    self.mishiTextField.keyboardType = UIKeyboardTypeNumberPad;        //数字键盘
    self.mishiTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.mishiTextField.delegate = self;
    
    self.passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.delegate = self;
    self.confirmPasswordTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.confirmPasswordTextField.secureTextEntry = YES;
    self.confirmPasswordTextField.delegate = self;
}

//  textFieldView编辑
- (void)phoneNumberAndpasswordViewEdit {
    [self viewlayer:self.phoneNumberView];
    [self viewlayer:self.mishiView];
    [self viewlayer:self.passwordView];
    [self viewlayer:self.confirmPasswordView];
}

#pragma mark UIView 边框编辑
- (void)viewlayer:(UIView *)view {
    view.layer.cornerRadius = 6;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 1;
    view.layer.borderColor = [[UIColor setupGreyColor] CGColor];
}

#pragma mark textField 代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.tag == 1) {
        self.phoneNumberView.layer.borderColor = [[UIColor setipBlueColor] CGColor];
         self.phoneNumberImageView.image = [UIImage imageNamed:@"login_accountNumber_blue"];
    } else if (textField.tag == 2) {
        self.mishiView.layer.borderColor = [[UIColor setipBlueColor] CGColor];
        self.mishiImageView.image = [UIImage imageNamed:@"login_secretKey_blue"];
    }else if (textField.tag == 3){
         self.passwordView.layer.borderColor = [[UIColor setipBlueColor] CGColor];
         self.passwordImageView.image = [UIImage imageNamed:@"login_passWord_blue"];
    } else {
        self.confirmPasswordView.layer.borderColor = [[UIColor setipBlueColor] CGColor];
        self.confirmPasswordImageView.image = [UIImage imageNamed:@"login_passWord_blue"];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 1) {
        self.phoneNumberView.layer.borderColor = [[UIColor setupGreyColor] CGColor];
         self.phoneNumberImageView.image = [UIImage imageNamed:@"login_accountNumber_gray"];
    } else if (textField.tag == 2) {
        self.mishiView.layer.borderColor = [[UIColor setupGreyColor] CGColor];
         self.mishiImageView.image = [UIImage imageNamed:@"login_secretKey_gray"];
        
    } else if (textField.tag == 3){
        self.passwordView.layer.borderColor = [[UIColor setupGreyColor] CGColor];
         self.passwordImageView.image = [UIImage imageNamed:@"login_passWord_gray"];
    } else{
        self.confirmPasswordView.layer.borderColor = [[UIColor setupGreyColor] CGColor];
        self.confirmPasswordImageView.image = [UIImage imageNamed:@"login_passWord_gray"];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.phoneNumberTextField resignFirstResponder];
    [self.mishiTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
     [self.confirmPasswordTextField resignFirstResponder];
    return YES;
}
#pragma mark - 空白处收起键盘
- (void)addGestRecognizer {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    tap.numberOfTouchesRequired =1;
    tap.numberOfTapsRequired =1;
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}
- (void)tapped:(UIGestureRecognizer *)gestureRecognizer{
    [self.view endEditing:YES];
}
@end
