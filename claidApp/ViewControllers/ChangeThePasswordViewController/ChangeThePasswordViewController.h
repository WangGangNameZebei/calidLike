//
//  ChangeThePasswordViewController.h
//  claidApp
//
//  Created by kevinpc on 2017/6/24.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"

@interface ChangeThePasswordViewController : BaseViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *oldPasswordView;
@property (strong, nonatomic) IBOutlet UIView *confirmnewPasswordView;
@property (strong, nonatomic) IBOutlet UIView *changenewPasswordView;
@property (strong, nonatomic) IBOutlet UIImageView *oldPasswordImage;
@property (strong, nonatomic) IBOutlet UIImageView *changenewPasswordImage;
@property (strong, nonatomic) IBOutlet UIImageView *confirmnewPasswordImage;
@property (strong, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (strong, nonatomic) IBOutlet UITextField *changenewPasswordTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmnewPasswoedTextField;


@end
