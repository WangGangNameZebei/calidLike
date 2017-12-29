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
#import "CommunityViewController.h"
#import "ZLCGuidePageView.h"    //引导
#import <OpenShareHeader.h>


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [[SingleTon sharedInstance] initialization];    // 蓝牙设备
    //微信 ：注册key
    [OpenShare connectWeixinWithAppId:@"wx1d20477069cf97a6"];
   if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"loginInfo"] isEqualToString:@"YES"]) {    //   判断登录标识   是否登录   登录  直接进入 否则 到登录页面
       CustomTabBarController *customTabBarController = [self createCustomTabBarController];
       self.window.rootViewController = customTabBarController;
    } else {        
        LoginViewController *loginViewController = [LoginViewController create];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
        navigationController.navigationBarHidden = YES;
        self.window.rootViewController = navigationController;
//        //引导页图片数组
//        NSArray *images =  @[[UIImage imageNamed:@"image1.jpg"],[UIImage imageNamed:@"image2.jpg"],[UIImage imageNamed:@"image3.jpg"],[UIImage imageNamed:@"image4.jpg"],[UIImage imageNamed:@"image6.jpg"]];
//        //创建引导页视图
//        ZLCGuidePageView *pageView = [[ZLCGuidePageView alloc]initWithFrame:self.window.frame WithImages:images];
//        [self.window.rootViewController.view addSubview:pageView];
     }
    

    [self.window makeKeyAndVisible];
    [NSThread sleepForTimeInterval:1];  //启动时间  (空白页显示 的时间)
    return YES;
}

- (CustomTabBarController *)createCustomTabBarController {
    MineViewController *minViewController = [MineViewController create];
    CommunityViewController *communityViewController = [CommunityViewController create];
    MyViewController *myViewController = [MyViewController create];
    CustomTabBarController *customTabBarController = [[CustomTabBarController alloc] initWithControllers:@[minViewController,communityViewController, myViewController] andImageGroups:[self createTabBarGroups]];
    return customTabBarController;
}

- (NSArray *)createTabBarGroups {
    NSArray *titles = @[NSLocalizedString(@"主页", nil), NSLocalizedString(@"社区", nil), NSLocalizedString(@"我的", nil),];
    NSArray *selectImages = @[@"homePage_blue",@"community_blue", @"my_blue"];
    NSArray *unSelectImages = @[@"homePage_gray",@"community_gray",@"my_gray"];
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


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    //第二步：添加回调
    if ([OpenShare handleOpenURL:url]) {
        return YES;
    }
    //这里可以写上其他OpenShare不支持的客户端的回调，比如支付宝等。
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
 
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
   NSLog(@"===============  进入后台");
   [[SingleTon sharedInstance] lanyaHoutaiAction];
    
    UIApplication*   app = [UIApplication sharedApplication];
    __block  UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    });
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
   
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"===============  进入前台");
    NSString *strWitch = [[[BaseViewController alloc] init] userInfoReaduserkey:@"switch"];
    if ([strWitch isEqualToString:@"YES"]) {   //判断是否开启自动刷卡
      [[SingleTon sharedInstance] lanyaQiantaiAction];     //前台函数
    }
    
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
