//
//  ParkModifyViewController.h
//  claidApp
//
//  Created by kevinpc on 2017/9/15.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>       //系统定位
#import "LLImagePickerView.h"

@interface ParkModifyViewController : BaseViewController <CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *parkNameTextfield;
@property (strong, nonatomic) IBOutlet UITextField *parkAddressTextfield;
@property (strong, nonatomic) IBOutlet UITextView *parkAddressTextView;
@property (strong, nonatomic) IBOutlet UITextField *propertyNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *propertyPhoneNumber;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tijiaoButtonTop;
@property (strong, nonatomic) CLLocationManager* locationManager;       // 定位服务
@property (strong, nonatomic)NSString *addressString;  //  定位地址
@property (assign, nonatomic) BOOL pictrueChangeBool;

@property (strong, nonatomic)LLImagePickerView *pickerV;
@property (strong, nonatomic)NSMutableArray *imageDataArray;

@end
