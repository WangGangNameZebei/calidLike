//
//  RetrieveThePasswordViewController.h
//  claidApp
//
//  Created by kevinpc on 2017/9/26.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"

@interface RetrieveThePasswordViewController : BaseViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (strong, nonatomic) IBOutlet UIView *phoneNumberView;
@property (strong, nonatomic) IBOutlet UITextField *verificationCodeTextField;
@property (strong, nonatomic) IBOutlet UIView *verificationCodeView;
@property (strong, nonatomic) IBOutlet UIButton *yanzhengmaBUtton;
@property (strong, nonatomic) IBOutlet UILabel *yanzhengmaLabel;

@property (assign, nonatomic) NSInteger timeDown;
@property (strong, nonatomic) NSTimer * jishuTimer;  // 验证码倒计时

- (void)obtainYanzhengmaAction;
@end
