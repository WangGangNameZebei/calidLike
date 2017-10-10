//
//  RetrieveThePasswordViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2017/9/26.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "RetrieveThePasswordViewController+Configuration.h"
#import "UIColor+Utility.h"

@implementation RetrieveThePasswordViewController (Configuration)
- (void)configureViews{
    [self textFieldViewEdit];
    [self passwordViewEdit];
    [self addGestRecognizer];
}

//textField 编辑
- (void)textFieldViewEdit {
    
    self.phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;        //数字键盘
    self.phoneNumberTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.phoneNumberTextField.delegate = self;
    self.verificationCodeTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.verificationCodeTextField.delegate = self;
}

//  textFieldView编辑
- (void)passwordViewEdit {
    [self viewlayer:self.phoneNumberView];
    [self viewlayer:self.verificationCodeView];
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
    } else {
        self.verificationCodeView.layer.borderColor = [[UIColor setipBlueColor] CGColor];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 1) {
        self.phoneNumberView.layer.borderColor = [[UIColor setupGreyColor] CGColor];
    } else {
        self.verificationCodeView.layer.borderColor = [[UIColor setupGreyColor] CGColor];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.phoneNumberTextField resignFirstResponder];
    [self.verificationCodeTextField resignFirstResponder];
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
