//
//  LoginViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2016/10/31.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "LoginViewController+Configuration.h"
#import "UIColor+Utility.h"


@implementation LoginViewController (Configuration)

- (void)configureViews {
    [self phoneNumberAndpasswordViewEdit];
    [self textFieldViewEdit];
    [self addGestRecognizer];
}

//textField 编辑
- (void)textFieldViewEdit {
    self.phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;        //数字键盘
    self.phoneNumberTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.phoneNumberTextField.delegate = self;
    
    self.passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.delegate = self;
    
}

//  textFieldView编辑
- (void)phoneNumberAndpasswordViewEdit {
    [self viewlayer:self.phoneNumberView];
    [self viewlayer:self.passwordView];
}

#pragma mark UIView 边框编辑
- (void)viewlayer:(UIView *)view {
    view.layer.cornerRadius = 6;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 1;
    view.layer.borderColor = [[UIColor colorFromHexCode:@"#C2C2C2"] CGColor];
}

#pragma mark textField 代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.tag == 1) {
        self.phoneNumberView.layer.borderColor = [[UIColor colorFromHexCode:@"#3CD06D"] CGColor];
          self.phoneNumberImageView.image = [UIImage imageNamed:@"denglu_1.png"];
        
    } else {
        self.passwordView.layer.borderColor = [[UIColor colorFromHexCode:@"#3CD06D"] CGColor];
          self.passwordImageView.image = [UIImage imageNamed:@"mima_1.png"];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 1) {
        self.phoneNumberView.layer.borderColor = [[UIColor colorFromHexCode:@"#C2C2C2"] CGColor];
        self.phoneNumberImageView.image = [UIImage imageNamed:@"denglu_2.png"];
    } else {
        self.passwordView.layer.borderColor = [[UIColor colorFromHexCode:@"#C2C2C2"] CGColor];
        self.passwordImageView.image = [UIImage imageNamed:@"mima_2.png"];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.phoneNumberTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
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