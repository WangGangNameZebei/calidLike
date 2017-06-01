//
//  PropertyActivationViewController.h
//  claidApp
//
//  Created by kevinpc on 2017/5/3.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "PropertyActivationSingleTon.h"
#import "PropertyActivationViewControllerDataSource.h"

@interface PropertyActivationViewController : BaseViewController <pALanyaDelegate,UITableViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITableView *paVCTableiVew;

@property (strong, nonatomic) IBOutlet UIView *pAPhoneNumberView;
@property (strong, nonatomic) IBOutlet UIView *pAPasswordView;
@property (strong, nonatomic) IBOutlet UIView *pAConfirmPasswordView;
@property (strong, nonatomic) IBOutlet UIImageView *pAPhoneNumberImageView;
@property (strong, nonatomic) IBOutlet UIImageView *pAPasswordImageView;
@property (strong, nonatomic) IBOutlet UIImageView *pAConfirmPasswordImageView;
@property (strong, nonatomic) IBOutlet UITextField *pAPhoneNumberTextField;
@property (strong, nonatomic) IBOutlet UITextField *pAPasswordTextField;
@property (strong, nonatomic) IBOutlet UITextField *pAConfirmPasswordTextField;
@property (strong, nonatomic) IBOutlet UILabel *pATitleLabel;
@property (strong, nonatomic) IBOutlet UIButton *uploadButton;      //提交注册按钮

@property (strong, nonatomic) NSString *userInfo;           //用户数据
@property (strong, nonatomic) NSString *titleLabelString;
@property (strong, nonatomic) PropertyActivationSingleTon *paSingleTon;
@property (strong, nonatomic) NSMutableArray *paLnyaNameArray;
@property (strong, nonatomic) PropertyActivationViewControllerDataSource *propertyActionViewControllerDataSource;

@end
