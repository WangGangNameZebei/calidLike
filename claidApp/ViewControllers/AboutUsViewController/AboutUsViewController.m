//
//  AboutUsViewController.m
//  claidApp
//
//  Created by Zebei on 2017/10/21.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "AboutUsViewController.h"
#import "AboutUsViewController+Configuration.m"
#import "MyFeedBackViewController.h"
#import <OpenShareHeader.h>
#import "AppTeachingViewController.h"
#import "AboutUsViewController+LogicalFlow.h"

@implementation AboutUsViewController
+ (instancetype)create {
    AboutUsViewController *aboutusViewController = [[AboutUsViewController alloc] initWithNibName:@"AboutUsViewController" bundle:nil];
    return aboutusViewController;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)returnButtonAction:(id)sender {
    [self.managementSingleTon disConnection];
     [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
// 点击  UItableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        AppTeachingViewController *appteachingVC = [AppTeachingViewController create];
        [self hideTabBarAndpushViewController:appteachingVC];
    } else if (indexPath.row == 2) {
        [self upgradeAppAction];
    }else if (indexPath.row == 1) {
        MyFeedBackViewController *myfeedBackVC = [MyFeedBackViewController create];
        [self hideTabBarAndpushViewController:myfeedBackVC];
    } else if (indexPath.row == 3) {
        self.ablouusAlertView = [[UIAlertView alloc] initWithTitle:@"软件分享" message:@"云梯控请求打开微信？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"允许", nil];
        self.ablouusAlertView.tag = 1;
        [self.ablouusAlertView show];
    } else {
        [self manageApplicationsEdits];  //处理管理申请
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    self.ablouusAlertView =nil;
    if (buttonIndex == alertView.firstOtherButtonIndex && alertView.tag == 1) {
        OSMessage *msg=[[OSMessage alloc]init];
        msg.title = @"扫一扫下载云梯控";
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ytkappOpenShare" ofType:@"png"];
        NSData *imageData = [NSData dataWithContentsOfFile:filePath];
        msg.image =  imageData;
        msg.thumbnail=imageData;
        [OpenShare shareToWeixinSession:msg Success:^(OSMessage *message) {
            NSLog(@"微信分享到会话成功：\n%@",message);
        } Fail:^(OSMessage *message, NSError *error) {
            NSLog(@"微信分享到会话失败：\n%@\n%@",error,message);
        }];
                
    } 
}

#pragma mark检测升级
- (void)upgradeAppAction {
    static NSString *appId = @"1219844769";
    // 返回是否有新版本
    BOOL update = [self checkAppStoreVersionWithAppId:appId];
    // 添加自己的代码 可以弹出一个提示框 这里不实现了
    if (update) {
        [self alertViewDelegateString:@"有新的版本可供检测,是否升级?"];
    } else {
        [self alertViewmessage:@"已经是最新的版本!"];
    }
}
#pragma mark -  检测 版本 号 是否升级
- (BOOL)checkAppStoreVersionWithAppId:(NSString *)appId {
    
    // MARK: 拼接链接，转换成URL
    NSString *checkUrlString = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@", appId];
    NSURL *checkUrl = [NSURL URLWithString:checkUrlString];
    // MARK: 获取网路数据AppStore上app的信息
    NSString *appInfoString = [NSString stringWithContentsOfURL:checkUrl encoding:NSUTF8StringEncoding error:nil];
    // MARK: 字符串转json转字典
    NSError *error = nil;
    if (appInfoString.length < 5 ){
        return NO;
    }
    NSData *JSONData = [appInfoString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *appInfo = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:&error];
    if (!error && appInfo) {
        NSArray *resultArr = appInfo[@"results"];
        NSDictionary *resultDic = resultArr.firstObject;
        // 版本号
        NSString *version = resultDic[@"version"];
        // 下载地址
        //  NSString   trackViewUrl = resultDic[@"trackViewUrl"];
        // FRXME：比较版本号
        
        BOOL upnumber = [self compareVersion:version];
        return upnumber;
    }else {
        // 返回错误 想当于没有更新吧
        return NO;
    }
    
}


- (BOOL)compareVersion:(NSString *)serverVersion {
    // 获取当前版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    // MARK： 比较方法
    if ([appVersion compare:serverVersion options:NSNumericSearch] == NSOrderedAscending) {
        return YES;
    } else {
        return NO;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
