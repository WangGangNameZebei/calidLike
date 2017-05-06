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
#import "ZLCGuidePageView.h"    //引导
#import "TTSwitch.h"



@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
   // [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];   // 后台运行次数

    
    [NetWorkJudge StartWithBlock:^(NSInteger NetworkStatus) {
        
        NSLog(@"--------------->%ld",(long)NetworkStatus);        //网络 监测
    }];
    [self ttSwitchAddImageAction];
    [[SingleTon sharedInstance] initialization];    // 蓝牙设备
   if (![[NSUserDefaults standardUserDefaults] objectForKey:@"lanyaAESData"]) {
       
        LoginViewController *loginViewController = [LoginViewController create];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
        navigationController.navigationBarHidden = YES;
        self.window.rootViewController = navigationController;
       
       //引导页图片数组
       NSArray *images =  @[[UIImage imageNamed:@"image1.jpg"],[UIImage imageNamed:@"image2.jpg"],[UIImage imageNamed:@"image3.jpg"],[UIImage imageNamed:@"image4.jpg"],[UIImage imageNamed:@"image5.jpg"]];
       //创建引导页视图
       ZLCGuidePageView *pageView = [[ZLCGuidePageView alloc]initWithFrame:self.window.frame WithImages:images];
       [self.window.rootViewController.view addSubview:pageView];

    } else {
        
         CustomTabBarController *customTabBarController = [self createCustomTabBarController];
        self.window.rootViewController = customTabBarController;
     }
    
      

    [self.window makeKeyAndVisible];
    [NSThread sleepForTimeInterval:1];  //启动时间  (空白页显示 的时间)
    return YES;
}
- (void)ttSwitchAddImageAction {
    [[TTSwitch appearance] setTrackImage:[UIImage imageNamed:@"round-switch-track.png"]];
    [[TTSwitch appearance] setOverlayImage:[UIImage imageNamed:@"round-switch-overlay"]];
    [[TTSwitch appearance] setTrackMaskImage:[UIImage imageNamed:@"round-switch-mask"]];
    [[TTSwitch appearance] setThumbImage:[UIImage imageNamed:@"round-switch-thumb"]];
    [[TTSwitch appearance] setThumbHighlightImage:[UIImage imageNamed:@"round-switch-thumb-highlight"]];
    [[TTSwitch appearance] setThumbMaskImage:[UIImage imageNamed:@"round-switch-mask"]];
    [[TTSwitch appearance] setThumbInsetX:-3.0f];
    [[TTSwitch appearance] setThumbOffsetY:-3.0f];
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
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"switch"] isEqualToString:@"YES"]) {
      [[SingleTon sharedInstance] lanyaQiantaiAction];     //前台函数
    }
    
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
   
}




#pragma mark - Background fetch related delegate
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"我就是传说中的Background Fetch💦");
    UILocalNotification * localNoti = [[UILocalNotification alloc] init];
    localNoti.hasAction = YES;
    //滑动来...
    NSArray * actionMsgs = @[@"查看一个巨大的秘密",@"看看小伙伴在做什么",@"看美女图片",@"领取奖品",@"看看洪哥在做什么",@"掏钱买下一个DropBeacon",@"请世文吃饭"];
    localNoti.alertAction = [actionMsgs objectAtIndex:arc4random()%actionMsgs.count];
    localNoti.alertBody = @"我就是传说中的Background Fetch💦";
    [[UIApplication sharedApplication] scheduleLocalNotification:localNoti];
    completionHandler(UIBackgroundFetchResultNewData);
}

@end
