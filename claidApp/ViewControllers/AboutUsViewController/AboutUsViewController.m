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
    } else if (indexPath.row == 1) {
        MyFeedBackViewController *myfeedBackVC = [MyFeedBackViewController create];
        [self hideTabBarAndpushViewController:myfeedBackVC];
    } else if (indexPath.row == 2) {
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
                
    }  else {
        
        if (buttonIndex == alertView.firstOtherButtonIndex) {
            UITextField *nameField = [alertView textFieldAtIndex:0];
            
            
            if (nameField.tag == 10) {
                UITextField *dizhiField = [alertView textFieldAtIndex:1];
                
                self.dizhiString = [NSString stringWithFormat:@"%@%@",self.dizhiString,dizhiField.text];  //地址
                [self districtInfoPOSTNameStr:nameField.text dataStr:self.dizhiString];
            } else if (nameField.tag == 0) {
                [self districtInfoPOSTNameStr:nameField.text dataStr:@""];
                
            } else if (nameField.tag == 1) {
                self.dizhiString = [NSString stringWithFormat:@"%@%@",self.dizhiString,nameField.text];  //地址
                [self districtInfoPOSTNameStr:@"" dataStr:self.dizhiString];
            }
            
            
        }
        
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
