//
//  MyInfoSetUpTableViewCell.m
//  claidApp
//
//  Created by Zebei on 2018/2/1.
//  Copyright © 2018年 kevinpc. All rights reserved.
//

#import "MyInfoSetUpTableViewCell.h"
#import "UIColor+Utility.h"
#import "SingleTon.h"

@implementation MyInfoSetUpTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.baseVC = [[BaseViewController alloc] init];
    [self switchViewEdit];
}


- (void)switchViewEdit {
    self.myInfoshakeSwitch.onTintColor = [UIColor colorFromHexCode:@"1296db"];
    self.myInfoBrightScreenSwitch.onTintColor = [UIColor colorFromHexCode:@"1296db"];
    self.myInfoAutomaticSwitch.onTintColor = [UIColor colorFromHexCode:@"1296db"];
    self.myInfoShockSwitch.onTintColor = [UIColor colorFromHexCode:@"1296db"];
    if ([[self.baseVC userInfoReaduserkey:@"shakeswitch"] isEqualToString:@"YES"]) {
        [self.myInfoshakeSwitch setOn:YES animated:YES];
    }
    if ([[self.baseVC userInfoReaduserkey:@"brightScreenswitch"] isEqualToString:@"YES"]) {
        [self.myInfoBrightScreenSwitch setOn:YES animated:YES];
    }
    if ([[self.baseVC userInfoReaduserkey:@"switch"] isEqualToString:@"YES"]) {
        [self.myInfoAutomaticSwitch setOn:YES animated:YES];
    }
    if ([[self.baseVC userInfoReaduserkey:@"shockswitch"] isEqualToString:@"YES"]){
        [self.myInfoShockSwitch setOn:YES animated:YES];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - 摇一摇
- (IBAction)shakeSwitchAction:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    if (mySwitch.isOn){
        [self.baseVC userInfowriteuserkey:@"shakeswitch" uservalue:@"YES"];
    } else{
        [self.baseVC userInfowriteuserkey:@"shakeswitch" uservalue:@"NO"];
    }
}
#pragma mark -亮屏幕
- (IBAction)brightScreenSwitchAction:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    if (mySwitch.isOn){
        [self.baseVC userInfowriteuserkey:@"brightScreenswitch" uservalue:@"YES"];
    } else {
        [self.baseVC userInfowriteuserkey:@"brightScreenswitch" uservalue:@"NO"];
    }     
}
#pragma mark -自动
- (IBAction)automaticSwitchAction:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    SingleTon *ton = [SingleTon sharedInstance];
    [ton initialization];
    if (mySwitch.isOn){
        [self.baseVC userInfowriteuserkey:@"switch" uservalue:@"YES"];
        NSString *strUUid = SINGLE_TON_UUID_STR;
        if (!strUUid) {
            [ton startScan]; // 扫描
            return;
        }
        [ton getPeripheralWithIdentifierAndConnect:SINGLE_TON_UUID_STR];
        
    } else {
        [self.baseVC userInfowriteuserkey:@"switch" uservalue:@"NO"];
        [ton.manager stopScan];  //停止  扫描
    }
    
}
#pragma mark -震动
- (IBAction)shockSwitchAction:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    if (mySwitch.isOn){
        [self.baseVC userInfowriteuserkey:@"shockswitch" uservalue:@"YES"];
    } else {
        [self.baseVC userInfowriteuserkey:@"shockswitch" uservalue:@"NO"];
    }
}

@end
