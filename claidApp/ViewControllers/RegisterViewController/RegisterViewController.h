//
//  RegisterViewController.h
//  claidApp
//
//  Created by kevinpc on 2016/11/1.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterViewController : BaseViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *phoneNumberView;
@property (weak, nonatomic) IBOutlet UIView *mishiView;
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *mishiTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIImageView *phoneNumberImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mishiImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;
@property (strong, nonatomic) IBOutlet UIView *confirmPasswordView;
@property (strong, nonatomic) IBOutlet UIImageView *confirmPasswordImageView;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (strong, nonatomic) IBOutlet UIButton *verificationButton;    //获取验证码
@property (strong, nonatomic) IBOutlet UILabel *verificationLabel;
@property (assign, nonatomic) NSInteger timeDown;
@property (strong, nonatomic) NSTimer * jishuTimer;  // 验证码倒计时

- (void)obtainYanzhengmaAction;
@end
