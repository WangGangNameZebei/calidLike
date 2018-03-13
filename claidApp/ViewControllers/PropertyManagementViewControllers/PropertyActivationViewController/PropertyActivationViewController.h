//
//  PropertyActivationViewController.h
//  claidApp
//
//  Created by kevinpc on 2017/5/3.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import "PropertyActivationSingleTon.h"
#import <CoreLocation/CoreLocation.h>       //系统定位

@interface PropertyActivationViewController : BaseViewController <pALanyaDelegate,UIAlertViewDelegate,CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UIView *chongzhiPasswordView;
@property (strong, nonatomic) IBOutlet UIButton *chongzhiButton;

@property (strong, nonatomic) IBOutlet UIView *pAPhoneNumberView;
@property (strong, nonatomic) IBOutlet UIImageView *pAPhoneNumberImageView;

@property (strong, nonatomic) IBOutlet UILabel *pAPhoneNumberLabel;
@property (strong, nonatomic) IBOutlet UIButton *uploadButton;      //提交注册按钮
@property (strong, nonatomic) IBOutlet UILabel *pALanyaLabel;

@property (strong, nonatomic) NSString *userInfo;           //用户数据
@property (strong, nonatomic) PropertyActivationSingleTon *paSingleTon;     //蓝牙

@property (strong, nonatomic)UIAlertView *propertyNameAlertView;                  //物业名称
@property (assign, nonatomic) NSInteger stopBiaoshi; // 用户 停用标识  1 -启用／0 -停用

@property (strong, nonatomic) CLLocationManager* locationManager;       // 定位服务
@property (strong, nonatomic) NSString *dizhiString;  // 地址拼接
@property (strong, nonatomic)NSString *xiaoquNumber;// 小区号码
@end
