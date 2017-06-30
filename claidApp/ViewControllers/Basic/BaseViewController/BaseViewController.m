//
//  BaseViewController.m
//  claidApp
//
//  Created by kevinpc on 2016/10/18.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import <SSKeychain.h>
#import <Masonry.h>
#import "UIScreen+Utility.h"
@implementation BaseViewController

+ (instancetype)create {
    NSAssert(false, @"-base view controller should never be created without subclass");
    return nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.customActionSheet setup];
    [self.view addSubview:self.customActionSheet];
    [self.customActionSheet makeConstraintWithLeft:0 top:0 right:0 bottom:0];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.customActionSheet = [CustomActionSheet create];
    }
    return self;
}
#pragma mark  提示框  两种
- (void)alertViewmessage:(NSString *)massage {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"  message:massage delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

- (void)alertViewDelegateString:(NSString *)stringMassage {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"版本提醒"  message:stringMassage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"是的", nil];
    [alertView show];

}
#pragma mark  提示框代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString *string = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",@"1219844769"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
    } else {
        NSLog(@"点击了取消按钮");
    }
}

- (void)hideTabBarAndpushViewController:(UIViewController *)viewController {
    [viewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (NSString *)keyChainIdentifierForVendorString {        //从钥匙串读取UUID：
    NSString *retrieveuuid = [SSKeychain passwordForService:@"zebei.claidApp.urthinker"account:@"user"];
    if (retrieveuuid.length == 0) {
        //给钥匙串中存UUID
        NSUUID *uuid1 = [UIDevice currentDevice].identifierForVendor;
        [SSKeychain setPassword: [NSString stringWithFormat:@"%@", uuid1]
                     forService:@"zebei.claidApp.urthinker"account:@"user"];
        retrieveuuid = [SSKeychain passwordForService:@"zebei.claidApp.urthinker"account:@"user"];
    }
    return retrieveuuid;
}

- (void)promptInformationActionWarningString:(NSString *)warningString {
    UIView *warningStr = [[UIView alloc] initWithFrame:CGRectMake(([UIScreen screenWidth] - 310 )/ 2  , ([UIScreen screenHeight]) / 2 + 50, 310, 60)];
    warningStr.backgroundColor = [UIColor blackColor];
    UILabel *warLabel = [[UILabel alloc] initWithFrame:warningStr.bounds];
    warLabel.textColor = [UIColor whiteColor];
    warLabel.text = warningString;
    warLabel.textAlignment = 1;
    [warningStr addSubview:warLabel];
    warningStr.alpha = .0f;
    [self.view addSubview:warningStr];
    
    [UIView animateWithDuration:2.0 delay:0.2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        warningStr.alpha = 1;
        
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [warningStr removeFromSuperview];
    }];
    
}

#pragma mark   创建数据库
- (void)createAdatabaseAction {
    self.baseTool = [DBTool sharedDBTool];
    NSArray *data = [self.baseTool selectWithClass:[UserInfo class] params:nil];
    if (data.count == 0){
        [self.baseTool createTableWithClass:[UserInfo class]];
    }
    
}
#pragma mark   用户信息写入
- (void)userInfowriteuserkey:(NSString *)userkey uservalue:(NSString *)uservalue{
    UserInfo *userIF = [UserInfo initUserkeystr:userkey uservaluestr:uservalue];
    
    [self.baseTool insertWithObj:userIF];
}
#pragma mark   用户信息读写
- (NSString *)userInfoReaduserkey:(NSString *)userkey{
    NSString * userkeystr;
    NSArray *data = [self.baseTool selectWithClass:[UserInfo class] params:[NSString stringWithFormat:@"_userkey = '%@'",userkey]];
    if (data.count != 0){
        UserInfo *userXI = data[0];
        userkeystr = userXI.userValue;
    } else{
        userkeystr = @"";
    }
    return userkeystr;
}
/*
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/


@end
