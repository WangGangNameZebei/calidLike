//
//  LoginViewController.h
//  claidApp
//
//  Created by kevinpc on 2016/10/31.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomTabBarController.h"

@interface LoginViewController : BaseViewController <UITextFieldDelegate,UIApplicationDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *phoneNumberView;
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UIImageView *phoneNumberImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;


- (CustomTabBarController *)createCustomTabBarController;       //跳转 前 创建 Tabbar
- (NSArray *)createTabBarGroups;                                // 跳转前  编辑 Tabbar  信息
@end
