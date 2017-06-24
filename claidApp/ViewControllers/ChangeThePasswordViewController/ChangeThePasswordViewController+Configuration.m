//
//  ChangeThePasswordViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2017/6/24.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "ChangeThePasswordViewController+Configuration.h"
#import "UIColor+Utility.h"

@implementation ChangeThePasswordViewController (Configuration)

- (void)configureViews{
    [self textFieldViewEdit];
    [self passwordViewEdit];
    [self addGestRecognizer];
}

//textField 编辑
- (void)textFieldViewEdit {
    self.oldPasswordTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.oldPasswordTextField.delegate = self;
    
    self.changenewPasswordTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.changenewPasswordTextField.secureTextEntry = YES;
    self.changenewPasswordTextField.delegate = self;
    
    self.confirmnewPasswoedTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.confirmnewPasswoedTextField.secureTextEntry = YES;
    self.confirmnewPasswoedTextField.delegate = self;
}

//  textFieldView编辑
- (void)passwordViewEdit {
    [self viewlayer:self.oldPasswordView];
    [self viewlayer:self.changenewPasswordView];
    [self viewlayer:self.confirmnewPasswordView];
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
        self.oldPasswordView.layer.borderColor = [[UIColor colorFromHexCode:@"#1296db"] CGColor];
        self.oldPasswordImage.image = [UIImage imageNamed:@"login_passWord_blue"];
    } else if (textField.tag == 2) {
        self.changenewPasswordView.layer.borderColor = [[UIColor colorFromHexCode:@"#1296db"] CGColor];
        self.changenewPasswordImage.image = [UIImage imageNamed:@"login_passWord_blue"];
    } else {
        self.confirmnewPasswordView.layer.borderColor = [[UIColor  colorFromHexCode:@"#1296db"] CGColor];
        self.confirmnewPasswordImage.image = [UIImage imageNamed:@"login_passWord_blue"];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 1) {
        self.oldPasswordView.layer.borderColor = [[UIColor colorFromHexCode:@"#C2C2C2"] CGColor];
        self.oldPasswordImage.image = [UIImage imageNamed:@"login_passWord_gray"];
    } else if (textField.tag == 2) {
        self.changenewPasswordView.layer.borderColor = [[UIColor colorFromHexCode:@"#C2C2C2"] CGColor];
        self.changenewPasswordImage.image = [UIImage imageNamed:@"login_passWord_gray"];
        
    } else {
        self.confirmnewPasswordView.layer.borderColor = [[UIColor colorFromHexCode:@"#C2C2C2"] CGColor];
        self.confirmnewPasswordImage.image = [UIImage imageNamed:@"login_passWord_gray"];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.oldPasswordTextField resignFirstResponder];
    [self.changenewPasswordTextField resignFirstResponder];
    [self.confirmnewPasswoedTextField resignFirstResponder];
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
