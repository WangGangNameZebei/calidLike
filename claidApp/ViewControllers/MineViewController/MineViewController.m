//
//  MineViewController.m
//  claidApp
//
//  Created by kevinpc on 2016/10/18.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "MineViewController.h"
#import "MineViewController+Configuration.h"

@implementation MineViewController

+ (instancetype)create {
    MineViewController *minViewController = [[MineViewController alloc] initWithNibName:@"MineViewController" bundle:nil];
    return minViewController;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureViews];
}

//出现的时候调用
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 点击  UItableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

     if (indexPath.section < self.peripherArray.count) {
         CBPeripheral *periphe = [self.peripherArray objectAtIndex:indexPath.section];
         [[NSUserDefaults standardUserDefaults] setObject:[periphe identifier].UUIDString forKey:@"identifierStr"];
         [[SingleTon sharedInstance] shoudongConnectClick:periphe];
     } else  {
         [[SingleTon sharedInstance] disConnection];  //断开蓝牙
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
