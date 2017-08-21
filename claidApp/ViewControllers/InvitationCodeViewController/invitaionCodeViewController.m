//
//  invitaionCodeViewController.m
//  claidApp
//
//  Created by kevinpc on 2017/3/23.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "invitaionCodeViewController.h"
#import "invitaionCodeViewController+Configuration.h"
#import "invitaionCodeViewController+LogicalFlow.h"
#import "SYContacter.h"


@implementation invitaionCodeViewController

+ (instancetype) create {
    invitaionCodeViewController *invitionCodeVC = [[invitaionCodeViewController alloc] initWithNibName:@"invitaionCodeViewController" bundle:nil];
    return invitionCodeVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
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

- (IBAction)returnAction:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)tijiaoButtonAction:(id)sender {
    if ([self isMobileNumber:self.fangkePhoneNumberTextField.text]){
        [self promptInformationActionWarningString:@"电话号码不能为空!"];
        return;
    }
    if (self.requestBool){
     self.requestBool = NO;
      [self invitionCodeForPhonenumber:self.fangkePhoneNumberTextField.text beizhutext:self.bezhuTextView.text];
    }
}
//通讯录按钮
- (IBAction)contactsButtonAction:(id)sender {
    
    SYContactsPickerController *vcContacts = [[SYContactsPickerController alloc] init];
    vcContacts.delegate = self;
    [self.navigationController pushViewController:vcContacts animated:NO];
}
#pragma mark - SYContactsPickerControllerDelegate

- (void)contactsPickerController:(SYContactsPickerController *)picker didSelectContacter:(SYContacter *)contacter {
    self.fangkePhoneNumberTextField.text = [NSString stringWithFormat:@"%@",contacter.phone];

}

@end
