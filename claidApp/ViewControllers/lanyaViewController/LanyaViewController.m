//
//  LanyaViewController.m
//  claidApp
//
//  Created by kevinpc on 2016/12/2.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "LanyaViewController.h"
#import "LanyaViewController+Configuration.h"
#import "MBProgressHUD.h"

@implementation LanyaViewController

+ (instancetype) create {
    LanyaViewController *lanyaVC = [[LanyaViewController alloc] initWithNibName:@"LanyaViewController" bundle:nil];
    return lanyaVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureViews];
}

// 点击  UItableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4) {
    
    } else if (indexPath.row == 1) {
        CBPeripheral *peripheral = [[SingleTon sharedInstance] lanyaNameString:[[NSUserDefaults standardUserDefaults] objectForKey:@"LanyaidentifierStr"]];
        [[SingleTon sharedInstance] shoudongConnectClick:peripheral];
    } else if (indexPath.row == 3) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.label.text = NSLocalizedString(@"扫秒蓝牙中...", @"HUD loading title");
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            [[SingleTon sharedInstance] startScan]; // 扫描
            [self doSomeWork];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.lanyaViewControllerDataSource.lanyaNameArray = self.lanyaNameHuoquArray;
                [self.lanyaTableView reloadData];
                [hud hideAnimated:YES];
            });
        });
 
    } else if (indexPath.row == (self.lanyaNameHuoquArray.count + 6)){
         [[SingleTon sharedInstance] disConnection];  //断开蓝牙
    } else {
         if  (indexPath.row != (self.lanyaNameHuoquArray.count + 5) && indexPath.row != (self.lanyaNameHuoquArray.count + 7)){
           CBPeripheral *periphe = [self.lanyaNameHuoquArray objectAtIndex:(indexPath.row - 5)];
                 [[NSUserDefaults standardUserDefaults] setObject:[periphe identifier].UUIDString forKey:@"LanyaidentifierStr"];
         
           
           [[SingleTon sharedInstance] shoudongConnectClick:periphe];
         }
    }
 
    
}

#pragma mark - Tasks

- (void)doSomeWork {
    // Simulate by just waiting.
    sleep(3.);
}
- (IBAction)returnButtonAction:(id)sender {
    
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
