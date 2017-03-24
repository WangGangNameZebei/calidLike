//
//  invitaionCodeViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2017/3/23.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "invitaionCodeViewController+Configuration.h"
#import "UIColor+Utility.h"


@implementation invitaionCodeViewController (Configuration)
- (void)configureViews {
    [self textFieldViewEdit];
    [self phoneNumberAndpasswordViewEdit];
    [self addGestRecognizer];
    self.requestBool = YES;
}

//textField 编辑
- (void)textFieldViewEdit {
    self.fangkePhoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;        //数字键盘
    self.fangkePhoneNumberTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.fangkePhoneNumberTextField.delegate = self;
}

//  textFieldView编辑
- (void)phoneNumberAndpasswordViewEdit {
    [self viewlayer:self.fangkePhoneNumberView];
    [self viewlayer:self.bezhuTextView];
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
        self.fangkePhoneNumberView.layer.borderColor = [[UIColor colorFromHexCode:@"#1296db"] CGColor];
        self.fangkePhoneNumberImageView.image = [UIImage imageNamed:@"login_accountNumber_blue"];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
        self.fangkePhoneNumberView.layer.borderColor = [[UIColor colorFromHexCode:@"#C2C2C2"] CGColor];
        self.fangkePhoneNumberImageView.image = [UIImage imageNamed:@"login_accountNumber_gray"];
  
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.fangkePhoneNumberTextField resignFirstResponder];
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
