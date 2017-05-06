//
//  PropertyActivationViewController.m
//  claidApp
//
//  Created by kevinpc on 2017/5/3.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "PropertyActivationViewController.h"
#import "PropertyActivationViewController+Configuration.h"
#import "MBProgressHUD.h"

@implementation PropertyActivationViewController

+ (instancetype) create {
    PropertyActivationViewController *properActionVC = [[PropertyActivationViewController alloc] initWithNibName:@"PropertyActivationViewController" bundle:nil];
    return properActionVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)saoMiaoButtonAction:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.label.text = NSLocalizedString(@"扫秒蓝牙中...", @"HUD loading title");
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [self.paSingleTon startScan]; // 扫描
        [self doSomeWork];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.propertyActionViewControllerDataSource.pAVCDataSourceArray = self.paLnyaNameArray;
           [self.paVCTableiVew reloadData];
            [hud hideAnimated:YES];
        });
    });

    
}
- (IBAction)returnButtonAction:(id)sender {
    [self.paSingleTon disConnection];       // 退出前 断开蓝牙
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mrak - UItavleView-delegate- 点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        CBPeripheral *periphe = [self.paLnyaNameArray objectAtIndex:(indexPath.row)];

        [self.paSingleTon connectClick:periphe];
}

#pragma mark - Tasks
- (void)doSomeWork {
    // Simulate by just waiting.
    sleep(3.);
}

@end
