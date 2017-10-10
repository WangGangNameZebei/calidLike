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
#import "AESCrypt.h"
#import "LoginViewController+LogicalFlow.h"
#import "VisitorViewController.h"
#import "RetrieveThePasswordViewController.h"

@implementation LoginViewController

+ (instancetype)create {
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    return loginViewController;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}
//出现的时候调用
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)visitorButtonAction:(id)sender {
   VisitorViewController *visitorVC = [VisitorViewController create];
   [self hideTabBarAndpushViewController:visitorVC];
}

- (IBAction)loginButtonAction:(id)sender {
    if ([self isMobileNumber:self.phoneNumberTextField.text]){
       [self promptInformationActionWarningString:@"请输入正确的手机号码"];
        return;
    }
    if (self.passwordTextField.text.length < 6 || self.passwordTextField.text.length > 16){
      [self promptInformationActionWarningString:@"请输入6-16位密码!"];
        return;
    }
    [self requestLoginPostForUsername:self.phoneNumberTextField.text password:self.passwordTextField.text];
   
//      NSLog(@"从keyChain中取出的uuid-> %@",[self keyChainIdentifierForVendorString]);    // 获取钥匙串 的UUID

}
                                                                                                                                                                                  
- (IBAction)registerButtonAction:(id)sender {
     //[self promptInformationActionWarningString:@"此功能暂未开通！"];
      RegisterViewController *registerVC = [RegisterViewController create];
      [self hideTabBarAndpushViewController:registerVC];
}
//找回密码
- (IBAction)getbackPasswordButtonAction:(id)sender {
    RetrieveThePasswordViewController *retrieveVC = [RetrieveThePasswordViewController create];
    [self hideTabBarAndpushViewController:retrieveVC];
}

- (CustomTabBarController *)createCustomTabBarController {
    MineViewController *minViewController = [MineViewController create];
    MyViewController *myViewController = [MyViewController create];
    CustomTabBarController *customTabBarController = [[CustomTabBarController alloc] initWithControllers:@[minViewController, myViewController] andImageGroups:[self createTabBarGroups]];
    return customTabBarController;
}

- (NSArray *)createTabBarGroups {
    NSArray *titles = @[NSLocalizedString(@"主页", nil), NSLocalizedString(@"我的", nil),];
    NSArray *selectImages = @[@"homePage_blue", @"my_blue"];
    NSArray *unSelectImages = @[@"homePage_gray",@"my_gray"];
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
