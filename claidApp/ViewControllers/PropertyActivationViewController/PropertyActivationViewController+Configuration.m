//
//  PropertyActivationViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2017/5/3.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "PropertyActivationViewController+Configuration.h"
#import "UIColor+Utility.h"

@implementation PropertyActivationViewController (Configuration)

- (void)configureViews {
    [self singleTonEdit];

    [self textFieldViewEdit];
    [self phoneNumberAndpasswordViewEdit];
    [self addGestRecognizer];
}

- (void)singleTonEdit {
    self.pATitleLabel.text = self.titleLabelString; //标题
    self.uploadButton.backgroundColor = [UIColor colorFromHexCode:@"#E6E6E6"]; //  初始按钮 灰色

    if ([self.titleLabelString isEqualToString:@"续卡"]) {
        [self.uploadButton setTitle:@"提交" forState:UIControlStateNormal];
        self.chongzhiPasswordView.hidden = NO;
        [self.chongzhiButton setImage:[UIImage imageNamed:@"gouxian_gray"] forState:UIControlStateNormal];
        self.pAPasswordLabel.hidden = YES;
        self.pAConfirmPasswordLabel.hidden = YES;
        self.pAPasswordView.hidden = YES;
        self.pAConfirmPasswordView.hidden = YES;
        
    } else {
        [self.chongzhiButton setImage:[UIImage imageNamed:@"gouxian_blue"] forState:UIControlStateNormal];
        [self.uploadButton setTitle:@"注册" forState:UIControlStateNormal];
        self.chongzhiPasswordView.hidden = YES;
    }
    self.paSingleTon = [PropertyActivationSingleTon sharedInstance];
    [self.paSingleTon initialization];
    self.paSingleTon.delegate = self;
  
}


#pragma mark paLanyaDelegate 

- (void)pADoSomethingEveryFrame:(NSInteger *)array {
    [self.paSingleTon getPeripheralWithIdentifierAndConnect:FAKAQI_TON_UUID_STR];
}

- (void)pADoSomethingtishiFrame:(NSString *)string {
    if ([string isEqualToString:@"连接成功"]) {
        self.pALanyaLabel.text = @"已连接";
    } else if ([string isEqualToString:@"断开连接"]) {
         self.pALanyaLabel.text = @"已断开";
    } else {
        self.userInfo = [string substringWithRange:NSMakeRange(0,208)];
        self.pAPhoneNumberTextField.text = [NSString stringWithFormat:@"%@", [string substringWithRange:NSMakeRange(208, 11)]];
        self.uploadButton.backgroundColor = [UIColor colorFromHexCode:@"#1296db"];
        [self promptInformationActionWarningString:@"发卡成功"];
    }
}
    
#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}


//textField 编辑
- (void)textFieldViewEdit {
    self.pAPhoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;        //数字键盘
    self.pAPhoneNumberTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.pAPhoneNumberTextField.delegate = self;
    
    self.pAPasswordTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.pAPasswordTextField.delegate = self;
    self.pAConfirmPasswordTextField.clearButtonMode = UITextFieldViewModeAlways;
   
    self.pAConfirmPasswordTextField.delegate = self;
    if ([self.titleLabelString isEqualToString:@"续卡"]) {
        self.pAPasswordTextField.secureTextEntry = YES;
        self.pAConfirmPasswordTextField.secureTextEntry = YES;
    } else {
        self.pAPasswordTextField.text = [NSString stringWithFormat:@"123456"];
        self.pAConfirmPasswordTextField.text = [NSString stringWithFormat:@"123456"];

    }
    
}

//  textFieldView编辑
- (void)phoneNumberAndpasswordViewEdit {
    [self viewlayer:self.pAPhoneNumberView];
    [self viewlayer:self.pAPasswordView];
    [self viewlayer:self.pAConfirmPasswordView];
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
        self.pAPhoneNumberView.layer.borderColor = [[UIColor colorFromHexCode:@"#1296db"] CGColor];
        self.pAPhoneNumberImageView.image = [UIImage imageNamed:@"login_accountNumber_blue"];
    } else if (textField.tag == 2) {
        self.pAPasswordView.layer.borderColor = [[UIColor  colorFromHexCode:@"#1296db"] CGColor];
        self.pAPasswordImageView.image = [UIImage imageNamed:@"login_passWord_blue"];
    }else if (textField.tag == 3){
        self.pAConfirmPasswordView.layer.borderColor = [[UIColor  colorFromHexCode:@"#1296db"] CGColor];
        self.pAConfirmPasswordImageView.image = [UIImage imageNamed:@"login_passWord_blue"];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 1) {
        self.pAPhoneNumberView.layer.borderColor = [[UIColor colorFromHexCode:@"#C2C2C2"] CGColor];
        self.pAPhoneNumberImageView.image = [UIImage imageNamed:@"login_accountNumber_gray"];
    } else if (textField.tag == 2) {
        self.pAPasswordView.layer.borderColor = [[UIColor colorFromHexCode:@"#C2C2C2"] CGColor];
        self.pAPasswordImageView.image = [UIImage imageNamed:@"login_passWord_gray"];
    } else if (textField.tag == 3){
        self.pAConfirmPasswordView.layer.borderColor = [[UIColor colorFromHexCode:@"#C2C2C2"] CGColor];
        self.pAConfirmPasswordImageView.image = [UIImage imageNamed:@"login_passWord_gray"];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.pAPhoneNumberTextField resignFirstResponder];
    [self.pAPasswordTextField resignFirstResponder];
    [self.pAConfirmPasswordTextField resignFirstResponder];
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
