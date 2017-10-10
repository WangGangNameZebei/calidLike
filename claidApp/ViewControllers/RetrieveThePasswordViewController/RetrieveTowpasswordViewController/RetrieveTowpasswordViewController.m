//
//  RetrieveTowpasswordViewController.m
//  claidApp
//
//  Created by kevinpc on 2017/9/26.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "RetrieveTowpasswordViewController.h"
#import "RetrieveTowpasswordViewController+Configuration.h"
#import "RetrieveTowpasswordViewController+LogicalFlow.h"

@implementation RetrieveTowpasswordViewController

+ (instancetype) create {
    RetrieveTowpasswordViewController *retrieveTowpasswordVC = [[RetrieveTowpasswordViewController alloc] initWithNibName:@"RetrieveTowpasswordViewController" bundle:nil];
    return retrieveTowpasswordVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}
- (IBAction)returnButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)submitButtonAction:(id)sender {
    if (self.passWordTextField.text.length < 6 || self.passWordTextField.text.length > 16){
        [self promptInformationActionWarningString:@"请输入6-16位密码!"];
        return;
    }
    
    if ([self.passWordTextField.text isEqualToString:self.confirmPassWordTextField.text] ){
        [self retrieveThePsssWordPostDataPhoneNumber:self.phoneNumberStr passWordStr:self.passWordTextField.text];
    } else {
        [self promptInformationActionWarningString:@"密码输入不一致!"];
    }
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
