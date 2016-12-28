//
//  installViewController.m
//  claidApp
//
//  Created by kevinpc on 2016/11/2.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "installViewController.h"
#import "installViewController+Configuration.h"
#import "MBProgressHUD.h"

@implementation installViewController

+ (instancetype) create {
    installViewController *installVC = [[installViewController alloc] initWithNibName:@"installViewController" bundle:nil];
    return installVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 点击  UItableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (IBAction)installReturnButtonAction:(id)sender {
    [[SingleTon sharedInstance] disConnection];  //断开蓝牙
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)scanLanyaButton:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.label.text = NSLocalizedString(@"扫秒蓝牙中...", @"HUD loading title");
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [[SingleTon sharedInstance] startScan]; // 扫描
        [self doSomeWork];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.iLanyaDataSource.lanyaNameArray = self.lanyaNameArray;
            self.iLanyaDelegate.lanyaNameArray = self.lanyaNameArray;
            [self.lanyaTableView reloadData];
            [hud hideAnimated:YES];
        });
    });

}
#pragma mark - Tasks
- (void)doSomeWork {
    // Simulate by just waiting.
    sleep(3.);
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
