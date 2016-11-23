//
//  BaseViewController.m
//  claidApp
//
//  Created by kevinpc on 2016/10/18.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "BaseViewController.h"
#import <SSKeychain.h>

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

- (void)alertViewmessage:(NSString *)massage {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"  message:massage delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil];
    [alertView show];
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
