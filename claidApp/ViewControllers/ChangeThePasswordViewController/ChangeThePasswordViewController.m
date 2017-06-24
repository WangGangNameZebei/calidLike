//
//  ChangeThePasswordViewController.m
//  claidApp
//
//  Created by kevinpc on 2017/6/24.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "ChangeThePasswordViewController.h"
#import "ChangeThePasswordViewController+Configuration.h"
#import "ChangeThePasswordViewController+LogicalFlow.h"

@implementation ChangeThePasswordViewController

+ (instancetype) create {
    ChangeThePasswordViewController *changeThepasswordVC = [[ChangeThePasswordViewController alloc] initWithNibName:@"ChangeThePasswordViewController" bundle:nil];
    return changeThepasswordVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}

- (IBAction)changeButtonAction:(id)sender {
    if (self.oldPasswordTextField.text.length < 6 || self.oldPasswordTextField.text.length > 16){
        [self promptInformationActionWarningString:@"旧密码长度不符!"];
        return;
    }
    if (self.changenewPasswordTextField.text.length < 6 || self.changenewPasswordTextField.text.length > 16){
        [self promptInformationActionWarningString:@"新密码长度不符!"];
        return;
    }
    if (![self.confirmnewPasswoedTextField.text isEqualToString:self.changenewPasswordTextField.text]){
        [self promptInformationActionWarningString:@"新密码两次输入不一致!"];
        return;
    }
    [self changeThePasswordPOSTForoldpasssword:self.oldPasswordTextField.text newpassword:self.changenewPasswordTextField.text];

}

- (IBAction)returnButtonAction:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
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
