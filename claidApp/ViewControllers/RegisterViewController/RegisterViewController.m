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
    if (self.phoneNumberTextField.text.length==0){
        [self promptInformationActionWarningString:@"电话不能为空!"];
        return;
    }
    if (self.mishiTextField.text.length==0){
        [self promptInformationActionWarningString:@"推荐码不能为空!"];
        return;
    }
    if (self.passwordTextField.text.length==0){
        [self promptInformationActionWarningString:@"密码不能为空!"];
        return;
    }
    if ([self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text] ){
     [self registerPostForUsername:self.phoneNumberTextField.text password:self.passwordTextField.text oraKey:self.mishiTextField.text];
    } else {
       [self promptInformationActionWarningString:@"密码输入不一致!"];
    }
}
- (IBAction)returnButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
