//
//  ParkModifyViewController+Configuration.m
//  claidApp
//
//  Created by kevinpc on 2017/9/15.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "ParkModifyViewController+Configuration.h"
#import "ParkModifyViewController+LogicalFlow.h"
#import "UIScreen+Utility.h"
#import "UIImage+Utility.h"

@implementation ParkModifyViewController (Configuration)
- (void)configureViews {
    [self addGestRecognizer];
    [self llImagePickerViewEdit];
}

- (void)textFieldEdit {
    self.parkAddressTextfield.text = self.addressString;
}
#pragma mark- 图片添加
- (void)llImagePickerViewEdit {
    [self getpostInfoAction];
    UIView *headerV = [UIView new];
    self.pickerV = [LLImagePickerView ImagePickerViewWithFrame:CGRectMake(0, 0, [UIScreen screenWidth],0) CountOfRow:5];
    self.pickerV.showAddButton = YES;
    self.pickerV.showDelete = YES;
    self.pickerV.maxImageSelected = 3;
    self.pickerV.allowMultipleSelection = NO;
    self.pickerV.allowPickingVideo = YES;
    // 如果在预览的基础上又要添加照片 则需要调用此方法 来动态变换高度
    [self.pickerV observeViewHeight:^(CGFloat height) {
        CGRect rect = headerV.frame;
        rect.size.height = CGRectGetMaxY(self.pickerV.frame);
        headerV.frame = rect;
        self.tijiaoButtonTop.constant = height +10;
    }];
    self.imageDataArray = [NSMutableArray new];
    [self.pickerV observeSelectedMediaArray:^(NSArray<LLImagePickerModel *> *list) {
        [self.imageDataArray removeAllObjects];
        self.pictrueChangeBool = YES;
        for (LLImagePickerModel *model in list) {
            // 在这里取到模型的数据
            [self.imageDataArray addObject:model.image];
        }
    }];
    self.tijiaoButtonTop.constant = CGRectGetMaxY(self.pickerV.frame) +10;
    [headerV addSubview:self.pickerV];
    headerV.frame = CGRectMake(0, 340, self.view.frame.size.width, CGRectGetMaxY(self.pickerV.frame));
    [self.view addSubview:headerV];
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
            
            //NSString *street=[addressDic objectForKey:@"Street"];
            self.addressString = [NSString stringWithFormat:@"%@%@%@",state,city,subLocality];
            [self textFieldEdit];
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
