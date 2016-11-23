//
//  LoginViewController.m
//  claidApp
//
//  Created by kevinpc on 2016/10/31.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewController+Configuration.h"
#import "RegisterViewController.h"
#import "MineViewController.h"
#import "MyViewController.h"
#import "CustomTabBarController.h"

@implementation LoginViewController

+ (instancetype)create {
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    return loginViewController;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButtonAction:(id)sender {
   // [[NSUserDefaults standardUserDefaults] setObject:self.phoneNumberTextField.text forKey:@"phoneNumber"];    //   登录成功之后  要储存
    
    [[SingleTon sharedInstance] initialization];    // 蓝牙设备
    CustomTabBarController *customTabBarController = [self createCustomTabBarController];
    UIApplication.sharedApplication.delegate.window.rootViewController = customTabBarController;
    
      NSLog(@"从keyChain中取出的uuid-> %@",[self keyChainIdentifierForVendorString]);    // 获取钥匙串 的UUID

}
                                                                                                                                                                                  
- (IBAction)registerButtonAction:(id)sender {
    RegisterViewController *registerVC = [RegisterViewController create];
    [self hideTabBarAndpushViewController:registerVC];
}


- (CustomTabBarController *)createCustomTabBarController {
    MineViewController *minViewController = [MineViewController create];
    MyViewController *myViewController = [MyViewController create];
    CustomTabBarController *customTabBarController = [[CustomTabBarController alloc] initWithControllers:@[minViewController, myViewController] andImageGroups:[self createTabBarGroups]];
    return customTabBarController;
}

- (NSArray *)createTabBarGroups {
    NSArray *titles = @[NSLocalizedString(@"主页", nil), NSLocalizedString(@"我的", nil),];
    NSArray *selectImages = @[@"zhuye_1.png", @"wode_1.png"];
    NSArray *unSelectImages = @[@"zhuye_2",@"wode_2.png"];
    NSMutableArray *imageGroups = [[NSMutableArray alloc] init];
    for (int i = 0; i < titles.count; i++) {
        TabBarItemImageGroup *imageGroup = [[TabBarItemImageGroup alloc] init];
        imageGroup.title = [titles objectAtIndex:i];
        imageGroup.selectImage = [selectImages objectAtIndex:i];
        imageGroup.unSelectImage = [unSelectImages objectAtIndex:i];
        [imageGroups addObject:imageGroup];
    }
    return imageGroups;
}

@end
