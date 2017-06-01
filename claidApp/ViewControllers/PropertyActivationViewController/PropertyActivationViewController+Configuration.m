//
//  PropertyActivationViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2017/5/3.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "PropertyActivationViewController+Configuration.h"
#import "MinFuncTionTableViewCell.h"
#import "UIColor+Utility.h"

@implementation PropertyActivationViewController (Configuration)

- (void)configureViews {
    [self singleTonEdit];
    [self paTableViewEdit];
    [self textFieldViewEdit];
    [self phoneNumberAndpasswordViewEdit];
    [self addGestRecognizer];
}

- (void)singleTonEdit {
    self.pATitleLabel.text = self.titleLabelString; //标题
    if ([self.titleLabelString isEqualToString:@"续卡"]) {
        [self.uploadButton setTitle:@"提交" forState:UIControlStateNormal];
    } else {
        [self.uploadButton setTitle:@"注册" forState:UIControlStateNormal];
    }
    self.paSingleTon = [PropertyActivationSingleTon sharedInstance];
    [self.paSingleTon initialization];
    self.paSingleTon.delegate = self;
    self.paLnyaNameArray = [NSMutableArray array];
}

- (void)paTableViewEdit {
    [self.paVCTableiVew registerNib:[UINib nibWithNibName:@"MinFuncTionTableViewCell" bundle:nil] forCellReuseIdentifier:MINN_FUNCTION_CELL_NIB];
    
    self.propertyActionViewControllerDataSource = [PropertyActivationViewControllerDataSource new];
    self.paVCTableiVew.delegate = self;
    self.paVCTableiVew.dataSource = self.propertyActionViewControllerDataSource;
    self.propertyActionViewControllerDataSource.pAVCDataSourceArray = self.paLnyaNameArray;
}

#pragma mark paLanyaDelegate 

- (void)pADoSomethingEveryFrame:(NSMutableArray *)array {
     self.paLnyaNameArray = array;
}

- (void)pADoSomethingtishiFrame:(NSString *)string {
    if ([string isEqualToString:@"连接成功"]) {
        [self promptInformationActionWarningString:string];
    } else {
        self.userInfo = string;
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
    self.pAPasswordTextField.secureTextEntry = YES;
    self.pAPasswordTextField.delegate = self;
    self.pAConfirmPasswordTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.pAConfirmPasswordTextField.secureTextEntry = YES;
    self.pAConfirmPasswordTextField.delegate = self;
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
