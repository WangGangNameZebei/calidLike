//
//  MycradInfoViewController.m
//  claidApp
//
//  Created by kevinpc on 2017/5/6.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "MycradInfoViewController.h"
#import "MycradInfoViewController+Configuration.h"
#import "SingleTon.h"

@implementation MycradInfoViewController

+ (instancetype) create {
    MycradInfoViewController *mycradinfoVC = [[MycradInfoViewController alloc] initWithNibName:@"MycradInfoViewController" bundle:nil];
    return mycradinfoVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}



- (IBAction)myinforeturnButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark- 摇一摇
- (IBAction)sharkSwitchAction:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    if (mySwitch.isOn){
        [self userInfowriteuserkey:@"shakeswitch" uservalue:@"YES"];
    } else{
        [self userInfowriteuserkey:@"shakeswitch" uservalue:@"NO"];
    }
}
#pragma mark- 亮屏
- (IBAction)brightScreenSwitchAction:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    if (mySwitch.isOn){
         [self userInfowriteuserkey:@"brightScreenswitch" uservalue:@"YES"];
    } else {
        [self userInfowriteuserkey:@"brightScreenswitch" uservalue:@"NO"];
    }     
}
#pragma mark - 自动
- (IBAction)automaticSwitchAction:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    SingleTon *ton = [SingleTon sharedInstance];
    [ton initialization];
    if (mySwitch.isOn){
        [self userInfowriteuserkey:@"switch" uservalue:@"YES"];
        NSString *strUUid = SINGLE_TON_UUID_STR;
        if (!strUUid) {
            [ton startScan]; // 扫描
            return;
        }
        [ton getPeripheralWithIdentifierAndConnect:SINGLE_TON_UUID_STR];
       
    } else {
        [self userInfowriteuserkey:@"switch" uservalue:@"NO"];
         [ton.manager stopScan];  //停止  扫描
    }
   

    
}
#pragma mark - 震动
- (IBAction)shockSwitchAction:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    if (mySwitch.isOn){
        [self userInfowriteuserkey:@"shockswitch" uservalue:@"YES"];
    } else {
        [self userInfowriteuserkey:@"shockswitch" uservalue:@"NO"];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
