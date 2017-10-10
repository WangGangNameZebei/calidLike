//
//  RetrieveTowpasswordViewController.h
//  claidApp
//
//  Created by kevinpc on 2017/9/26.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"

@interface RetrieveTowpasswordViewController : BaseViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *passWordTextField;
@property (strong, nonatomic) IBOutlet UIView *passWordView;
@property (strong, nonatomic) IBOutlet UITextField *confirmPassWordTextField;
@property (strong, nonatomic) IBOutlet UIView *confirmPssWordView;

@property (strong, nonatomic) NSString *phoneNumberStr;
@end
