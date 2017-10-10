//
//  RetrieveTowpasswordViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2017/9/26.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "RetrieveTowpasswordViewController+Configuration.h"
#import "UIColor+Utility.h"

@implementation RetrieveTowpasswordViewController (Configuration)
- (void)configureViews{
    [self textFieldViewEdit];
    [self passwordViewEdit];
    [self addGestRecognizer];
}

//textField 编辑
- (void)textFieldViewEdit {
    self.passWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.passWordTextField.secureTextEntry = YES;
    self.passWordTextField.delegate = self;
    
    self.confirmPassWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.confirmPassWordTextField.secureTextEntry = YES;
    self.confirmPassWordTextField.delegate = self;
}

//  textFieldView编辑
- (void)passwordViewEdit {
    [self viewlayer:self.passWordView];
    [self viewlayer:self.confirmPssWordView];
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
        self.passWordView.layer.borderColor = [[UIColor setipBlueColor] CGColor];
    } else {
        self.confirmPssWordView.layer.borderColor = [[UIColor setipBlueColor] CGColor];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 1) {
        self.passWordView.layer.borderColor = [[UIColor setupGreyColor] CGColor];
    } else {
        self.confirmPssWordView.layer.borderColor = [[UIColor setupGreyColor] CGColor];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.passWordTextField resignFirstResponder];
    [self.confirmPassWordTextField resignFirstResponder];
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
