//
//  AboutUsViewController+Configuration.m
//  claidApp
//
//  Created by Zebei on 2017/10/23.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "AboutUsViewController+Configuration.h"
#import "MyTableViewCell.h"
#import "UIScreen+Utility.h"
#import "UIColor+Utility.h"
#import "AboutUsViewController+LogicalFlow.h"

@implementation AboutUsViewController (Configuration)

- (void)configureViews {
    [self aboutusTableViewEdit];
    [self tableViewFooterVersionEdit];
    [self singleTonEdit];
    [self locationEdit];
}
- (void)manageApplicationsEdits {
    NSString  *strLanya = FAKAQI_TON_UUID_STR;
    if (strLanya.length < 3) {
        [self.managementSingleTon startScan]; // 扫描
    } else {
        [self.managementSingleTon getPeripheralWithIdentifierAndConnect:strLanya];
    }
}

- (void)aboutusTableViewEdit {
    [self.aboutUsTableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:nil] forCellReuseIdentifier:My_TABLEVIEW_CELL];
    self.aboutUsViewControllerDataSource = [AboutUsViewControllerDataSource new];
    self.aboutUsTableView.delegate = self;
    self.aboutUsTableView.dataSource = self.aboutUsViewControllerDataSource;
    self.aboutUsViewControllerDataSource.myDataArray = [NSMutableArray arrayWithObjects:@"使用教学",@"意见反馈",@"软件分享",@"管理申请", nil];
    self.aboutUsViewControllerDataSource.myImageArray = [NSMutableArray arrayWithObjects:@"tutorial_blue",@"my_feedback_blue",@"app_shareIt_blue",@"my_bluetooth_blue", nil];
}

- (void)tableViewFooterVersionEdit {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [NSString stringWithFormat:@"当前版本:    %@",[infoDic objectForKey:@"CFBundleShortVersionString"]];
    self.versionLabel.text = appVersion;
}
- (void)singleTonEdit {
    self.managementSingleTon = [ManagementSingleTon sharedInstance];
    [self.managementSingleTon initialization];
    self.managementSingleTon.delegate = self;
}
#pragma mark-蓝牙 delegate
- (void)managementtishiFrame:(NSString *)string {
    if ([string isEqualToString:@"寻到发卡器"]){
       [self.managementSingleTon getPeripheralWithIdentifierAndConnect:FAKAQI_TON_UUID_STR];
    } else if ([string isEqualToString:@"连接成功"]) {
         [self.managementSingleTon sendCommand:@"99"];       //发送数据
        [self promptInformationActionWarningString:@"链接到发卡器"];
    } else if (string.length == 106  && [[string substringWithRange:NSMakeRange(0,2)] isEqualToString:@"bb"]){
        [self checkStatusOfCardPOSTdataStr:[string substringWithRange:NSMakeRange(2, 104)]];
    } else if (string.length == 96  && [[string substringWithRange:NSMakeRange(0,2)] isEqualToString:@"00"]){
         [self administratorApplicationPOSTdataaccountsstr:[string substringWithRange:NSMakeRange(46,11)] pptCellId:[string substringWithRange:NSMakeRange(0,8)] role:[string substringWithRange:NSMakeRange(91,1)]];
    } else {
        
    }
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
#pragma mark - 定位代理
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // 1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
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
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
}


- (void)propertyNameAlertEditdataStr:(NSString *)datastr {
    if (!self.ablouusAlertView){
        self.ablouusAlertView = [[UIAlertView alloc] initWithTitle:@"请输入管理园区名称" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        self.ablouusAlertView.tag = 2;
        if ([datastr isEqualToString:@"1"]){
            [self.ablouusAlertView  setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
            UITextField *nameFieldOne = [self.ablouusAlertView  textFieldAtIndex:0];
            nameFieldOne.tag =10;
            nameFieldOne.placeholder = @"您的园区名是...";
            UITextField *nameFieldTow = [self.ablouusAlertView  textFieldAtIndex:1];
            nameFieldTow.secureTextEntry = NO;
            nameFieldTow.tag = 11;
            nameFieldTow.placeholder = @"园区所在街道名称是...";
            nameFieldTow.text  = self.dizhiString;
        } else {
            [self.ablouusAlertView  setAlertViewStyle:UIAlertViewStylePlainTextInput];
            UITextField *nameFieldOne = [self.ablouusAlertView  textFieldAtIndex:0];
            if ([datastr isEqualToString:@"2"]){
                nameFieldOne.tag = 0;
                nameFieldOne.placeholder = @"您的园区名是...";
            } else {
                nameFieldOne.tag = 1;
                nameFieldOne.placeholder = @"园区所在街道名称是...";
                nameFieldOne.text  = self.dizhiString;
            }
            
            
            
        }
        
        [self.ablouusAlertView  show];
    }
}
@end
