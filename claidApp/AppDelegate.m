//
//  AppDelegate.m
//  claidApp
//
//  Created by kevinpc on 2016/10/18.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "AppDelegate.h"
#import "SingleTon.h"
#import "LoginViewController.h"
#import "MineViewController.h"
#import "MyViewController.h"
#import "CustomTabBarController.h"
#import "NetWorkJudge.h"
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [NetWorkJudge StartWithBlock:^(NSInteger NetworkStatus) {
        
        NSLog(@"--------------->%ld",NetworkStatus);        //网络 监测      
    }];
    NSString *uuidstr = [[NSUserDefaults standardUserDefaults] objectForKey:@"phoneNumber"];
    
    if (!uuidstr) {
        LoginViewController *loginViewController = [LoginViewController create];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
        navigationController.navigationBarHidden = YES;
        self.window.rootViewController = navigationController;
    } else {
        [[SingleTon sharedInstance] initialization];    // 蓝牙设备
         CustomTabBarController *customTabBarController = [self createCustomTabBarController];
        self.window.rootViewController = customTabBarController;
    }  
    [self.window makeKeyAndVisible];
    return YES;
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





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
 
}


- (void)applicationDidEnterBackground:(UIApplication *)application {

     NSLog(@"===============  进入后台");
    [[SingleTon sharedInstance] lanyaHoutaiAction];
    
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
     NSLog(@"===============  进入前台");
       [[SingleTon sharedInstance] lanyaQiantaiAction];     //前台函数
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
