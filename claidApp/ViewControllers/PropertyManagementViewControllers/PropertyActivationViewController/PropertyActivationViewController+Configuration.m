//
//  PropertyActivationViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2017/5/3.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "PropertyActivationViewController+Configuration.h"
#import "UIColor+Utility.h"
#import "PropertyActivationViewController+LogicalFlow.h"
#import "ParkModifyViewController.h"
@implementation PropertyActivationViewController (Configuration)

- (void)configureViews {
    [self viewdataInfoinit];
    [self singleTonEdit];
    [self textFieldViewEdit];
    [self phoneNumberAndpasswordViewEdit];
    [self addGestRecognizer];
    [self locationEdit];  // 定位
    
}

- (void)viewdataInfoinit{
   if (self.userInfo.length < 10){
     self.uploadButton.backgroundColor = [UIColor setupGreyColor]; //  初始按钮 灰色
   } else {
     self.uploadButton.backgroundColor = [UIColor setipBlueColor]; //  初始按钮 灰色
   }
    self.stopBiaoshi = 1;
    [self.uploadButton setTitle:@"提交" forState:UIControlStateNormal];
    self.chongzhiPasswordView.hidden = NO;
    [self.chongzhiButton setImage:[UIImage imageNamed:@"gouxian_gray"] forState:UIControlStateNormal];
}
- (void)propertyNameAlertEditdataStr:(NSString *)datastr {
    if (!self.propertyNameAlertView){
        self.propertyNameAlertView = [[UIAlertView alloc] initWithTitle:@"请输入管理园区名称" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        self.propertyNameAlertView.tag = 2;
        if ([datastr isEqualToString:@"1"]){
            [self.propertyNameAlertView  setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
            UITextField *nameFieldOne = [self.propertyNameAlertView  textFieldAtIndex:0];
            nameFieldOne.tag =10;
            nameFieldOne.placeholder = @"您的园区名是...";
            UITextField *nameFieldTow = [self.propertyNameAlertView  textFieldAtIndex:1];
            nameFieldTow.secureTextEntry = NO;
            nameFieldTow.tag = 11;
            nameFieldTow.placeholder = @"园区所在街道名称是...";
            nameFieldTow.text  = self.dizhiString;
        } else {
            [self.propertyNameAlertView  setAlertViewStyle:UIAlertViewStylePlainTextInput];
            UITextField *nameFieldOne = [self.propertyNameAlertView  textFieldAtIndex:0];
            if ([datastr isEqualToString:@"2"]){
                nameFieldOne.tag = 0;
                nameFieldOne.placeholder = @"您的园区名是...";
            } else {
                nameFieldOne.tag = 1;
                nameFieldOne.placeholder = @"园区所在街道名称是...";
                nameFieldOne.text  = self.dizhiString;
            }
            
           
            
        }
        
        [self.propertyNameAlertView  show];
    }
}

- (void)singleTonEdit {
    self.paSingleTon = [PropertyActivationSingleTon sharedInstance];
    [self.paSingleTon initialization];
    self.paSingleTon.delegate = self;
}

#pragma mark 初始化定位管理器
- (void)locationEdit {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self locationfindMe];
}
- (void)locationfindMe{
    /** 由于IOS8中定位的授权机制改变 需要进行手动授权
     * 获取授权认证，两个方法：
     * [self.locationManager requestWhenInUseAuthorization];
     * [self.locationManager requestAlwaysAuthorization];
     */
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        NSLog(@"requestAlwaysAuthorization");
        [self.locationManager requestAlwaysAuthorization];
    }
    
    //开始定位，不断调用其代理方法
    [self.locationManager startUpdatingLocation];
    NSLog(@"start gps");
}

#pragma mark paLanyaDelegate

- (void)pADoSomethingEveryFrame:(NSInteger)array {
    if(array == 1){     // 扫描到发卡器 进行连接
      [self.paSingleTon getPeripheralWithIdentifierAndConnect:FAKAQI_TON_UUID_STR];
    } else if (array == 2){     //发出厂卡
      // 发出厂卡
    }
    
}

- (void)pADoSomethingtishiFrame:(NSString *)string {
    if ([string isEqualToString:@"连接成功"]) {
        self.pALanyaLabel.text = @"已连接";
        [self.paSingleTon sendCommand:@"99"];       //发送数据

    } else if ([string isEqualToString:@"断开连接"]) {
      
         self.pALanyaLabel.text = @"已断开";
    } else if (string.length == 106 && [[string substringWithRange:NSMakeRange(0,2)] isEqualToString:@"bb"]){
        [self checkStatusOfCardPOSTdataStr:[string substringWithRange:NSMakeRange(2, 104)]];
    } else {
        self.userInfo = [string substringWithRange:NSMakeRange(0,208)];
        self.pAPhoneNumberTextField.text = [NSString stringWithFormat:@"%@", [string substringWithRange:NSMakeRange(208, 11)]];
        self.uploadButton.backgroundColor = [UIColor setipBlueColor];
        [self promptInformationActionWarningString:@"发卡成功"];
    }
}
    
#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}


//textField 编辑
- (void)textFieldViewEdit {
    self.pAPhoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;        //数字键盘
    self.pAPhoneNumberTextField.clearButtonMode = UITextFieldViewModeAlways;
    self.pAPhoneNumberTextField.delegate = self;
    
}

//  textFieldView编辑
- (void)phoneNumberAndpasswordViewEdit {
    [self viewlayer:self.pAPhoneNumberView];
}

#pragma mark UIView 边框编辑
- (void)viewlayer:(UIView *)view {
    view.layer.cornerRadius = 6;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 1;
    view.layer.borderColor = [[UIColor setupGreyColor] CGColor];
}

#pragma mark textField 代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.tag == 1) {
        self.pAPhoneNumberView.layer.borderColor = [[UIColor setipBlueColor] CGColor];
        self.pAPhoneNumberImageView.image = [UIImage imageNamed:@"login_accountNumber_blue"];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 1) {
        self.pAPhoneNumberView.layer.borderColor = [[UIColor setupGreyColor] CGColor];
        self.pAPhoneNumberImageView.image = [UIImage imageNamed:@"login_accountNumber_gray"];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.pAPhoneNumberTextField resignFirstResponder];
    return YES;
}
#pragma mark - 空白处收起键盘
- (void)addGestRecognizer {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped:)];
    tap.numberOfTouchesRequired =1;
    tap.numberOfTapsRequired =1;
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}
- (void)tapped:(UIGestureRecognizer *)gestureRecognizer{
    [self.view endEditing:YES];
}
#pragma mark - 定位代理
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // 1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
   // CLLocationCoordinate2D coordinate = location.coordinate;
   // NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
    
    // 2.停止定位
    [manager stopUpdatingLocation];
    
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    
    CLLocation *cl = [[CLLocation alloc] initWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
    [clGeoCoder reverseGeocodeLocation:cl completionHandler: ^(NSArray *placemarks,NSError *error) {

        for (CLPlacemark *placeMark in placemarks) {
            NSDictionary *addressDic = placeMark.addressDictionary;
            
            NSString *state=[addressDic objectForKey:@"State"];
            
            NSString *city=[addressDic objectForKey:@"City"];
            
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
            
            NSString *street=[addressDic objectForKey:@"Street"];
            self.dizhiString = [NSString stringWithFormat:@"%@%@%@",state,city,subLocality];
            NSLog(@"所在城市====%@ %@ %@ %@", state, city, subLocality, street);
        
            
        }
        
    }];
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值20所在
    }
}


@end
