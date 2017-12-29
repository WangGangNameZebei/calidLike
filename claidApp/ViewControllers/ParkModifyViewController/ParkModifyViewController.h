//
//  ParkModifyViewController.h
//  claidApp
//
//  Created by kevinpc on 2017/9/15.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>       //系统定位

@interface ParkModifyViewController : BaseViewController <CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *parkNameTextfield;
@property (strong, nonatomic) IBOutlet UITextField *parkAddressTextfield;
@property (strong, nonatomic) IBOutlet UITextView *parkAddressTextView;

@property (strong, nonatomic) CLLocationManager* locationManager;       // 定位服务
@property (strong, nonatomic)NSString *addressString;  //  定位地址
@end
