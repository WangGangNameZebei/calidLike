//
//  invitaionCodeViewController.h
//  claidApp
//
//  Created by kevinpc on 2017/3/23.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "SYContactsPickerController.h"

@interface invitaionCodeViewController : BaseViewController<UITextFieldDelegate,SYContactsPickerControllerDelegate>
- (IBAction)returnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *fangkePhoneNumberView;
@property (strong, nonatomic) IBOutlet UITextField *fangkePhoneNumberTextField;
@property (strong, nonatomic) IBOutlet UIImageView *fangkePhoneNumberImageView;
@property (strong, nonatomic) IBOutlet UITextView *bezhuTextView;
- (IBAction)tijiaoButtonAction:(id)sender;


@property (assign, nonatomic) BOOL requestBool;   //网络数据请求标识;
@end
