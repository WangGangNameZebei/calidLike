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
#import <OpenShareHeader.h>
#import "BaseViewController.h"
#import <AFHTTPRequestOperationManager.h>
#import "InternetServices.h"        //网络服务


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
       [NetWorkJudge StartWithBlock:^(NSInteger NetworkStatus) {
           NSLog(@"%ld",(long)NetworkStatus);
           if(NetworkStatus >0){ //有网络
               [self loginPostForUsername:[[BaseViewController alloc] userInfoReaduserkey:@"userName"] password:[[BaseViewController alloc] userInfoReaduserkey:@"passWord"]];
           }
       }];
       
    } else {        
        LoginViewController *loginViewController = [LoginViewController create];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
        navigationController.navigationBarHidden = YES;
        self.window.rootViewController = navigationController;
        
        //引导页图片数组
        NSArray *images =  @[[UIImage imageNamed:@"image1.jpg"],[UIImage imageNamed:@"image2.jpg"],[UIImage imageNamed:@"image3.jpg"],[UIImage imageNamed:@"image4.jpg"],[UIImage imageNamed:@"image5.jpg"]];
        //创建引导页视图
        ZLCGuidePageView *pageView = [[ZLCGuidePageView alloc]initWithFrame:self.window.frame WithImages:images];
        [self.window.rootViewController.view addSubview:pageView];

     }
    

    [self.window makeKeyAndVisible];
    [NSThread sleepForTimeInterval:1];  //启动时间  (空白页显示 的时间)
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
//后台登陆
- (void)loginPostForUsername:(NSString *)username password:(NSString *)password {
   BaseViewController *baseVC = [[BaseViewController alloc] init];
    AFHTTPRequestOperationManager *manager = [self tokenManager];
    [manager.requestSerializer setValue:[baseVC userInfoReaduserkey:@"Token"] forHTTPHeaderField:@"access_token"];
    NSDictionary *parameters = @{@"accounts":username,@"passwd":password,@"imei":[baseVC keyChainIdentifierForVendorString]};
    [manager POST:RENEWAL_USER_DATA_URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSMutableArray *userdataArray;
        NSString *encryptedData;
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableContainers error:nil];
       
        if ([[resultDic objectForKey:@"status"] integerValue] == 200 ) {
            
            NSString *currentUserstr =[[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser"];
            NSMutableArray *dataArray= [resultDic objectForKey:@"data"];
            if ([currentUserstr integerValue] >= dataArray.count) {
                currentUserstr = [NSString stringWithFormat:@"%lu",(unsigned long)dataArray.count - 1];
            }
            [baseVC createAdatabaseAction];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",dataArray.count] forKey:@"userNumber"];// 存储 用户下小区的个数
            for (NSInteger i = 0; i <dataArray.count; i++) {
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)i] forKey:@"currentUser"]; // ／／存储 当前小区标识
                userdataArray = dataArray[i];
                encryptedData = [AESCrypt encrypt:[NSString stringWithFormat:@"%@",userdataArray[2]] password:AES_PASSWORD];  //加密
                [baseVC userInfowriteuserkey:@"lanyaAESData" uservalue:encryptedData]; //存储  刷卡数据
                [baseVC userInfowriteuserkey:@"userorakey" uservalue:[NSString stringWithFormat:@"%@",userdataArray[0]]];    //存储     推荐码
                
                [baseVC userInfowriteuserkey:@"districtNumber" uservalue:[NSString stringWithFormat:@"%@",userdataArray[1]]];       //存储  小区号
                [baseVC userInfowriteuserkey:@"districtName" uservalue:[NSString stringWithFormat:@"%@%@",userdataArray[3],userdataArray[4]]];       //存储  小区名称
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:currentUserstr forKey:@"currentUser"]; // 恢复之前存储
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 205){
            [InternetServices clearAllUserDefaultsData];
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"userNumber"];// 存储 用户下小区的个数
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"loginInfo"];  //登录标识
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"currentUser"]; //登录后默认 为第一个
            
        } else if ([[resultDic objectForKey:@"status"] integerValue] == 329) {      // Token  失效获取新的
            [InternetServices requestLoginPostForUsername:username password:password];
            
        } else {
            if([[resultDic objectForKey:@"status"] integerValue] != 203 && [[resultDic objectForKey:@"status"] integerValue] != 204 ){
               [InternetServices logOutPOSTkeystr:username];//退出登录
            }
        }

        
        

    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
    }];
}

- (AFHTTPRequestOperationManager *)tokenManager {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 设置请求格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    return manager;
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
