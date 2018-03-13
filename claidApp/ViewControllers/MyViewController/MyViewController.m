//
//  MyViewController.m
//  claidApp
//
//  Created by kevinpc on 2016/10/18.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "MyViewController.h"
#import "MyViewController+Configuration.h"
#import "installViewController.h"
#import "MyViewController+Animation.h"
#import "MyViewController+LogicalFlow.h"
#import "VisitorViewController.h"
#import "invitaionCodeViewController.h"
#import "MycradInfoViewController.h"
#import "PropertyActivationViewController.h"
#import "ChangeThePasswordViewController.h"
#import "AboutUsViewController.h"
#import "LoginViewController.h"
#import "CommunityManagementViewController.h" //  园区管理

@implementation MyViewController

+ (instancetype) create {
    MyViewController *myViewController = [[MyViewController alloc] initWithNibName:@"MyViewController" bundle:nil];
    return myViewController;  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}
//进来走的函数
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self myTableViewInitdataArray];
    [self.myTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 点击  UItableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     if([[self userInfoReaduserkey:@"role"] isEqualToString:@"1"]){
         if (indexPath.row == 0){  // 续卡
             PropertyActivationViewController *pAViewController = [PropertyActivationViewController create];
             pAViewController.transitioningDelegate = self;
             [self addScreenLeftEdgePanGestureRecognizer:pAViewController.view];
             [self presentViewController:pAViewController animated:YES completion:nil];            
         } else if (indexPath.row == 1){       //社区管理
             CommunityManagementViewController *communityManagementVC = [CommunityManagementViewController create];
             communityManagementVC.transitioningDelegate = self;
             [self addScreenLeftEdgePanGestureRecognizer:communityManagementVC.view];
             [self presentViewController:communityManagementVC animated:YES completion:nil];
         } else if (indexPath.row == 4) {   //卡信息
             MycradInfoViewController *mycradinfoVC = [MycradInfoViewController create];
             mycradinfoVC.transitioningDelegate = self;
             [self addScreenLeftEdgePanGestureRecognizer:mycradinfoVC.view];
            [self presentViewController:mycradinfoVC animated:YES completion:nil];
         } else if (indexPath.row == 3 || indexPath.row == 10 || indexPath.row == 12) {
             NSLog(@"空白区");
         } else if (indexPath.row == 5){        // 邀请访客
             invitaionCodeViewController *inviCodeVC = [invitaionCodeViewController create];
             [self hideTabBarAndpushViewController:inviCodeVC];
             
         } else if (indexPath.row == 6){     // 我是 访客
             VisitorViewController *visitor = [VisitorViewController create];
             [self hideTabBarAndpushViewController:visitor];
         } else if (indexPath.row == 2) {     //物业设置
             installViewController *installVC = [installViewController create];
             [self hideTabBarAndpushViewController:installVC];
             
         } else if (indexPath.row == 7){        // 密码修改
             ChangeThePasswordViewController *changethePasswordVC = [ChangeThePasswordViewController create];
             [self hideTabBarAndpushViewController:changethePasswordVC];
         } else if (indexPath.row == 8) {        // 数据更新
             [self theinternetCardupData];
         } else if (indexPath.row == 9) {       // 关于我们
             AboutUsViewController *aboutUsVC = [AboutUsViewController create];
             [self hideTabBarAndpushViewController:aboutUsVC];
         } else if (indexPath.row == 11) {        //退出登入
             self.customAlertView = [[UIAlertView alloc] initWithTitle:@"退出登录" message:@"退出登录会删除您的所有信息，确定退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
             self.customAlertView.tag = 2;
             [self.customAlertView show];
         } else {
             [self promptInformationActionWarningString:@"此功能暂未开通!"];
         }

     } else {
          if (indexPath.row == 0) {   //卡信息
              MycradInfoViewController *mycradinfoVC = [MycradInfoViewController create];
              mycradinfoVC.transitioningDelegate = self;
              [self addScreenLeftEdgePanGestureRecognizer:mycradinfoVC.view];
              [self presentViewController:mycradinfoVC animated:YES completion:nil];
         } else if (indexPath.row == 6 || indexPath.row == 8) {
             NSLog(@"空白区");
         } else if (indexPath.row == 1){        // 邀请访客
             invitaionCodeViewController *inviCodeVC = [invitaionCodeViewController create];
             [self hideTabBarAndpushViewController:inviCodeVC];
             
         } else if (indexPath.row == 2){     // 我是 访客
             VisitorViewController *visitor = [VisitorViewController create];
             [self hideTabBarAndpushViewController:visitor];
         } else if (indexPath.row == 3){        // 密码修改
             ChangeThePasswordViewController *changethePasswordVC = [ChangeThePasswordViewController create];
             [self hideTabBarAndpushViewController:changethePasswordVC];
         } else if (indexPath.row == 4) {        // 数据更新
             [self theinternetCardupData];
         } else if (indexPath.row == 5) {       // 关于我们
             AboutUsViewController *aboutUsVC = [AboutUsViewController create];
             [self hideTabBarAndpushViewController:aboutUsVC];
         } else if (indexPath.row == 7) {        //退出登入
             self.customAlertView = [[UIAlertView alloc] initWithTitle:@"退出登录" message:@"退出登录会删除您的所有信息，确定退出？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
             self.customAlertView.tag = 2;
             [self.customAlertView show];
         } else {
             [self promptInformationActionWarningString:@"此功能暂未开通!"];
         }

     }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == alertView.firstOtherButtonIndex && alertView.tag == 2) {
        [InternetServices logOutPOSTkeystr:[self userInfoReaduserkey:@"userName"]];
    }
    
}
- (void)addScreenLeftEdgePanGestureRecognizer:(UIView *)view{
    UIScreenEdgePanGestureRecognizer *screenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
    screenEdgePan.edges = UIRectEdgeLeft;
    [view addGestureRecognizer:screenEdgePan];
}

- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)edgePan{
    CGFloat progress = fabs([edgePan translationInView:[UIApplication sharedApplication].keyWindow].x/[UIApplication sharedApplication].keyWindow.bounds.size.width);
    if (edgePan.state == UIGestureRecognizerStateBegan) {
        self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        if (edgePan.edges == UIRectEdgeLeft) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }else if (edgePan.state == UIGestureRecognizerStateChanged){
        [self.percentDrivenTransition updateInteractiveTransition:progress];
    }else if (edgePan.state == UIGestureRecognizerStateEnded || edgePan.state == UIGestureRecognizerStateCancelled){
        if (progress > 0.5) {
            [_percentDrivenTransition finishInteractiveTransition];
        }else{
            [_percentDrivenTransition cancelInteractiveTransition];
        }
        _percentDrivenTransition = nil;
    }
}


#pragma Mark - UIViewControllerTransitioningDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[PresentTransitionAnimated alloc] init];
}
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[DismissTransitionAnimated alloc] init];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _percentDrivenTransition;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _percentDrivenTransition;
}


@end
