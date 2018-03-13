//
//  MyInfoCommunityTableViewCell.m
//  claidApp
//
//  Created by Zebei on 2018/2/1.
//  Copyright © 2018年 kevinpc. All rights reserved.
//

#import "MyInfoCommunityTableViewCell.h"
#import "UIScreen+Utility.h"
#import "UIColor+Utility.h"
#import "SingleTon.h"

@implementation MyInfoCommunityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self selectButtonViewEdit];
    self.baseVC = [[BaseViewController alloc] init];
    [self switchViewEdit];
}

- (void)selectButtonViewEdit {
    self.myinfoNameArray =[NSMutableArray array];
    
    NSInteger selectNameNumber = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userNumber"] integerValue];  //查看 几个小区
    NSString * nameStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser"];               //记录当前小区
    for (NSInteger i = 0;i < selectNameNumber; i++) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)i] forKey:@"currentUser"]; //
        [self.myinfoNameArray addObject:[[BaseViewController alloc] userInfoReaduserkey:@"districtName"]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:nameStr forKey:@"currentUser"];    //恢复当前小区的存储
    
    float width=[UIScreen screenWidth] -150;
    self.selectNameView=[[SXSearchHeadView alloc] initWithFrame:CGRectMake(125, 0,width, 38) andDataSource:self.myinfoNameArray];
    __weak MyInfoCommunityTableViewCell *vc=self;
    
    //接受点击button时的下标
    self.selectNameView.titleBlock=^(NSInteger index){
        [vc showOrHiddenWhenTheValueChanged:index];
    };
    
    //接收点击cell时的消息
    //当headView的cell被点击时，收回tableView
    __weak SXSearchHeadView *view=self.selectNameView;
    
    self.selectNameView.selectBlock=^(NSString *str){
        [UIView animateWithDuration:.6 animations:^{
            float height=38;
            
            CGRect rect=view.frame;
            
            rect.size.height=height;
            
            view.frame=rect;
            
        }];
        
        [vc showInfoWithDynasty:view.dataButton.currentTitle];
    };
    
    [self addSubview:self.selectNameView];
}
//选择完成之后调用
- (void)showInfoWithDynasty:(NSString *)dynasty {
    NSLog(@"-------------%@",dynasty);
    
}
#pragma mark - 根据回调回来的index来改变headView的frame
-(void)showOrHiddenWhenTheValueChanged:(NSInteger)value{
    
    //    高度都是我随便写的，如有不同需要，比如数组的数据个数不一样，可以再调
    __block float height;
    /*
     加__block原因是：block块里面不可以对局部变量赋值。
     想要在block块里对局部变量赋值有两个方案：
     1.将局部变量升级为全局变量
     2.局部变量前加__block
     */
    
    //    当两次点击的是同一个按钮时，value为0
    if (value==0) {
        
        [UIView animateWithDuration:.3 animations:^{
            height=38;
            
            CGRect rect=self.selectNameView.frame;
            
            rect.size.height=height;
            
            self.selectNameView.frame=rect;
            
        }];
        
    }else if (value==100){
        
        if (self.selectNameView.dataButton.currentTitle) {
            
        }
        
        [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:.9 initialSpringVelocity:.5 options:0 animations:^{
            
            float height;
            if (self.myinfoNameArray.count > 6) {
               height=40 *self.myinfoNameArray.count + 40;
            } else {
              height=40 *self.myinfoNameArray.count + 40;
            }
            
            
            CGRect rect=self.selectNameView.frame;
            
            rect.size.height=height;
            
            self.selectNameView.frame=rect;
            
        } completion:nil];
    }
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
